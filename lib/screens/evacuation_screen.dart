import 'dart:async';
import 'package:flutter/material.dart';
import '../models/app_scope.dart';

abstract class EvacuationColors {
  EvacuationColors._();

  static const Color bgPage = Color(0xFFFFFFFF);
  static const Color surface1 = Color(0xFFFFFFFF);
  static const Color surfaceCard = Color(0xFFFFFFFF);
  static const Color surfaceChip = Color(0xFFF4F4F5);

  static const Color borderStrong = Color(0xFFDCDCDF);
  static const Color borderSoft = Color(0xFFEDEDF0);

  static const Color ink = Color(0xFF222226);
  static const Color inkSoft = Color(0xFF3A3A3F);
  static const Color muted = Color(0xFF6B7280);
  static const Color muted2 = Color(0xFF8A8F98);

  static const Color iris = Color(0xFF2F6FED);
  static const Color irisLight = Color(0xFF5C93F5);
  static const Color irisPale = Color(0xFF1D4ED8);
  static const Color irisDeep = Color(0xFF1E4FBE);

  static const Color sand = Color(0xFFD97A4D);
  static const Color sandDeep = Color(0xFFB65A2E);

  static const Color amber = Color(0xFFE8A33D);
  static const Color danger = Color(0xFFCE1126);
  static const Color dangerDeep = Color(0xFF8E0C1D);
  static const Color safe = Color(0xFF4CAF6D);
}

@immutable
class ExitStatus {
  final String name;
  final String? badgeLabel;
  final String statusLabel;
  final Color statusColor;
  final bool recommended;
  final bool unavailable;

  const ExitStatus({
    required this.name,
    this.badgeLabel,
    required this.statusLabel,
    required this.statusColor,
    this.recommended = false,
    this.unavailable = false,
  });
}

abstract class EvacuationData {
  EvacuationData._();

  static const String officialTitle = 'Official Stadium Evacuation';
  static const String officialSubtitle = 'Broadcast by Stadium Operations Center';
  static const String officialBroadcastTime = 'Broadcast 21:42';
  static const String officialStatus = 'Status: Controlled';

  static const String headerTitle = 'Emergency Evacuation in Progress';
  static const String headerLeadIn = 'Please stay calm.';
  static const String headerRest =
      ' Follow the recommended route. Your route is continuously updated '
      'to avoid crowded areas.';

  static const String a11yVoice = 'Voice on';
  static const String a11yHaptics = 'Haptics';
  static const String a11yContrast = 'High contrast';

  static const String liveLabel = 'LIVE';
  static const String routeToastMessage =
      'Your route has been updated to avoid increasing congestion.';

  static const String routeEta = '9 min walk';
  static const String routeRemaining = '450 m remaining';
  static const String routeExitTag = 'Gate 5 · Clear';
  static const String routeStartLabel = 'Section 214, Row F — your location';
  static const String routeEndLabel = 'Gate 5 — safe exit';

  static const String aiLeadIn = 'Recommended';
  static const String aiRest =
      ' because this route currently provides the fastest and safest '
      'evacuation based on live crowd conditions.';

  static const String exitSectionLabel = 'Live exit status';
  static const List<ExitStatus> exits = [
    ExitStatus(
      name: 'Gate 5',
      badgeLabel: 'Your route',
      statusLabel: 'Low crowd',
      statusColor: EvacuationColors.safe,
      recommended: true,
    ),
    ExitStatus(
      name: 'Gate 3',
      statusLabel: 'Moderate',
      statusColor: EvacuationColors.amber,
    ),
    ExitStatus(
      name: 'Gate 1',
      statusLabel: 'Busy',
      statusColor: EvacuationColors.sandDeep,
    ),
    ExitStatus(
      name: 'Gate 7',
      statusLabel: 'Unavailable',
      statusColor: EvacuationColors.danger,
      unavailable: true,
    ),
  ];

  static const String reassureLeadIn = 'Walk calmly. Do not run.';
  static const String reassureRest =
      " Your recommended route avoids crowded areas and is continuously "
      "optimized for everyone's safety.";

  static const String safeButtonLabel = "I'm Safe";

  static const String modalTitle = "Confirm you're safe?";
  static const String modalSubtitle =
      'This will end Evacuation Mode for your device. You can reopen it '
      'anytime from the Emergency section if needed.';
  static const String modalConfirmLabel = "Yes, I'm safe";
  static const String modalCancelLabel = 'Keep guiding me';

  static const String confirmedTitle = "Glad you're safe";
  static const String confirmedSubtitle =
      'Evacuation Mode has ended for your device. Reopen it anytime from '
      'the Emergency section if you need guidance again.';
  static const String confirmedReopenLabel = 'Reopen Evacuation Mode';
}

class OfficialBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String broadcastTime;
  final String status;

  const OfficialBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.broadcastTime,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: EvacuationColors.iris.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: EvacuationColors.iris.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            margin: const EdgeInsets.only(top: 1),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: EvacuationColors.iris,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 15, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    color: EvacuationColors.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: EvacuationColors.muted,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _MetaPill(broadcastTime),
                    const SizedBox(width: 12),
                    _MetaPill(status),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  final String label;
  const _MetaPill(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: EvacuationColors.iris.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
          color: EvacuationColors.irisPale,
        ),
      ),
    );
  }
}

class EvacuationHeader extends StatelessWidget {
  final String title;
  final String leadIn;
  final String rest;

  const EvacuationHeader({
    super.key,
    required this.title,
    required this.leadIn,
    required this.rest,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: EvacuationColors.ink,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 6),
          Text.rich(
            TextSpan(
              style: const TextStyle(
                fontSize: 11.5,
                color: EvacuationColors.muted,
                height: 1.6,
              ),
              children: [
                TextSpan(
                  text: leadIn,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: EvacuationColors.inkSoft,
                  ),
                ),
                TextSpan(text: rest),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccessibilityStrip extends StatelessWidget {
  final String voiceLabel;
  final String hapticsLabel;
  final String contrastLabel;

  const AccessibilityStrip({
    super.key,
    required this.voiceLabel,
    required this.hapticsLabel,
    required this.contrastLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 4),
      child: Row(
        children: [
          _A11yPill(icon: Icons.volume_up_outlined, label: voiceLabel),
          const SizedBox(width: 8),
          _A11yPill(icon: Icons.vibration, label: hapticsLabel),
          const SizedBox(width: 8),
          _A11yPill(icon: Icons.visibility_outlined, label: contrastLabel),
        ],
      ),
    );
  }
}

class _A11yPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _A11yPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: EvacuationColors.surfaceChip,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: EvacuationColors.borderSoft),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: EvacuationColors.sand),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              color: EvacuationColors.inkSoft,
            ),
          ),
        ],
      ),
    );
  }
}

class LiveRouteMap extends StatefulWidget {
  final String liveLabel;
  final String toastMessage;

  const LiveRouteMap({
    super.key,
    required this.liveLabel,
    required this.toastMessage,
  });

  @override
  State<LiveRouteMap> createState() => _LiveRouteMapState();
}

class _LiveRouteMapState extends State<LiveRouteMap>
    with TickerProviderStateMixin {
  late final AnimationController _markerController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..repeat();

  late final AnimationController _dashController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  late final AnimationController _pulseController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat();

  late final AnimationController _liveBlinkController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  bool _showToast = false;
  Timer? _toastShowTimer;
  Timer? _toastHideTimer;
  Timer? _toastLoopTimer;

  @override
  void initState() {
    super.initState();
    _toastShowTimer = Timer(const Duration(seconds: 3), _triggerToast);
  }

  void _triggerToast() {
    if (!mounted) return;
    setState(() => _showToast = true);
    _toastHideTimer = Timer(const Duration(milliseconds: 4200), () {
      if (!mounted) return;
      setState(() => _showToast = false);
    });
    _toastLoopTimer = Timer(const Duration(seconds: 14), _triggerToast);
  }

  @override
  void dispose() {
    _markerController.dispose();
    _dashController.dispose();
    _pulseController.dispose();
    _liveBlinkController.dispose();
    _toastShowTimer?.cancel();
    _toastHideTimer?.cancel();
    _toastLoopTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 12, 14, 0),
      height: 190,
      decoration: BoxDecoration(
        color: EvacuationColors.surfaceChip,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: EvacuationColors.borderSoft),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: Listenable.merge(
                  [_markerController, _dashController, _pulseController]),
              builder: (context, _) {
                return CustomPaint(
                  painter: _RouteMapPainter(
                    markerT: _markerController.value,
                    dashPhase: _dashController.value * 16,
                    pulseT: _pulseController.value,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: EvacuationColors.iris.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: EvacuationColors.iris.withOpacity(0.35)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: _liveBlinkController,
                    builder: (context, _) {
                      return Opacity(
                        opacity: 1 - (_liveBlinkController.value * 0.7),
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: EvacuationColors.irisLight,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 6),
                  Text(
                    widget.liveLabel,
                    style: const TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      color: EvacuationColors.irisPale,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 500),
              offset: _showToast ? Offset.zero : const Offset(0, 0.15),
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _showToast ? 1 : 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: EvacuationColors.borderStrong),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF14141E).withOpacity(0.1),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.refresh, size: 12, color: EvacuationColors.iris),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.toastMessage,
                          style: const TextStyle(
                            fontSize: 9.5,
                            color: EvacuationColors.ink,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
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

class _RouteMapPainter extends CustomPainter {
  final double markerT;
  final double dashPhase;
  final double pulseT;

  _RouteMapPainter({
    required this.markerT,
    required this.dashPhase,
    required this.pulseT,
  });

  static const double _vbWidth = 300;
  static const double _vbHeight = 190;

  Path _routePath() {
    final path = Path()..moveTo(40, 160);
    path.cubicTo(90, 130, 70, 90, 130, 75);
    path.cubicTo(190, 60, 220, 55, 260, 25);
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final scaleX = size.width / _vbWidth;
    final scaleY = size.height / _vbHeight;
    canvas.save();
    canvas.scale(scaleX, scaleY);

    _paintGrid(canvas);

    final path = _routePath();

    final trackPaint = Paint()
      ..color = EvacuationColors.iris.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, trackPaint);

    final dashedPath = _dashedPath(path, 9, 7, dashPhase);
    final dashPaint = Paint()
      ..color = EvacuationColors.iris
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(dashedPath, dashPaint);

    canvas.drawCircle(const Offset(40, 160), 7,
        Paint()..color = EvacuationColors.ink);
    canvas.drawCircle(const Offset(260, 25), 8,
        Paint()..color = EvacuationColors.safe);

    final metrics = path.computeMetrics().toList();
    if (metrics.isNotEmpty) {
      final metric = metrics.first;
      final tangent = metric.getTangentForOffset(metric.length * markerT);
      final pos = tangent?.position ?? const Offset(40, 160);

      final pulseRadius = 7 + (11 * pulseT);
      final pulseOpacity = (0.8 * (1 - pulseT)).clamp(0.0, 1.0);
      canvas.drawCircle(
        pos,
        pulseRadius,
        Paint()..color = EvacuationColors.iris.withOpacity(pulseOpacity * 0.25),
      );

      canvas.drawCircle(pos, 7, Paint()..color = EvacuationColors.iris);
      canvas.drawCircle(
        pos,
        7,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }

    canvas.restore();
  }

  void _paintGrid(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const step = 26.0;
    for (double x = -step; x < _vbWidth + step; x += step) {
      for (double y = -step; y < _vbHeight + step; y += step) {
        final diamond = Path()
          ..moveTo(x + step / 2, y)
          ..lineTo(x + step, y + step / 2)
          ..lineTo(x + step / 2, y + step)
          ..lineTo(x, y + step / 2)
          ..close();
        canvas.drawPath(diamond, paint);
      }
    }
  }

  Path _dashedPath(Path source, double dashLength, double gapLength, double phase) {
    final result = Path();
    final cycle = dashLength + gapLength;
    for (final metric in source.computeMetrics()) {
      double distance = -(phase % cycle);
      if (distance < 0) distance += cycle;
      distance -= cycle;
      while (distance < metric.length) {
        final start = distance.clamp(0.0, metric.length);
        final end = (distance + dashLength).clamp(0.0, metric.length);
        if (end > start) {
          result.addPath(metric.extractPath(start, end), Offset.zero);
        }
        distance += cycle;
      }
    }
    return result;
  }

  @override
  bool shouldRepaint(covariant _RouteMapPainter oldDelegate) {
    return oldDelegate.markerT != markerT ||
        oldDelegate.dashPhase != dashPhase ||
        oldDelegate.pulseT != pulseT;
  }
}

class RouteSummaryCard extends StatelessWidget {
  final String eta;
  final String remaining;
  final String exitTag;
  final String startLabel;
  final String endLabel;

  const RouteSummaryCard({
    super.key,
    required this.eta,
    required this.remaining,
    required this.exitTag,
    required this.startLabel,
    required this.endLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 12, 14, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: EvacuationColors.surfaceCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: EvacuationColors.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eta,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: EvacuationColors.ink,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    remaining,
                    style: const TextStyle(fontSize: 11, color: EvacuationColors.muted),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: EvacuationColors.safe.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: EvacuationColors.safe.withOpacity(0.35)),
                ),
                child: Text(
                  exitTag,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: EvacuationColors.safe,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: EvacuationColors.ink,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 1.5,
                    height: 20,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [EvacuationColors.ink, EvacuationColors.iris],
                      ),
                    ),
                  ),
                  Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: EvacuationColors.safe,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Text(startLabel, style: const _RouteStopStyle()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: Text(endLabel, style: const _RouteStopStyle()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RouteStopStyle extends TextStyle {
  const _RouteStopStyle()
      : super(fontSize: 11.5, color: EvacuationColors.ink);
}

class AiExplanationCard extends StatelessWidget {
  final String leadIn;
  final String rest;

  const AiExplanationCard({super.key, required this.leadIn, required this.rest});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 10, 14, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: EvacuationColors.sand.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: EvacuationColors.sand.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: EvacuationColors.sand.withOpacity(0.15),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(Icons.auto_awesome, size: 14, color: EvacuationColors.sand),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontSize: 10.5,
                  color: EvacuationColors.muted,
                  height: 1.55,
                ),
                children: [
                  TextSpan(
                    text: leadIn,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: EvacuationColors.ink,
                    ),
                  ),
                  TextSpan(text: rest),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExitStatusList extends StatelessWidget {
  final List<ExitStatus> exits;

  const ExitStatusList({super.key, required this.exits});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          for (int i = 0; i < exits.length; i++) ...[
            _ExitRow(exit: exits[i]),
            if (i != exits.length - 1) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _ExitRow extends StatelessWidget {
  final ExitStatus exit;
  const _ExitRow({required this.exit});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: exit.unavailable ? 0.6 : 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: exit.recommended
              ? EvacuationColors.iris.withOpacity(0.06)
              : EvacuationColors.surfaceCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: exit.recommended
                ? EvacuationColors.iris.withOpacity(0.4)
                : EvacuationColors.borderSoft,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: EvacuationColors.surfaceChip,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    exit.unavailable
                        ? Icons.no_meeting_room_outlined
                        : Icons.meeting_room_outlined,
                    size: 14,
                    color: exit.recommended
                        ? EvacuationColors.irisLight
                        : EvacuationColors.muted,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exit.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: EvacuationColors.ink,
                        decoration: exit.unavailable
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: EvacuationColors.borderStrong,
                      ),
                    ),
                    if (exit.badgeLabel != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          exit.badgeLabel!,
                          style: const TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            color: EvacuationColors.irisPale,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: exit.statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  exit.statusLabel,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: exit.statusColor,
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

class ReassuranceCard extends StatelessWidget {
  final String leadIn;
  final String rest;

  const ReassuranceCard({super.key, required this.leadIn, required this.rest});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      decoration: BoxDecoration(
        color: EvacuationColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: EvacuationColors.borderSoft),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            margin: const EdgeInsets.only(top: 1),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: EvacuationColors.iris.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.volunteer_activism_outlined,
                size: 13, color: EvacuationColors.iris),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontSize: 10.5,
                  color: EvacuationColors.muted,
                  height: 1.6,
                ),
                children: [
                  TextSpan(
                    text: leadIn,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: EvacuationColors.ink,
                    ),
                  ),
                  TextSpan(text: rest),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SafeButtonDock extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const SafeButtonDock({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0.96),
            EvacuationColors.surface1,
          ],
          stops: const [0.0, 0.28, 1.0],
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          color: EvacuationColors.danger,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Container(
              height: 52,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.gpp_good_outlined, size: 17, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.5,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ConfirmSafeSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmSafeSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.onConfirm,
    required this.onCancel,
  });

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String confirmLabel,
    required String cancelLabel,
    required VoidCallback onConfirm,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0x73141A20),
      builder: (sheetContext) => ConfirmSafeSheet(
        title: title,
        subtitle: subtitle,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: () {
          Navigator.of(sheetContext).pop();
          onConfirm();
        },
        onCancel: () => Navigator.of(sheetContext).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: EvacuationColors.surfaceCard,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(bottom: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: EvacuationColors.safe.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.gpp_good_outlined,
                  size: 22, color: EvacuationColors.safe),
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: EvacuationColors.ink,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 11.5,
                color: EvacuationColors.muted,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: Material(
                color: EvacuationColors.danger,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: onConfirm,
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    child: Text(
                      confirmLabel,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Material(
                color: EvacuationColors.surfaceChip,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: onCancel,
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: EvacuationColors.borderStrong),
                    ),
                    child: Text(
                      cancelLabel,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: EvacuationColors.inkSoft,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmedPanel extends StatelessWidget {
  final String title;
  final String subtitle;
  final String reopenLabel;
  final VoidCallback onReopen;

  const ConfirmedPanel({
    super.key,
    required this.title,
    required this.subtitle,
    required this.reopenLabel,
    required this.onReopen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: EvacuationColors.surface1,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 76,
            height: 76,
            margin: const EdgeInsets.only(bottom: 18),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: EvacuationColors.safe.withOpacity(0.12),
              shape: BoxShape.circle,
              border: Border.all(color: EvacuationColors.safe.withOpacity(0.35)),
            ),
            child: const Icon(Icons.check, size: 34, color: EvacuationColors.safe),
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: EvacuationColors.ink,
            ),
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 220),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11.5,
                color: EvacuationColors.muted,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Material(
            color: EvacuationColors.iris.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onReopen,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: EvacuationColors.iris.withOpacity(0.35)),
                ),
                child: Text(
                  reopenLabel,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: EvacuationColors.iris,
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

class EvacuationScreen extends StatefulWidget {
  final VoidCallback? onExitEvacuation;

  const EvacuationScreen({super.key, this.onExitEvacuation});

  @override
  State<EvacuationScreen> createState() => _EvacuationScreenState();
}

class _EvacuationScreenState extends State<EvacuationScreen> {
  bool _confirmed = false;

  void _onSafeTap() {
    ConfirmSafeSheet.show(
      context: context,
      title: EvacuationData.modalTitle,
      subtitle: EvacuationData.modalSubtitle,
      confirmLabel: EvacuationData.modalConfirmLabel,
      cancelLabel: EvacuationData.modalCancelLabel,
      onConfirm: () {
        setState(() => _confirmed = true);
      },
    );
  }

  void _onReopen() {
    setState(() => _confirmed = false);
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final bg = isLight ? const Color(0xFFF7F6F2) : const Color(0xFF121212);
    final textColor = isLight ? const Color(0xFF111111) : Colors.white;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: textColor),
          onPressed: () {
            widget.onExitEvacuation?.call();
            Navigator.of(context).maybePop();
          },
        ),
        title: Text(
          AppScope.of(context).t('evac_title'),
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 110),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        OfficialBanner(
                          title: EvacuationData.officialTitle,
                          subtitle: EvacuationData.officialSubtitle,
                          broadcastTime: EvacuationData.officialBroadcastTime,
                          status: EvacuationData.officialStatus,
                        ),
                        EvacuationHeader(
                          title: EvacuationData.headerTitle,
                          leadIn: EvacuationData.headerLeadIn,
                          rest: EvacuationData.headerRest,
                        ),
                        AccessibilityStrip(
                          voiceLabel: EvacuationData.a11yVoice,
                          hapticsLabel: EvacuationData.a11yHaptics,
                          contrastLabel: EvacuationData.a11yContrast,
                        ),
                        LiveRouteMap(
                          liveLabel: EvacuationData.liveLabel,
                          toastMessage: EvacuationData.routeToastMessage,
                        ),
                        RouteSummaryCard(
                          eta: EvacuationData.routeEta,
                          remaining: EvacuationData.routeRemaining,
                          exitTag: EvacuationData.routeExitTag,
                          startLabel: EvacuationData.routeStartLabel,
                          endLabel: EvacuationData.routeEndLabel,
                        ),
                        AiExplanationCard(
                          leadIn: EvacuationData.aiLeadIn,
                          rest: EvacuationData.aiRest,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
                          child: Text(
                            EvacuationData.exitSectionLabel,
                            style: const TextStyle(
                              fontSize: 11,
                              color: EvacuationColors.muted,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const ExitStatusList(exits: EvacuationData.exits),
                        ReassuranceCard(
                          leadIn: EvacuationData.reassureLeadIn,
                          rest: EvacuationData.reassureRest,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeButtonDock(
                label: EvacuationData.safeButtonLabel,
                onTap: _onSafeTap,
              ),
            ),
            if (_confirmed)
              Positioned.fill(
                child: ConfirmedPanel(
                  title: EvacuationData.confirmedTitle,
                  subtitle: EvacuationData.confirmedSubtitle,
                  reopenLabel: EvacuationData.confirmedReopenLabel,
                  onReopen: _onReopen,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
