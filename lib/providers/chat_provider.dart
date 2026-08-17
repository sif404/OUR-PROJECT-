import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ========================================================
// 1. CHAT MESSAGE MODEL
// ========================================================
class ChatMessage {
  final String text;
  final String sender; // 'user' or 'bot'
  final DateTime time;

  ChatMessage({
    required this.text,
    required this.sender,
    required this.time,
  });

  // Convert to JSON for saving to device storage
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'sender': sender,
      'time': time.toIso8601String(),
    };
  }

  // Load from JSON from device storage
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['text'] as String,
      sender: json['sender'] as String,
      time: DateTime.parse(json['time'] as String),
    );
  }
}

// ========================================================
// 2. TYPING INDICATOR PROVIDER
// ========================================================
// A simple boolean state to track if the bot is currently typing.
final chatTypingProvider = StateProvider<bool>((ref) => false);


// ========================================================
// 3. CHAT MESSAGES PROVIDER (WITH PERSISTENCE)
// ========================================================
final chatMessagesProvider = StateNotifierProvider<ChatMessagesNotifier, List<ChatMessage>>((ref) {
  return ChatMessagesNotifier(ref);
});

class ChatMessagesNotifier extends StateNotifier<List<ChatMessage>> {
  final Ref ref;
  
  ChatMessagesNotifier(this.ref) : super([]) {
    _loadSavedChat(); // Automatically load history when opened
  }

  // --- DEVICE STORAGE: LOAD ---
  Future<void> _loadSavedChat() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedJson = prefs.getString('saved_ai_chat');
    
    if (savedJson != null) {
      try {
        final List<dynamic> decodedList = jsonDecode(savedJson);
        state = decodedList.map((msg) => ChatMessage.fromJson(msg)).toList();
      } catch (e) {
        debugPrint("Error loading chat history: $e");
      }
    }
  }

  // --- DEVICE STORAGE: SAVE ---
  Future<void> _saveChatToDevice(List<ChatMessage> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedJson = jsonEncode(messages.map((m) => m.toJson()).toList());
    await prefs.setString('saved_ai_chat', encodedJson);
  }

  // --- ENSURE WELCOME MESSAGE ---
  void ensureWelcome(String welcomeText) {
    // Only send the welcome message if the chat is completely empty 
    // (meaning no previous history was loaded).
    if (state.isEmpty) {
      final welcomeMsg = ChatMessage(text: welcomeText, sender: 'bot', time: DateTime.now());
      state = [welcomeMsg];
      _saveChatToDevice(state);
    }
  }

  // --- SEND MESSAGE & CALL API ---
  Future<void> sendMessage({
    required String text,
    required String lang,
    required String clientApiKey,
    required String apiUrl,
    required String systemInstruction,
    required Map<String, String> fallbackResponses,
  }) async {
    
    // 1. Add the user's message to the UI and save it
    final userMsg = ChatMessage(text: text, sender: 'user', time: DateTime.now());
    state = [...state, userMsg];
    _saveChatToDevice(state);

    // 2. Turn on the typing indicator (...)
    ref.read(chatTypingProvider.notifier).state = true;

    try {
      // 3. Send the request to your backend API
      // NOTE: Adjust the JSON body below if your backend expects different key names!
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          if (clientApiKey.isNotEmpty) 'Authorization': 'Bearer $clientApiKey',
        },
        body: jsonEncode({
          'message': text,
          'language': lang,
          'system_instruction': systemInstruction,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Extract the bot's reply from the JSON response
        // NOTE: If your backend uses a different key like data['response'], change it here!
        final botReplyText = data['reply'] ?? data['response'] ?? fallbackResponses['default'] ?? 'Sorry, I couldn\'t understand that.';
        
        // Add Bot message and save
        final botMsg = ChatMessage(text: botReplyText, sender: 'bot', time: DateTime.now());
        state = [...state, botMsg];
        _saveChatToDevice(state);
        
      } else {
        // Backend returned an error code (e.g. 500)
        final errorMsg = ChatMessage(
          text: fallbackResponses['default'] ?? 'Sorry, the server is currently busy.', 
          sender: 'bot', 
          time: DateTime.now()
        );
        state = [...state, errorMsg];
        _saveChatToDevice(state);
      }
    } catch (e) {
      debugPrint("API Chat Error: $e");
      
      // Network failure / Phone is offline
      final networkErrorMsg = ChatMessage(
        text: fallbackResponses['default'] ?? 'Network error. Please check your connection.', 
        sender: 'bot', 
        time: DateTime.now()
      );
      state = [...state, networkErrorMsg];
      _saveChatToDevice(state);
      
    } finally {
      // 4. Turn off the typing indicator regardless of success or failure
      ref.read(chatTypingProvider.notifier).state = false;
    }
  }
}