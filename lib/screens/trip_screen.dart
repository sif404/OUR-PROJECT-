// evening_plan_screen.dart
//
// Single self-contained Flutter conversion of the "Evening plan" screen
// (TRIP.html). Drop this file into an existing Flutter project and use
// `EveningPlanScreen` as you would any other widget/page.
//
// NOTE ON FONTS: the original design uses "Poppins" and "Playfair Display"
// from Google Fonts. This file references them by family name only
// (no network / google_fonts dependency, per the "no extra deps unless
// absolutely necessary" requirement). If you want the exact webfonts,
// add the `google_fonts` package or bundle the .ttf files and register
// them in pubspec.yaml under the same family names used below
// ('Poppins' / 'PlayfairDisplay'); otherwise Flutter will fall back to
// the platform default font, which will still preserve size/weight/layout.
//
// NOTE ON "Get directions": the HTML opens a Google Maps search URL in a
// new tab. That functionality needs the `url_launcher` package (a very
// common, near-unavoidable package for this exact feature). Add it to
// pubspec.yaml:
//   url_launcher: ^6.2.0
// If you'd rather not take the dependency, delete the import below and
// replace `_openDirections` with your own navigation logic.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:url_launcher/url_launcher.dart';

import '../models/app_scope.dart';

// =========================================================================
// COLORS
// =========================================================================

class AppColors {
  AppColors._();

  static const Color pageBg = Color(0xFFE9E2D6); // outer body background
  static const Color bg = Color(0xFFFDFBF7);
  static const Color bgSoft = Color(0xFFFBF6EE);
  static const Color ink = Color(0xFF221F1B);
  static const Color muted = Color(0xFF8C8577);
  static const Color line = Color(0x14221F1B); // rgba(34,31,27,0.08)
  static const Color teal = Color(0xFF8B1E2E);
  static const Color tealSoft = Color(0xFFFBE9EA);
  static const Color amber = Color(0xFFE29A34);
  static const Color amberSoft = Color(0xFFFBEDD8);
  static const Color coral = Color(0xFFEF6F49);
  static const Color coralSoft = Color(0xFFFCE6DD);
  static const Color violet = Color(0xFF8A79EE);
  static const Color violetSoft = Color(0xFFEEEBFC);
  static const Color maroon = Color(0xFF8B1E2E);

  static const Color dotIdle = Color(0xFFD9D0BF);
  static const Color dashedLine = Color(0xFFD9CFBB);
  static const Color toastBg = Color(0xFF1D1B18);
  static const Color nextCardBorder = Color(0x598B1E2E); // rgba(139,30,46,.35)
}

// =========================================================================
// TEXT STYLES
// =========================================================================

class AppText {
  AppText._();

  static const String poppins = 'Poppins';
  static const String playfair = 'PlayfairDisplay';

  static const TextStyle h1 = TextStyle(
    fontFamily: playfair,
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.ink,
    height: 1.2,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: poppins,
    fontSize: 12.5,
    color: AppColors.muted,
    height: 1.3,
  );

  static const TextStyle chip = TextStyle(
    fontFamily: poppins,
    fontSize: 11.5,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
  );

  static const TextStyle noteTitle = TextStyle(
    fontFamily: poppins,
    fontSize: 12.5,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );

  static const TextStyle noteSub = TextStyle(
    fontFamily: poppins,
    fontSize: 11.5,
    color: AppColors.muted,
    height: 1.4,
  );

  static const TextStyle countdownChip = TextStyle(
    fontFamily: poppins,
    fontSize: 10.5,
    fontWeight: FontWeight.w700,
    color: AppColors.coral,
  );

  static const TextStyle timeLabel = TextStyle(
    fontFamily: poppins,
    fontSize: 11,
    color: AppColors.muted,
  );

  static const TextStyle timeLabelNext = TextStyle(
    fontFamily: poppins,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.teal,
  );

  static const TextStyle stopTitle = TextStyle(
    fontFamily: poppins,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );

  static const TextStyle stopSub = TextStyle(
    fontFamily: poppins,
    fontSize: 12,
    color: AppColors.muted,
  );

  static const TextStyle stopSubAccent = TextStyle(
    fontFamily: poppins,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.teal,
  );

  static const TextStyle addStopBtn = TextStyle(
    fontFamily: poppins,
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
    color: AppColors.muted,
  );

  static const TextStyle ctaText = TextStyle(
    fontFamily: poppins,
    fontSize: 14.5,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle ctaSub = TextStyle(
    fontFamily: poppins,
    fontSize: 10.5,
    color: AppColors.muted,
  );

  static const TextStyle sheetTitle = TextStyle(
    fontFamily: playfair,
    fontSize: 17,
    fontWeight: FontWeight.w800,
    color: AppColors.ink,
  );

  static const TextStyle addSheetTitle = TextStyle(
    fontFamily: playfair,
    fontSize: 17,
    fontWeight: FontWeight.w800,
    color: AppColors.ink,
  );

  static const TextStyle sheetSub = TextStyle(
    fontFamily: poppins,
    fontSize: 12,
    color: AppColors.muted,
  );

  static const TextStyle sheetNote = TextStyle(
    fontFamily: poppins,
    fontSize: 12,
    color: AppColors.ink,
    height: 1.5,
  );

  static const TextStyle sheetBtn = TextStyle(
    fontFamily: poppins,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle fieldLabel = TextStyle(
    fontFamily: poppins,
    fontSize: 11.5,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );

  static const TextStyle fieldInput = TextStyle(
    fontFamily: poppins,
    fontSize: 13,
    color: AppColors.ink,
  );

  static const TextStyle catOpt = TextStyle(
    fontFamily: poppins,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.muted,
  );

  static const TextStyle catOptActive = TextStyle(
    fontFamily: poppins,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle formError = TextStyle(
    fontFamily: poppins,
    fontSize: 11,
    color: AppColors.coral,
  );

  static const TextStyle pushTitle = TextStyle(
    fontFamily: poppins,
    fontSize: 12.5,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle pushSub = TextStyle(
    fontFamily: poppins,
    fontSize: 11,
    color: Color(0xBFFFFFFF),
  );

  static const TextStyle toast = TextStyle(
    fontFamily: poppins,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

// =========================================================================
// RADII / SPACING
// =========================================================================

class AppRadii {
  AppRadii._();
  static const double pill = 999;
  static const double banner = 14;
  static const double stopCard = 16;
  static const double sheetTop = 26;
  static const double sheetIcon = 14;
  static const double stopIcon = 12;
  static const double cta = 18;
  static const double sheetBtn = 16;
  static const double field = 12;
}

// =========================================================================
// ENUMS
// =========================================================================

/// Icon "keys", mirroring the ICON map in the original HTML/JS.
enum IconKey { ball, palette, clock, alarm, cloud, plus, x, flag, bell, share, cup, trash }

extension IconKeyData on IconKey {
  IconData get data {
    switch (this) {
      case IconKey.ball:
        return Icons.sports_soccer_outlined;
      case IconKey.palette:
        return Icons.palette_outlined;
      case IconKey.clock:
        return Icons.access_time_rounded;
      case IconKey.alarm:
        return Icons.alarm_rounded;
      case IconKey.cloud:
        return Icons.cloud_outlined;
      case IconKey.plus:
        return Icons.add_rounded;
      case IconKey.x:
        return Icons.close_rounded;
      case IconKey.flag:
        return Icons.flag_outlined;
      case IconKey.bell:
        return Icons.notifications_none_rounded;
      case IconKey.share:
        return Icons.ios_share_rounded;
      case IconKey.cup:
        return Icons.local_cafe_outlined;
      case IconKey.trash:
        return Icons.delete_outline_rounded;
    }
  }
}

/// Stop categories used by the "Add a stop" sheet, mirroring `categoryDefs`.
enum StopCategory { food, sport, art, relax }

class CategoryDef {
  final String label;
  final IconKey iconKey;
  final Color color;
  final Color soft;

  const CategoryDef({
    required this.label,
    required this.iconKey,
    required this.color,
    required this.soft,
  });
}

extension StopCategoryData on StopCategory {
  CategoryDef get def {
    switch (this) {
      case StopCategory.food:
        return const CategoryDef(
          label: 'Food & drink',
          iconKey: IconKey.cup,
          color: AppColors.teal,
          soft: AppColors.tealSoft,
        );
      case StopCategory.sport:
        return const CategoryDef(
          label: 'Sport',
          iconKey: IconKey.ball,
          color: AppColors.coral,
          soft: AppColors.coralSoft,
        );
      case StopCategory.art:
        return const CategoryDef(
          label: 'Art & culture',
          iconKey: IconKey.palette,
          color: AppColors.violet,
          soft: AppColors.violetSoft,
        );
      case StopCategory.relax:
        return const CategoryDef(
          label: 'Relax',
          iconKey: IconKey.clock,
          color: AppColors.amber,
          soft: AppColors.amberSoft,
        );
    }
  }

  String get labelKey {
    switch (this) {
      case StopCategory.food:
        return 'trip_categoryFood';
      case StopCategory.sport:
        return 'trip_categorySport';
      case StopCategory.art:
        return 'trip_categoryArt';
      case StopCategory.relax:
        return 'trip_categoryRelax';
    }
  }
}

// =========================================================================
// MODEL
// =========================================================================

class StopItem {
  final String id;
  final String title;
  final String time; // display string, e.g. "6:00 PM"
  final int minutes; // minutes since midnight
  final IconKey iconKey;
  final Color color;
  final Color soft;
  final String sub;
  final String? note;

  const StopItem({
    required this.id,
    required this.title,
    required this.time,
    required this.minutes,
    required this.iconKey,
    required this.color,
    required this.soft,
    required this.sub,
    this.note,
  });
}

// =========================================================================
// UTILITY METHODS
// =========================================================================

/// Parses strings like "6:45 PM" / "18:45" into minutes-since-midnight.
/// Mirrors `parseTimeToMinutes` from the original JS. Returns null if the
/// string can't be parsed.
int? parseTimeToMinutes(String input) {
  final match = RegExp(r'(\d{1,2}):(\d{2})\s*(AM|PM)?', caseSensitive: false)
      .firstMatch(input.trim());
  if (match == null) return null;
  var h = int.tryParse(match.group(1) ?? '');
  final mi = int.tryParse(match.group(2) ?? '');
  if (h == null || mi == null) return null;
  final ap = match.group(3)?.toUpperCase();
  if (ap == 'PM' && h != 12) h += 12;
  if (ap == 'AM' && h == 12) h = 0;
  return h * 60 + mi;
}

/// Strips " AM"/" PM" from a display time string, e.g. "6:00 PM" -> "6:00".
String formatTimeLabel(String time) {
  return time.replaceAll(' PM', '').replaceAll(' AM', '');
}

List<StopItem> sortStopsByTime(List<StopItem> stops) {
  final copy = List<StopItem>.from(stops);
  copy.sort((a, b) => a.minutes.compareTo(b.minutes));
  return copy;
}

// =========================================================================
// MAIN SCREEN
// =========================================================================

class EveningPlanScreen extends StatefulWidget {
  const EveningPlanScreen({super.key});

  @override
  State<EveningPlanScreen> createState() => _EveningPlanScreenState();
}

class _EveningPlanScreenState extends State<EveningPlanScreen> {
  static const String _matchStopId = 'match';
  static const String _fanzoneStopId = 'fanzone';
  static const String _planEndLabel = '10:15 PM'; // matches original (static)

  List<StopItem> _stops = const [
    StopItem(
      id: 'fanzone',
      title: 'Fan Zone Warm-up',
      time: '6:00 PM',
      minutes: 18 * 60,
      iconKey: IconKey.flag,
      color: AppColors.amber,
      soft: AppColors.amberSoft,
      sub: 'Jersey meet-up · 6 min walk',
    ),
    StopItem(
      id: 'match',
      title: 'Jordan vs Spain',
      time: '7:00 PM',
      minutes: 19 * 60,
      iconKey: IconKey.ball,
      color: AppColors.coral,
      soft: AppColors.coralSoft,
      sub: 'Kickoff · Public screening',
      note:
          'Leave home by 5:40 — roads near the stadium fill up fast before kickoff.',
    ),
    StopItem(
      id: 'art',
      title: 'Riverside Art Walk',
      time: '8:15 PM',
      minutes: 20 * 60 + 15,
      iconKey: IconKey.palette,
      color: AppColors.violet,
      soft: AppColors.violetSoft,
      sub: 'Live sketching · 10 min walk',
    ),
    StopItem(
      id: 'lounge',
      title: 'Quiet Garden Lounge',
      time: '9:30 PM',
      minutes: 21 * 60 + 30,
      iconKey: IconKey.clock,
      color: AppColors.teal,
      soft: AppColors.tealSoft,
      sub: 'Seated · 5 min walk',
    ),
  ];

  Timer? _ticker;

  bool _showPushToast = false;
  Timer? _pushShowTimer;
  Timer? _pushHideTimer;

  bool _showToast = false;
  String _toastMessage = '';
  Timer? _toastTimer;

  bool _stopsLocalized = false;

  @override
  void initState() {
    super.initState();
    _stops = sortStopsByTime(_stops);

    // Re-render every 30s, like `setInterval(updateProgress+updateCountdown, 30000)`.
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });

    _schedulePush();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_stopsLocalized) return;
    _stopsLocalized = true;
    final t = AppScope.of(context).t;
    const localizedFields = <String, (String, String, String?)>{
      'fanzone': ('trip_stop1Title', 'trip_stop1Sub', null),
      'match': ('trip_stop2Title', 'trip_stop2Sub', 'trip_stop2Note'),
      'art': ('trip_stop3Title', 'trip_stop3Sub', null),
      'lounge': ('trip_stop4Title', 'trip_stop4Sub', null),
    };
    setState(() {
      _stops = _stops.map((stop) {
        final fields = localizedFields[stop.id];
        if (fields == null) return stop;
        final (titleKey, subKey, noteKey) = fields;
        return StopItem(
          id: stop.id,
          title: t(titleKey),
          time: stop.time,
          minutes: stop.minutes,
          iconKey: stop.iconKey,
          color: stop.color,
          soft: stop.soft,
          sub: t(subKey),
          note: noteKey == null ? stop.note : t(noteKey),
        );
      }).toList();
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _pushShowTimer?.cancel();
    _pushHideTimer?.cancel();
    _toastTimer?.cancel();
    super.dispose();
  }

  // ---------------- push-style reminder ----------------

  void _schedulePush() {
    _pushShowTimer = Timer(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      setState(() => _showPushToast = true);
      _pushHideTimer = Timer(const Duration(milliseconds: 6000), () {
        if (!mounted) return;
        setState(() => _showPushToast = false);
      });
    });
  }

  void _onPushTap() {
    setState(() => _showPushToast = false);
    final stop = _stops.firstWhere((s) => s.id == _fanzoneStopId);
    _openStopSheet(stop);
  }

  // ---------------- toast ----------------

  void _showToastMessage(String msg) {
    _toastTimer?.cancel();
    setState(() {
      _toastMessage = msg;
      _showToast = true;
    });
    _toastTimer = Timer(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      setState(() => _showToast = false);
    });
  }

  // ---------------- derived state ----------------

  int get _nowMinutes {
    final now = DateTime.now();
    return now.hour * 60 + now.minute;
  }

  double get _progress {
    if (_stops.isEmpty) return 0.03;
    final start = _stops.first.minutes;
    final end = _stops.last.minutes + 45;
    double pct = ((_nowMinutes - start) / (end - start)) * 100;
    if (pct.isNaN || pct < 3) pct = 3;
    if (pct > 100) pct = 100;
    return pct / 100;
  }

  bool get _isUrgent {
    if (_stops.isEmpty) return false;
    final firstStopDiff = _stops.first.minutes - _nowMinutes;
    return firstStopDiff <= 20 && firstStopDiff > -180;
  }

  String _noteTitle(BuildContext context) => _isUrgent
      ? AppScope.of(context).t('trip_leaveNow')
      : AppScope.of(context).t('trip_leaveEarlier');

  String _noteSub(BuildContext context) {
    if (_isUrgent) {
      return AppScope.of(context).t('trip_leaveSoon', {'stop': _stops.first.title});
    }
    return AppScope.of(context).t('trip_leaveByHint', {'time': '5:40'});
  }

  String? _countdownText(BuildContext context) {
    StopItem? match;
    for (final s in _stops) {
      if (s.id == _matchStopId) {
        match = s;
        break;
      }
    }
    if (match == null) return null;

    final now = DateTime.now();
    var target = DateTime(
      now.year,
      now.month,
      now.day,
      match.minutes ~/ 60,
      match.minutes % 60,
    );
    if (!target.isAfter(now)) {
      target = target.add(const Duration(days: 1));
    }
    final diffMin = target.difference(now).inMinutes;
    final h = diffMin ~/ 60;
    final m = diffMin % 60;
    final time = h > 0 ? '${h}h ${m}m' : '${m}m';
    return AppScope.of(context).t('trip_kickoffIn', {'time': time});
  }

  // ---------------- actions ----------------

  Future<void> _openDirections(StopItem stop) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(stop.title)}',
    );
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      // Swallow errors the same way the original `window.open(...).catch` does.
    }
  }

  void _navigateNext() {
    if (_stops.isEmpty) return;
    _openDirections(_stops.first);
  }

  void _sharePlan() {
    final prefix = AppScope.of(context).t('trip_sharePlanPrefix');
    final text = '$prefix ${_stops.map((s) => '${s.time} ${s.title}').join(', ')}';
    Clipboard.setData(ClipboardData(text: text));
    _showToastMessage(AppScope.of(context).t('trip_planCopied'));
  }

  void _addStop(StopItem stop) {
    setState(() {
      _stops = sortStopsByTime([..._stops, stop]);
    });
    _showToastMessage(AppScope.of(context).t('trip_addedToPlan'));
  }

  void _confirmClearPlan() {
    if (_stops.isEmpty) return;
    showDialog<void>(
      context: context,
      barrierColor: const Color(0x6B14120F),
      builder: (ctx) => _ClearPlanDialog(
        stopCount: _stops.length,
        onConfirm: () {
          Navigator.of(ctx).pop();
          _clearPlan();
        },
        onCancel: () => Navigator.of(ctx).pop(),
      ),
    );
  }

  void _clearPlan() {
    setState(() {
      _stops = const [];
    });
    _showToastMessage(AppScope.of(context).t('trip_planCleared'));
  }

  void _openStopSheet(StopItem stop) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0x6B14120F), // rgba(20,18,15,0.42)
      isScrollControlled: true,
      builder: (ctx) => _StopDetailSheet(
        stop: stop,
        onGetDirections: () {
          Navigator.of(ctx).pop();
          _openDirections(stop);
        },
      ),
    );
  }

  void _openAddStopSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0x6B14120F),
      isScrollControlled: true,
      builder: (ctx) => _AddStopSheet(
        onSubmit: (stop) {
          Navigator.of(ctx).pop();
          _addStop(stop);
        },
      ),
    );
  }

  // ---------------- build ----------------

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    return Scaffold(
      backgroundColor: AppColors.pageBg,
      body: SafeArea(
        child: Directionality(
          textDirection: scope.direction,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, AppColors.bg],
                    stops: [0, 0.45],
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(height: 4, color: AppColors.maroon),
                        Expanded(
                          child: Stack(
                            children: [
                              _buildScrollContent(context),
                              _buildPushToast(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _buildCtaWrap(context),
                    _buildToast(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

Widget _buildScrollContent(BuildContext context) {
      return SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            _buildProgressTrack(),
            _buildNoteBanner(),
            _buildTimeline(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final scope = AppScope.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 22, 20, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(scope.t('trip_myEveningPlan'), style: AppText.h1),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    '${scope.t('trip_stops', {'count': _stops.length.toString()})} · ${_stops.isNotEmpty ? _stops.first.time : ''} – $_planEndLabel',
                    style: AppText.h2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              _IconChipButton(icon: IconKey.share.data, onTap: _sharePlan),
              const SizedBox(width: 8),
              _IconChipButton(
                icon: IconKey.trash.data,
                onTap: _confirmClearPlan,
                background: AppColors.coralSoft,
                border: const Color(0x40EF6F49),
                iconColor: const Color(0xFF993C1D),
                semanticLabel: scope.t('trip_clearPlan'),
              ),
              const SizedBox(width: 8),
              _ChipButton(icon: IconKey.cloud.data, label: '21°'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTrack() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.pill),
        child: Container(
          height: 5,
          color: const Color(0xFFE7DFD0),
          alignment: AlignmentDirectional.centerStart,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                width: constraints.maxWidth * _progress,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                  gradient: const LinearGradient(
                    colors: [AppColors.teal, Color(0xFFB84656)],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNoteBanner() {
    final urgent = _isUrgent;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: urgent ? AppColors.coral : AppColors.coralSoft,
          borderRadius: BorderRadius.circular(AppRadii.banner),
          border: Border.all(
            color: urgent
                ? Colors.transparent
                : const Color(0x40EF6F49), // rgba(239,111,73,0.25)
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(IconKey.alarm.data, size: 15, color: AppColors.coral),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _noteTitle(context),
                    style: AppText.noteTitle.copyWith(
                      color: urgent ? Colors.white : AppColors.ink,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      _noteSub(context),
                      style: AppText.noteSub.copyWith(
                        color: urgent ? Colors.white : AppColors.muted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    final rows = <Widget>[];
    for (var i = 0; i < _stops.length; i++) {
      final stop = _stops[i];
      final isNext = i == 0;
      final isLast = i == _stops.length - 1;
      rows.add(_TimelineRow(
        stop: stop,
        isNext: isNext,
        isLast: isLast,
        countdownText: stop.id == _matchStopId ? (_countdownText(context) ?? AppScope.of(context).t('trip_kickoffIn', {'time': '--'})) : null,
        onTap: () => _openStopSheet(stop),
      ));
    }
    rows.add(_AddStopRow(onTap: _openAddStopSheet));

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
      child: Column(children: rows),
    );
  }

  Widget _buildCtaWrap(BuildContext context) {
    final scope = AppScope.of(context);
    return PositionedDirectional(
      start: 0,
      end: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 22),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x00F6EFE4), AppColors.bg],
            stops: [0, 0.3],
          ),
        ),
        child: Column(
          children: [
            _GradientCtaButton(
              label: scope.t('trip_opensDirectionsNextStop'),
              onTap: _navigateNext,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                scope.t('trip_opensDirectionsNextStop'),
                style: AppText.ctaSub,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPushToast(BuildContext context) {
    final scope = AppScope.of(context);
    return AnimatedPositionedDirectional(
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeOutCubic,
      top: _showPushToast ? 18 : -160,
      start: 14,
      end: 14,
      child: GestureDetector(
        onTap: _onPushTap,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.toastBg,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x73000000),
                  blurRadius: 30,
                  offset: Offset(0, 18),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(IconKey.bell.data, size: 15, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(scope.t('trip_tonightsPlan'), style: AppText.pushTitle),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          scope.t('trip_leaveByHint', {'time': '5:40'}),
                          style: AppText.pushSub,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToast() {
    return PositionedDirectional(
      start: 0,
      end: 0,
      bottom: 100,
      child: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: _showToast ? 1 : 0,
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 250),
            offset: _showToast ? Offset.zero : const Offset(0, 0.15),
            child: IgnorePointer(
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.toastBg,
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                ),
                child: Text(_toastMessage, style: AppText.toast),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// SMALL SHARED WIDGETS
// =========================================================================

class _GradientCtaButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _GradientCtaButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadii.cta),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.cta),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.cta),
            gradient: const LinearGradient(
              colors: [Color(0xFFA6303F), Color(0xFF8B1E2E)],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x8C8B1E2E),
                blurRadius: 30,
                offset: Offset(0, 16),
              ),
            ],
          ),
          child: Text(label, style: AppText.ctaText),
        ),
      ),
    );
  }
}

class _ChipButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ChipButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.bgSoft,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.ink),
          const SizedBox(width: 6),
          Text(label, style: AppText.chip),
        ],
      ),
    );
  }
}

class _IconChipButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? background;
  final Color? border;
  final Color? iconColor;
  final String? semanticLabel;
  const _IconChipButton({
    required this.icon,
    required this.onTap,
    this.background,
    this.border,
    this.iconColor,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background ?? AppColors.bgSoft,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.pill),
        side: BorderSide(color: border ?? AppColors.line),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 32,
          height: 32,
          child: Semantics(
            label: semanticLabel,
            button: true,
            child: Icon(icon, size: 15, color: iconColor ?? AppColors.ink),
          ),
        ),
      ),
    );
  }
}

/// A colored circular/rounded icon badge, used for stop icons and sheet icons.
class _IconBadge extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;
  final double size;
  final double iconSize;
  final double radius;

  const _IconBadge({
    required this.icon,
    required this.color,
    required this.background,
    this.size = 38,
    this.iconSize = 18,
    this.radius = AppRadii.stopIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Icon(icon, size: iconSize, color: color),
    );
  }
}

// =========================================================================
// TIMELINE ROW + STOP CARD
// =========================================================================

class _TimelineRow extends StatelessWidget {
  final StopItem stop;
  final bool isNext;
  final bool isLast;
  final String? countdownText;
  final VoidCallback onTap;

  const _TimelineRow({
    required this.stop,
    required this.isNext,
    required this.isLast,
    required this.countdownText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 14,
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  isNext
                      ? Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.teal,
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.tealSoft,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: AppColors.dotIdle, width: 2),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      formatTimeLabel(stop.time),
                      style: isNext ? AppText.timeLabelNext : AppText.timeLabel,
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Center(
                          child: Container(width: 2, color: AppColors.line),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _StopCard(
                stop: stop,
                isNext: isNext,
                countdownText: countdownText,
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StopCard extends StatelessWidget {
  final StopItem stop;
  final bool isNext;
  final String? countdownText;
  final VoidCallback onTap;

  const _StopCard({
    required this.stop,
    required this.isNext,
    required this.countdownText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isNext ? Colors.white : AppColors.bgSoft,
      borderRadius: BorderRadius.circular(AppRadii.stopCard),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.stopCard),
        onTap: onTap,
        child: Container(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.stopCard),
              border: Border.all(
                color: isNext ? AppColors.nextCardBorder : AppColors.line,
              ),
              boxShadow: isNext
                  ? const [
                      BoxShadow(
                        color: Color(0x408B1E2E),
                        blurRadius: 24,
                        offset: Offset(0, 10),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _IconBadge(
                  icon: stop.iconKey.data,
                  color: stop.color,
                  background: stop.soft,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(stop.title, style: AppText.stopTitle),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          stop.sub,
                          style: isNext ? AppText.stopSubAccent : AppText.stopSub,
                        ),
                      ),
                      if (countdownText != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Container(
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 9, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.coralSoft,
                              borderRadius: BorderRadius.circular(AppRadii.pill),
                            ),
                            child: Text(countdownText!, style: AppText.countdownChip),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}

class _AddStopRow extends StatelessWidget {
  final VoidCallback onTap;
  const _AddStopRow({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 14,
          child: Center(child: _DashedDot()),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadii.stopCard),
              onTap: onTap,
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadii.stopCard),
                  border: Border.all(color: AppColors.dashedLine, width: 1.5),
                ),
                child: Row(
                  children: [
                    Icon(IconKey.plus.data, size: 14, color: AppColors.muted),
                    const SizedBox(width: 8),
                    Text(AppScope.of(context).t('trip_addAStop'), style: AppText.addStopBtn),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DashedDot extends StatelessWidget {
  const _DashedDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.dotIdle, width: 2),
      ),
    );
  }
}

// =========================================================================
// STOP DETAIL SHEET
// =========================================================================

class _SheetShell extends StatelessWidget {
  final Widget child;
  const _SheetShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.82,
        ),
        padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 26),
        decoration: const BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.sheetTop)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: child,
        ),
      ),
    );
  }
}

class _Grabber extends StatelessWidget {
  const _Grabber();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 6,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.line,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
    );
  }
}

class _SheetCloseButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SheetCloseButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgSoft,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 26,
          height: 26,
          child: Icon(IconKey.x.data, size: 13, color: AppColors.ink),
        ),
      ),
    );
  }
}

class _ClearPlanDialog extends StatelessWidget {
  final int stopCount;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const _ClearPlanDialog({
    required this.stopCount,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.circular(AppRadii.banner),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.coralSoft,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.delete_outline_rounded,
                size: 18,
                color: Color(0xFF993C1D),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              scope.t('trip_clearThisPlanTitle'),
              style: AppText.h1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              scope.t('trip_clearThisPlanBody', {'count': stopCount.toString()}),
              style: AppText.noteSub,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: AppColors.line),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: onCancel,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          scope.t('trip_cancel'),
                          textAlign: TextAlign.center,
                          style: AppText.chip,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Material(
                    color: AppColors.maroon,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: onConfirm,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          scope.t('trip_clearPlan'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: AppText.poppins,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StopDetailSheet extends StatelessWidget {
  final StopItem stop;
  final VoidCallback onGetDirections;

  const _StopDetailSheet({required this.stop, required this.onGetDirections});

  @override
  Widget build(BuildContext context) {
    return _SheetShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(child: _Grabber()),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBadge(
                icon: stop.iconKey.data,
                color: stop.color,
                background: stop.soft,
                size: 46,
                iconSize: 21,
                radius: AppRadii.sheetIcon,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(stop.title, style: AppText.sheetTitle),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('${stop.time} · ${stop.sub}', style: AppText.sheetSub),
                    ),
                  ],
                ),
              ),
              _SheetCloseButton(onTap: () => Navigator.of(context).pop()),
            ],
          ),
          if (stop.note != null) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.coralSoft,
                borderRadius: BorderRadius.circular(AppRadii.banner),
              ),
              child: RichText(
                text: TextSpan(
                  style: AppText.sheetNote,
                  children: [
                    TextSpan(
                      text: AppScope.of(context).t('trip_notePrefix'),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: stop.note),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Material(
              color: AppColors.ink,
              borderRadius: BorderRadius.circular(AppRadii.sheetBtn),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadii.sheetBtn),
                onTap: onGetDirections,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Center(
                    child: Text(AppScope.of(context).t('trip_getDirections'), style: AppText.sheetBtn),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// ADD-STOP SHEET
// =========================================================================

class _AddStopSheet extends StatefulWidget {
  final ValueChanged<StopItem> onSubmit;
  const _AddStopSheet({required this.onSubmit});

  @override
  State<_AddStopSheet> createState() => _AddStopSheetState();
}

class _AddStopSheetState extends State<_AddStopSheet> {
  final _titleCtrl = TextEditingController();
  final _timeCtrl = TextEditingController();
  final _subCtrl = TextEditingController();
  StopCategory _selected = StopCategory.food;
  bool _showError = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _timeCtrl.dispose();
    _subCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleCtrl.text.trim();
    final timeStr = _timeCtrl.text.trim();
    final sub = _subCtrl.text.trim();
    final minutes = parseTimeToMinutes(timeStr);

    if (title.isEmpty || minutes == null) {
      setState(() => _showError = true);
      return;
    }

    final def = _selected.def;
    final defaultSub = AppScope.of(context).t('trip_addedToPlan');
    final stop = StopItem(
      id: 'custom-${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      time: timeStr,
      minutes: minutes,
      iconKey: def.iconKey,
      color: def.color,
      soft: def.soft,
      sub: sub.isNotEmpty ? sub : defaultSub,
    );
    widget.onSubmit(stop);
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    return _SheetShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(child: _Grabber()),
          Row(
            children: [
              Expanded(
                child: Text(scope.t('trip_addAStop'), style: AppText.addSheetTitle),
              ),
              _SheetCloseButton(onTap: () => Navigator.of(context).pop()),
            ],
          ),
          _FormField(
            label: scope.t('trip_fieldTitle'),
            controller: _titleCtrl,
            hint: scope.t('trip_hintTitleExample'),
          ),
          _FormField(
            label: scope.t('trip_fieldTime'),
            controller: _timeCtrl,
            hint: scope.t('trip_hintExample'),
          ),
          _FormField(
            label: scope.t('trip_fieldDetailsOptional'),
            controller: _subCtrl,
            hint: scope.t('trip_hintDetailsExample'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Text(scope.t('trip_categoryLabel'), style: AppText.fieldLabel),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: StopCategory.values.map((cat) {
              final active = cat == _selected;
              return _CategoryChip(
                label: scope.t(cat.labelKey),
                active: active,
                onTap: () => setState(() => _selected = cat),
              );
            }).toList(),
          ),
          if (_showError)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                scope.t('trip_formError'),
                style: AppText.formError,
              ),
            ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Material(
              color: AppColors.ink,
              borderRadius: BorderRadius.circular(AppRadii.sheetBtn),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadii.sheetBtn),
                onTap: _submit,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Center(
                    child: Text(scope.t('trip_addToPlan'), style: AppText.sheetBtn),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;

  const _FormField({
    required this.label,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(label, style: AppText.fieldLabel),
          ),
          TextField(
            controller: controller,
            style: AppText.fieldInput,
            cursorColor: AppColors.teal,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppText.fieldInput.copyWith(color: AppColors.muted),
              filled: true,
              fillColor: AppColors.bgSoft,
              contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 11),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.field),
                borderSide: const BorderSide(color: AppColors.line),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.field),
                borderSide: const BorderSide(color: AppColors.line),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.field),
                borderSide: const BorderSide(color: AppColors.teal, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active ? AppColors.ink : AppColors.bgSoft,
      borderRadius: BorderRadius.circular(AppRadii.pill),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.pill),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.pill),
            border: Border.all(
              color: active ? AppColors.ink : AppColors.line,
            ),
          ),
          child: Text(label, style: active ? AppText.catOptActive : AppText.catOpt),
        ),
      ),
    );
  }
}