import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode, defaultTargetPlatform, TargetPlatform;
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../providers/home_providers.dart';
import '../l10n/app_localizations.dart';
import '../models/app_scope.dart';
import '../routes.dart';

class ChatMessage {
  final String sender; // 'user' or 'bot'
  final String text;
  final DateTime time;

  ChatMessage({
    required this.sender,
    required this.text,
    required this.time,
  });
}

class ChatSession {
  String id;
  String title;
  List<ChatMessage> messages;

  ChatSession({required this.id, required this.title, required this.messages});
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'messages': messages.map((m) => {
      'text': m.text,
      'sender': m.sender,
      'time': m.time.toIso8601String(),
    }).toList(),
  };

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['id'],
      title: json['title'],
      messages: (json['messages'] as List).map((msg) => ChatMessage(
        text: msg['text'],
        sender: msg['sender'],
        time: DateTime.parse(msg['time']),
      )).toList(),
    );
  }
}

class AIPlannerScreen extends ConsumerStatefulWidget {
  const AIPlannerScreen({super.key});

  @override
  ConsumerState<AIPlannerScreen> createState() => _AIPlannerScreenState();
}

class _AIPlannerScreenState extends ConsumerState<AIPlannerScreen> {
  List<ChatMessage> _messages = [];
  List<ChatSession> _sessions = [];
  String _currentSessionId = '';
  
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final Dio _dio = Dio();
  bool _isTyping = false;
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _hasTypedText = false;

  List<String> _quickQueries(BuildContext context) {
    final scope = AppScope.of(context);
    return [
      scope.t('aiPlanner_quickQuery1'),
      scope.t('aiPlanner_quickQuery2'),
      scope.t('aiPlanner_quickQuery3'),
      scope.t('aiPlanner_quickQuery4'),
      scope.t('aiPlanner_quickQuery5'),
    ];
  }

  Map<String, String> _fallbackResponses(BuildContext context) {
    final scope = AppScope.of(context);
    return {
      'density': scope.t('aiPlanner_responseDensity'),
      'cafe': scope.t('aiPlanner_responseCafe'),
      'parking': scope.t('aiPlanner_responseParking'),
      'evening': scope.t('aiPlanner_responseEvening'),
      'jordan': scope.t('aiPlanner_responseJordan'),
      'offtopic': scope.t('aiPlanner_responseOfftopic'),
      'default': scope.t('aiPlanner_responseDefault'),
    };
  }

  String _welcomeText(BuildContext context) => AppScope.of(context).t('aiPlanner_welcome');

  @override
  void initState() {
    super.initState();
    _loadSavedChat();
    
    _inputController.addListener(() {
      final isNotEmpty = _inputController.text.isNotEmpty;
      if (_hasTypedText != isNotEmpty) {
        setState(() {
          _hasTypedText = isNotEmpty;
        });
      }
    });
  }

  Future<void> _loadSavedChat() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedJson = prefs.getString('saved_ai_sessions');
    
    if (savedJson != null) {
      try {
        final List<dynamic> decodedList = jsonDecode(savedJson);
        setState(() {
          _sessions = decodedList.map((s) => ChatSession.fromJson(s)).toList();
        });
      } catch (e) {
        debugPrint("Error loading chat history: $e");
      }
    }
    
    // Clean up abandoned empty sessions to avoid clutter
    _sessions.removeWhere((s) => s.messages.length <= 1 && s.title == 'New Conversation');
    _createNewSession();
  }

  void _deleteSession(ChatSession session) {
    setState(() {
      _sessions.removeWhere((s) => s.id == session.id);
      if (_currentSessionId == session.id) {
        if (_sessions.isNotEmpty) {
          _currentSessionId = _sessions.first.id;
          _messages = List.from(_sessions.first.messages);
        } else {
          _createNewSession();
        }
      }
    });
    _saveChatToDevice();
  }

  void _showRenameDialog(ChatSession session) {
    final TextEditingController controller = TextEditingController(text: session.title);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rename Conversation'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter new title'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                setState(() {
                  session.title = controller.text.trim();
                });
                _saveChatToDevice();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      }
    );
  }

  void _createNewSession() {
    setState(() {
      _currentSessionId = DateTime.now().millisecondsSinceEpoch.toString();
      _messages = [
        ChatMessage(
          sender: 'bot',
          text: '', // Set in build step depending on state
          time: DateTime.now(),
        )
      ];
      _sessions.insert(0, ChatSession(
        id: _currentSessionId,
        title: 'New Conversation',
        messages: List.from(_messages),
      ));
    });
    _saveChatToDevice();
  }

  Future<void> _saveChatToDevice() async {
    final sessionIndex = _sessions.indexWhere((s) => s.id == _currentSessionId);
    if (sessionIndex != -1) {
      _sessions[sessionIndex].messages = List.from(_messages);
      
      // Auto-generate title if it's still "New Conversation"
      if (_sessions[sessionIndex].title == 'New Conversation' && _messages.length > 1) {
        final firstUserMsg = _messages.firstWhere((m) => m.sender == 'user', orElse: () => _messages[1]);
        String title = firstUserMsg.text;
        if (title.length > 30) title = title.substring(0, 30) + '...';
        _sessions[sessionIndex].title = title;
      }
    }

    final prefs = await SharedPreferences.getInstance();
    final encodedJson = jsonEncode(_sessions.map((s) => s.toJson()).toList());
    await prefs.setString('saved_ai_sessions', encodedJson);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // Get cross-platform resolved backend URL safely
  String _getApiUrl() {
    const String publicRemoteUrl = 'https://ais-pre-lg56mswi5rtgmn3qnpm52h-588737727556.europe-west1.run.app/api/chat';
    if (kIsWeb) {
      try {
        final uri = Uri.base;
        final host = uri.host.toLowerCase();

        // If running locally, point to the local dev server
        if (host == 'localhost' ||
            host == '127.0.0.1' ||
            host == '0.0.0.0' ||
            host.isEmpty) {
          return 'http://localhost:3000/api/chat';
        }

        final scheme = uri.scheme.isNotEmpty ? uri.scheme : 'https';
        final port = uri.port;
        final portStr = (port != 0 && port != 80 && port != 443) ? ':$port' : '';
        return '$scheme://$host$portStr/api/chat';
      } catch (e) {
        debugPrint("Error resolving Uri.base: $e");
      }
      return publicRemoteUrl;
    }

    // When testing on iOS Simulator / Android Emulator / macOS / Linux / Windows in Debug Mode
    if (kDebugMode) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return 'http://10.0.2.2:3000/api/chat';
      } else {
        return 'http://127.0.0.1:3000/api/chat';
      }
    }

    // Production mobile app fallback URL pointing to the public shared applet URL
    return publicRemoteUrl;
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  bool _isLocalHost() {
    if (kIsWeb) {
      try {
        final host = Uri.base.host.toLowerCase();
        return host == 'localhost' ||
            host == '127.0.0.1' ||
            host == '0.0.0.0' ||
            host.isEmpty ||
            host.startsWith('192.168.') ||
            host.startsWith('10.') ||
            host.startsWith('172.');
      } catch (_) {}
    }
    return kDebugMode;
  }

  static const String _systemInstruction = '''
You are أبو العريف (Abu Al-Areef), the AXN Smart City AI Co-Pilot, a highly polished, helpful, and interactive smart assistant designed for the Prince Al Hussein Stadium and Jordan exploration app.

Your primary capabilities:
1. HELP PLANNING EVENINGS:
   - Suggest fantastic itineraries, dinners, cafes, and scenic sunset/night spots.
   - Recommend trying traditional Jordan food: Mansaf (منسف), Knafeh (كنافة) from Habibah in Amman downtown, mixed grills, and traditional mint tea or cardamom coffee.
   - Recommend places in Amman (Rainbow Street, Weibdeh, Citadel at sunset), Salt (historic streets, Al-Khader church, scenic viewpoints), or Aqaba.

2. HELP WITH THE STADIUM (Prince Al Hussein Stadium):
   - Provide smart guidance on crowd density (Gate 1 is currently crowded/moderate with ~17k visitors; Gate 3 is extremely clear and recommended for fast exits).
   - Help find parking: Zone B Slot 42 is the user's active synchronized parking spot, best reached via Sector C exits.
   - Suggest facilities: Mention "Al-Waha Rooftop Cafe" (مقهى الواحة العلوي) for a beautiful stadium view and cardamom coffee, or nearby rest stops.
   - Stadium capacity is 25,000; active visitors count is around 17,842 (71.4% occupancy).

3. PLACES TO VISIT IN JORDAN:
   - Recommend world-famous sites in Jordan with great cultural depth:
     * Petra: The rose-red Nabataean city, Treasury, Monastery, and Petra by Night experience.
     * Wadi Rum: The Valley of the Moon, stargazing, Bedouin bubble camps, jeep safaris, Martian-like red deserts.
     * Dead Sea: Floating in hypersaline water, therapeutic black mud, lowest point on Earth.
     * Jerash: Beautifully preserved ancient Roman ruins, theaters, and temples.
     * Ajloun: Lush green oak forests and the 12th-century Ajloun Castle.
     * Aqaba: Pristine Red Sea diving, coral reefs, and warm coastal vibes.
     * Amman Citadel & Roman Theater: Splendid panoramic viewpoints overlooking the ancient hills of the capital.

TONE & BEHAVIOR:
- Respond in the language of the user's message. If they write in Arabic, respond in clear, hospitable, and friendly Arabic (عربي). If they write in English, write in warm, elegant English.
- Always be incredibly welcoming, professional, and smart. Keep your formatting highly structured using clean markdown, bullet points, and short readable paragraphs to look perfect in a mobile screen chat.
- Since you are integrated into a real mobile app, make recommendations feel real-time and context-aware.
''';

  Future<void> _sendMessage(String text, String lang) async {
    if (text.trim().isEmpty) return;

    final userMsg = ChatMessage(
      sender: 'user',
      text: text,
      time: DateTime.now(),
    );

    setState(() {
      _messages.add(userMsg);
      _inputController.clear();
      _isTyping = true;
    });
    _saveChatToDevice();
    _scrollToBottom();

    // Check if client-side Groq API key is configured
    final clientApiKey = ref.read(groqApiKeyProvider);
    
    String activeInstruction = _systemInstruction;    final weatherState = ref.read(weatherProvider).valueOrNull;
    if (weatherState?.temperature != null && weatherState?.humidity != null) {
      activeInstruction += '\n\nCURRENT REAL-TIME WEATHER OUTSIDE IN AMMAN:\n- Temperature out: ${weatherState!.temperature}°C\n- Humidity out: ${weatherState.humidity}%\n\n(Take this outdoor weather into consideration when suggesting activities to the user).';
    }

    try {
      if (clientApiKey.isNotEmpty) {
        // Direct Client-Side Groq API Call (OpenAI-compatible endpoint)
        final response = await _dio.post(
          'https://api.groq.com/openai/v1/chat/completions',
          data: {
            'model': 'allam-2-7b',
            'messages': [
              {'role': 'system', 'content': activeInstruction},
              ..._messages.map((m) {
                return {
                  'role': m.sender == 'user' ? 'user' : 'assistant',
                  'content': m.text,
                };
              }),
            ],
            'temperature': 0.7,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $clientApiKey',
              'Content-Type': 'application/json',
            },
            receiveTimeout: const Duration(seconds: 40),
            sendTimeout: const Duration(seconds: 40),
          ),
        );

        if (response.statusCode == 200 && response.data != null) {
          final choices = response.data['choices'] as List?;
          if (choices != null && choices.isNotEmpty) {
            final message = choices[0]['message'];
            if (message != null) {
              final botText = message['content'] ?? '';
              if ((botText as String).isNotEmpty) {
                setState(() {
                  _messages.add(ChatMessage(
                    sender: 'bot',
                    text: botText,
                    time: DateTime.now(),
                  ));
                  _isTyping = false;
                });
                _saveChatToDevice();
                _scrollToBottom();
                return; // Direct client-side chat succeeded
              }
            }
          }
        }
        throw Exception("Invalid Groq API response format");
      }

      // No API key -> Fall back to Server Proxy Chat Endpoint
      final apiUrl = _getApiUrl();

      // Setup history formatted for the proxy backend
      final historyPayload = _messages.take(_messages.length - 1).map((m) {
        return {
          'role': m.sender == 'user' ? 'user' : 'model',
          'text': m.text,
        };
      }).toList();

      final response = await _dio.post(
        apiUrl,
        data: {
          'message': text,
          'history': historyPayload,
          'lang': lang,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status != null && status < 500,
          receiveTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 15),
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final botText = response.data['text'] ?? '';
        setState(() {
          _messages.add(ChatMessage(
            sender: 'bot',
            text: botText,
            time: DateTime.now(),
          ));
          _isTyping = false;
        });
        _saveChatToDevice();
      } else {
        debugPrint("Server responded with non-200 status code: ${response.statusCode}");
        throw Exception("Server non-200 response (${response.statusCode})");
      }
    } catch (e) {
      debugPrint("API Error, falling back to local simulated response: $e");

      // Simulated Fallback Responses
      await Future.delayed(const Duration(milliseconds: 1200));

      final lowerText = text.toLowerCase();
      final responses = _fallbackResponses(context);
      String reply = responses['default']!;

      if (lowerText.contains('gate') || lowerText.contains('density') || lowerText.contains('بوابة') || lowerText.contains('كثافة')) {
        reply = responses['density']!;
      } else if (lowerText.contains('cafe') || lowerText.contains('coffee') || lowerText.contains('مقهى') || lowerText.contains('قهوة')) {
        reply = responses['cafe']!;
      } else if (lowerText.contains('park') || lowerText.contains('car') || lowerText.contains('سيارة') || lowerText.contains('موقف')) {
        reply = responses['parking']!;
      } else if (lowerText.contains('evening') || lowerText.contains('night') || lowerText.contains('أمسية') || lowerText.contains('عشاء')) {
        reply = responses['evening']!;
      } else if (lowerText.contains('visit') || lowerText.contains('jordan') || lowerText.contains('مكان') || lowerText.contains('أماكن') || lowerText.contains('الأردن')) {
        reply = responses['jordan']!;
      }

      setState(() {
        _messages.add(ChatMessage(
          sender: 'bot',
          text: reply,
          time: DateTime.now(),
        ));
        _isTyping = false;
      });
      _saveChatToDevice();
    }
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final lang = scope.lang;
    final clientApiKey = ref.watch(groqApiKeyProvider);
    final isAr = scope.isArabic;
    final isLight = Theme.of(context).brightness != Brightness.dark;

    final textP = AppColors.getTextP(isLight);
    final textS = AppColors.getTextS(isLight);
    final cardBg = AppColors.getSurf(isLight);
    final border = AppColors.getBorder(isLight);

    final quickQueries = _quickQueries(context);
    final welcomeText = _welcomeText(context);

    // Ensure the initial welcome message has the correct language text
    if (_messages.isNotEmpty && _messages[0].sender == 'bot' && _messages[0].text.isEmpty) {
      _messages[0] = ChatMessage(
        sender: 'bot',
        text: welcomeText,
        time: _messages[0].time,
      );
      _saveChatToDevice();
    } else if (_messages.isNotEmpty && _messages[0].sender == 'bot' &&
               _messages[0].text == welcomeText) {
      // Dynamic welcome language sync without breaking user history
      _messages[0] = ChatMessage(
        sender: 'bot',
        text: welcomeText,
        time: _messages[0].time,
      );
    }
    
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Directionality(
        textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
        child: Drawer(
          backgroundColor: AppColors.getBg(isLight),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppTokens.space16),
                  child: Text(
                    'Chat History',
                    style: TextStyle(
                      color: textP,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Divider(color: border, height: 1),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _sessions.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return ListTile(
                          leading: Icon(Icons.add_rounded, color: textP, size: 20),
                          title: Text('New Conversation', style: TextStyle(color: textP, fontSize: 13, fontWeight: FontWeight.w600)),
                          onTap: () {
                            _createNewSession();
                            Navigator.pop(context);
                          },
                        );
                      }
                      
                      final session = _sessions[index - 1];
                      final isSelected = session.id == _currentSessionId;
                      
                      return ListTile(
                        leading: Icon(Icons.chat_bubble_outline_rounded, color: isSelected ? AppColors.primary : textP, size: 20),
                        title: Text(session.title, style: TextStyle(color: isSelected ? AppColors.primary : textP, fontSize: 13, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                        onTap: () {
                          setState(() {
                            _currentSessionId = session.id;
                            _messages = List.from(session.messages);
                          });
                          Navigator.pop(context);
                        },
                        trailing: PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert_rounded, color: textS, size: 16),
                          onSelected: (value) {
                            if (value == 'rename') {
                              _showRenameDialog(session);
                            } else if (value == 'delete') {
                              _deleteSession(session);
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(value: 'rename', child: Text('Rename')),
                            const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.getBg(isLight),
      body: Directionality(
        textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
        child: Stack(
          children: [
            // Background design glow accents (only for Dark Mode aesthetic)
            if (!isLight) ...[
              Positioned(
                top: -80,
                right: -80,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.08),
                  ),
                ),
              ),
              Positioned(
                bottom: 120,
                left: -100,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.dangerGlow.withOpacity(0.04),
                  ),
                ),
              ),
            ],

            // Column Contents
            SafeArea(
              child: Column(
                children: [
                  // 1. HEADER SECTION
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTokens.space16,
                      vertical: AppTokens.space12,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: border, width: 0.8),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Drawer Menu Icon (3 bars)
                        GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: isLight ? Colors.black.withOpacity(0.04) : Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
                              border: Border.all(color: border),
                            ),
                            child: Icon(
                              Icons.menu_rounded,
                              color: textP,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppTokens.space12),

                        // Back Icon
                        GestureDetector(
                          onTap: () {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            } else {
                              Navigator.of(context).pushNamedAndRemoveUntil(Routes.homeDashboard, (_) => false);
                            }
                          },
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: isLight ? Colors.black.withOpacity(0.04) : Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
                              border: Border.all(color: border),
                            ),
                            child: Icon(
                              isAr ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded,
                              color: textP,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppTokens.space12),

                        // Title Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                scope.t('aiPlanner_title'),
                                style: TextStyle(
                                  color: textP,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                scope.t('aiPlanner_subtitle'),
                                style: TextStyle(
                                  color: textS,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Removed online badge per user request
                        const SizedBox.shrink(),
                      ],
                    ),
                  ),

                  // 3. CHAT BUBBLES SCROLL FEED
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTokens.space16,
                        vertical: AppTokens.space16,
                      ),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        final isBot = msg.sender == 'bot';
                        final timeString = "${msg.time.hour.toString().padLeft(2, '0')}:${msg.time.minute.toString().padLeft(2, '0')}";

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            mainAxisAlignment: isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Bot Avatar
                              if (isBot) ...[
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFFB54D3F), Color(0xFFE4A853)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: ShmaghRobotIcon(size: 16),
                                  ),
                                ),
                                const SizedBox(width: AppTokens.space8),
                              ],

                              // Chat bubble with Liquid Glass effect
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.72,
                                  ),
                                  padding: const EdgeInsets.all(AppTokens.space12),
                                  decoration: BoxDecoration(
                                    color: isBot
                                        ? (isLight ? Colors.white : cardBg.withOpacity(0.9))
                                        : (isLight ? const Color(0xFFB54D3F) : const Color(0xFF14E0C4)),
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(16),
                                      topRight: const Radius.circular(16),
                                      bottomLeft: isBot ? Radius.zero : const Radius.circular(16),
                                      bottomRight: isBot ? const Radius.circular(16) : Radius.zero,
                                    ),
                                    border: isBot
                                        ? Border.all(color: border, width: 0.8)
                                        : null,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(isLight ? 0.04 : 0.15),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MarkdownText(
                                        text: msg.text,
                                        style: TextStyle(
                                          color: isBot
                                              ? textP
                                              : (isLight ? Colors.white : const Color(0xFF060A13)),
                                          fontSize: 12.5,
                                          height: 1.45,
                                          fontWeight: isBot ? FontWeight.w500 : FontWeight.w600,
                                        ),
                                        boldStyle: TextStyle(
                                          color: isBot
                                              ? textP
                                              : (isLight ? Colors.white : const Color(0xFF060A13)),
                                          fontSize: 12.5,
                                          height: 1.45,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Align(
                                        alignment: AlignmentDirectional.bottomEnd,
                                        child: Text(
                                          timeString,
                                          style: TextStyle(
                                            color: isBot
                                                ? textS.withOpacity(0.7)
                                                : (isLight ? Colors.white70 : Colors.black54),
                                            fontSize: 8.5,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ).animate().fade(duration: 200.ms).scaleXY(begin: 0.95, alignment: (isBot ? AlignmentDirectional.topStart : AlignmentDirectional.topEnd).resolve(Directionality.of(context))),
                              ),

                              // User Avatar
                              if (!isBot) ...[
                                const SizedBox(width: AppTokens.space8),
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: isLight ? Colors.black.withOpacity(0.08) : Colors.white.withOpacity(0.08),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: border),
                                  ),
                                  child: Icon(
                                    Icons.person_rounded,
                                    color: textP,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // 3. TYPING INDICATOR EFFECT
                  _isTyping ? Padding(
                      padding: const EdgeInsetsDirectional.only(start: AppTokens.space16, end: AppTokens.space16, bottom: 12),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFB54D3F), Color(0xFFE4A853)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: ShmaghRobotIcon(size: 16),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: isLight ? Colors.white : cardBg.withOpacity(0.8),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                                border: Border.all(color: border, width: 0.8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(3, (i) {
                                  return Container(
                                    width: 6,
                                    height: 6,
                                    margin: const EdgeInsetsDirectional.symmetric(horizontal: 2),
                                    decoration: BoxDecoration(
                                      color: isLight ? const Color(0xFFB54D3F) : const Color(0xFF14E0C4),
                                      shape: BoxShape.circle,
                                    ),
                                  ).animate(onPlay: (c) => c.repeat())
                                   .scaleXY(begin: 0.5, end: 1.2, duration: 400.ms, delay: (i * 150).ms, curve: Curves.easeInOut)
                                   .then()
                                   .scaleXY(begin: 1.2, end: 0.5, duration: 400.ms, curve: Curves.easeInOut);
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ) : const SizedBox.shrink(),

                  // 4. QUICK PRESET CHIPS
                  (!isKeyboardOpen && !_hasTypedText) ?
                    Container(
                      height: 42,
                      margin: const EdgeInsets.only(bottom: AppTokens.space12),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: AppTokens.space16),
                        itemCount: quickQueries.length,
                        itemBuilder: (context, index) {
                          final query = quickQueries[index];
                          IconData icon = Icons.help_outline_rounded;
                          if (index == 0) icon = Icons.groups_rounded;
                          if (index == 1) icon = Icons.local_cafe_rounded;
                          if (index == 2) icon = Icons.local_parking_rounded;
                          if (index == 3) icon = Icons.wb_twilight_rounded;
                          if (index == 4) icon = Icons.explore_rounded;

                          return Padding(
                            padding: const EdgeInsetsDirectional.only(end: 8.0),
                            child: InkWell(
                              onTap: () => _sendMessage(query, lang),
                              borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
                              child: Container(
                                padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isLight ? Colors.white : const Color(0xFF141B2E),
                                  borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
                                  border: Border.all(color: border),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.03),
                                      blurRadius: 4,
                                      offset: const Offset(0, 1),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      icon,
                                      size: 14,
                                      color: isLight ? const Color(0xFFB54D3F) : const Color(0xFF14E0C4),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      query,
                                      style: TextStyle(
                                        color: textP,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ) : const SizedBox.shrink(),

                  // 5. INPUT TEXT BAR
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTokens.space16,
                      vertical: AppTokens.space12,
                    ),
                    decoration: BoxDecoration(
                      color: isLight ? Colors.white : const Color(0xFF060A13),
                      border: Border(
                        top: BorderSide(color: border, width: 0.8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.transparent,
                                width: 0.8,
                              ),
                            ),
                            child: Center(
                              child: TextField(
                                focusNode: _focusNode,
                                controller: _inputController,
                                style: TextStyle(
                                  color: textP,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  hintText: scope.t('aiPlanner_placeholder'),
                                  hintStyle: TextStyle(
                                    color: textS.withOpacity(0.6),
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onSubmitted: (val) {
                                  _sendMessage(val, lang);
                                  _focusNode.requestFocus(); // Keep focus when submitting
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Rounded gradient send button
                        GestureDetector(
                          onTap: () {
                            final txt = _inputController.text;
                            if (txt.isNotEmpty) {
                              _sendMessage(txt, lang);
                            }
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFB54D3F), Color(0xFFE4A853)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFB54D3F).withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: const Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Spacer offset for bottom navigation deck (when shown as nested shell item)
                  (!isKeyboardOpen) ?
                    const SizedBox(height: 80) : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom "robot wearing a shmagh" avatar icon used in place of the plain
// smart_toy icon, to give Abu Al-Areef (ابو العريف) his own visual identity.
class ShmaghRobotIcon extends StatelessWidget {
  final double size;
  const ShmaghRobotIcon({super.key, this.size = 16});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    return SizedBox(
      width: size * 1.4,
      height: size * 1.55,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Robot face
          Positioned(
            bottom: 0,
            child: Icon(Icons.smart_toy_rounded, color: Colors.white, size: size),
          ),
          // Shmagh (headscarf) draped over the top of the head
          Positioned(
            top: 0,
            child: CustomPaint(
              size: Size(size * 1.35, size * 0.72),
              painter: _ShmaghPainter(isLight: isLight),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShmaghPainter extends CustomPainter {
  final bool isLight;
  const _ShmaghPainter({required this.isLight});

  @override
  void paint(Canvas canvas, Size size) {
    // Draped headscarf silhouette (trapezoid tapering down over the sides of the head)
    final path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width * 0.98, size.height * 0.5)
      ..lineTo(size.width * 0.8, size.height)
      ..lineTo(size.width * 0.2, size.height)
      ..lineTo(size.width * 0.02, size.height * 0.5)
      ..close();

    final basePaint = Paint()..color = Colors.white;
    canvas.drawPath(path, basePaint);

    // Simplified red checkered shmagh pattern (diagonal stripes)
    final stripePaint = Paint()
      ..color = const Color(0xFFB54D3F)
      ..strokeWidth = size.width * 0.075
      ..style = PaintingStyle.stroke;

    canvas.save();
    canvas.clipPath(path);
    for (double dx = -size.height; dx < size.width + size.height; dx += size.width * 0.2) {
      canvas.drawLine(
        Offset(dx, 0),
        Offset(dx + size.height, size.height),
        stripePaint,
      );
    }
    canvas.restore();

    // Agal (the cord/diadem that holds the shmagh in place)
    // Use dark color on light mode, light gold on dark mode for visibility
    final agalPaint = Paint()
      ..color = isLight ? Colors.black : const Color(0xFF2A2418)
      ..strokeWidth = size.height * 0.16
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width * 0.14, size.height * 0.22),
      Offset(size.width * 0.86, size.height * 0.22),
      agalPaint,
    );

    // Outline for definition - adapt opacity based on theme
    final outlinePaint = Paint()
      ..color = isLight ? Colors.black.withOpacity(0.08) : Colors.white.withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawPath(path, outlinePaint);
  }

  @override
  bool shouldRepaint(covariant _ShmaghPainter oldDelegate) => oldDelegate.isLight != isLight;
}

// Beautiful and extremely lightweight Markdown parser for formatting rich text chats in Flutter
class MarkdownText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextStyle? boldStyle;
  final double lineSpacing;

  const MarkdownText({
    super.key,
    required this.text,
    required this.style,
    this.boldStyle,
    this.lineSpacing = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    final lines = text.split('\n');
    final widgets = <Widget>[];

    for (var i = 0; i < lines.length; i++) {
      var line = lines[i];
      if (line.trim().isEmpty) {
        widgets.add(SizedBox(height: lineSpacing));
        continue;
      }

      // 1. Check for Headers
      if (line.startsWith('### ')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
          child: _renderRichText(
            line.substring(4),
            style.copyWith(fontSize: style.fontSize! + 2, fontWeight: FontWeight.bold),
            boldStyle?.copyWith(fontSize: style.fontSize! + 2, fontWeight: FontWeight.bold) ?? style.copyWith(fontSize: style.fontSize! + 2, fontWeight: FontWeight.bold),
          ),
        ));
        continue;
      } else if (line.startsWith('## ')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 6.0),
          child: _renderRichText(
            line.substring(3),
            style.copyWith(fontSize: style.fontSize! + 3, fontWeight: FontWeight.bold),
            boldStyle?.copyWith(fontSize: style.fontSize! + 3, fontWeight: FontWeight.bold) ?? style.copyWith(fontSize: style.fontSize! + 3, fontWeight: FontWeight.bold),
          ),
        ));
        continue;
      } else if (line.startsWith('# ')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
          child: _renderRichText(
            line.substring(2),
            style.copyWith(fontSize: style.fontSize! + 4, fontWeight: FontWeight.bold),
            boldStyle?.copyWith(fontSize: style.fontSize! + 4, fontWeight: FontWeight.bold) ?? style.copyWith(fontSize: style.fontSize! + 4, fontWeight: FontWeight.bold),
          ),
        ));
        continue;
      }

      // 2. Check for Bullet Points
      bool isBullet = false;
      String bulletContent = line;
      if (line.trimLeft().startsWith('* ')) {
        isBullet = true;
        bulletContent = line.trimLeft().substring(2);
      } else if (line.trimLeft().startsWith('- ')) {
        isBullet = true;
        bulletContent = line.trimLeft().substring(2);
      } else if (line.trimLeft().startsWith('• ')) {
        isBullet = true;
        bulletContent = line.trimLeft().substring(2);
      }

      if (isBullet) {
        widgets.add(Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0, top: 2.0, bottom: 2.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• ', style: style.copyWith(fontWeight: FontWeight.bold)),
              Expanded(
                child: _renderRichText(bulletContent, style, boldStyle),
              ),
            ],
          ),
        ));
      } else {
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: _renderRichText(line, style, boldStyle),
        ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: widgets,
    );
  }

  // Parses a single line for **bold** format using basic regex
  Widget _renderRichText(String line, TextStyle normalStyle, TextStyle? customBoldStyle) {
    final activeBoldStyle = customBoldStyle ?? normalStyle.copyWith(fontWeight: FontWeight.bold);
    final spans = <TextSpan>[];

    final regex = RegExp(r'\*\*(.*?)\*\*');
    int lastMatchEnd = 0;

    final matches = regex.allMatches(line);
    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: line.substring(lastMatchEnd, match.start),
          style: normalStyle,
        ));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: activeBoldStyle,
      ));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < line.length) {
      spans.add(TextSpan(
        text: line.substring(lastMatchEnd),
        style: normalStyle,
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }
}