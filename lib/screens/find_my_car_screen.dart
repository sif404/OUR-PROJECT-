import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/app_scope.dart';
import '../theme/app_tokens.dart';
import '../theme/app_colors.dart';
import '../routes.dart';

class _FindMyCarPalette {
  _FindMyCarPalette._();

  static Color background(bool isLight) => isLight ? const Color(0xFFF3EEE4) : const Color(0xFF121212);
  static Color surface(bool isLight) => isLight ? Colors.white : const Color(0xFF1A1A1A);
  static Color mapSurface(bool isLight) => isLight ? const Color(0xFFEFEADD) : const Color(0xFF161616);
  static Color gridLine(bool isLight) => isLight ? const Color(0xFFDCD4C2) : const Color(0xFF3A3A3A);
  static Color ink(bool isLight) => isLight ? const Color(0xFF1F1B16) : const Color(0xFFF2F1EC);
  static Color inkMuted(bool isLight) => isLight ? const Color(0xFF8B8477) : const Color(0xFFB6B2A8);
  static Color amber(bool isLight) => const Color(0xFFC8912B);
  static Color amberSoft(bool isLight) => isLight ? const Color(0xFFF3E3C2) : const Color(0xFF332A14);
  static Color teal(bool isLight) => const Color(0xFF3FB39A);
  static Color tealSoft(bool isLight) => isLight ? const Color(0xFFCDEAE3) : const Color(0xFF0E2E20);
  static Color red(bool isLight) => const Color(0xFFB3392E);
}

class FindMyCarScreen extends StatefulWidget {
  const FindMyCarScreen({super.key});

  @override
  State<FindMyCarScreen> createState() => _FindMyCarScreenState();
}

class _FindMyCarScreenState extends State<FindMyCarScreen> with SingleTickerProviderStateMixin {
  // Compass heading toward the saved car, in degrees.
  static const double _headingDegrees = 138;

  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: _FindMyCarPalette.background(isLight),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: AppTokens.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Header
              _Header(onBack: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.homeDashboard, (_) => false);
                }
              }),

              const SizedBox(height: AppTokens.space16),

              // Saved parking slot info card (up top, near the header)
              _SavedSlotCard(
                zoneLabel: AppScope.of(context).t('findCar_zoneLabel'),
                savedAgo: AppScope.of(context).t('findCar_savedAgo'),
                etaMinutes: AppScope.of(context).t('findCar_etaMinutes'),
                distance: AppScope.of(context).t('findCar_distance'),
              ),

              const SizedBox(height: AppTokens.space16),

              // Parking grid / locator map — fixed aspect ratio card so
              // it doesn't sprawl into dead space on tall screens.
              AspectRatio(
                aspectRatio: 1.35,
                child: _ParkingMapCard(
                  headingDegrees: _headingDegrees,
                  pulse: _pulseController,
                ),
              ),

              const SizedBox(height: AppTokens.space12),

              const Spacer(),

              // Compass tracking pill
              _CompassTrackingCard(headingDegrees: _headingDegrees),

              const SizedBox(height: AppTokens.space16),

              // Start Walkback guided button
              ElevatedButton.icon(
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(Routes.homeDashboard, (_) => false);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _FindMyCarPalette.red(isLight),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
                  ),
                ),
                icon: const Icon(Icons.navigation_rounded, size: 18),
                label: Text(
                  AppScope.of(context).t('findCar_startWalkback'),
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1),
                ),
              ),

              const SizedBox(height: AppTokens.space24),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Row(
      children: [
        Material(
          color: _FindMyCarPalette.surface(isLight),
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onBack,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.arrow_back_rounded, color: _FindMyCarPalette.ink(isLight), size: 20),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppScope.of(context).t('findCar_title'),
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _FindMyCarPalette.ink(isLight),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              AppScope.of(context).t('findCar_activeLocatorLabel'),
              style: TextStyle(fontSize: 12, color: _FindMyCarPalette.inkMuted(isLight)),
            ),
          ],
        ),
      ],
    );
  }
}

class _SavedSlotCard extends StatelessWidget {
  const _SavedSlotCard({
    required this.zoneLabel,
    required this.savedAgo,
    required this.etaMinutes,
    required this.distance,
  });

  final String zoneLabel;
  final String savedAgo;
  final String etaMinutes;
  final String distance;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: const EdgeInsets.all(AppTokens.space16),
      decoration: BoxDecoration(
        color: _FindMyCarPalette.surface(isLight),
        borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
        boxShadow: isLight
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
        border: isLight ? null : Border.all(color: _FindMyCarPalette.gridLine(isLight), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _FindMyCarPalette.amberSoft(isLight),
                  borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
                ),
                child: Icon(Icons.directions_car_rounded, color: _FindMyCarPalette.amber(isLight), size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppScope.of(context).t('findCar_savedSlotLabel'),
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: _FindMyCarPalette.amber(isLight), letterSpacing: 0.5),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    zoneLabel,
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: _FindMyCarPalette.ink(isLight),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    savedAgo,
                    style: TextStyle(fontSize: 10, color: _FindMyCarPalette.inkMuted(isLight)),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                etaMinutes,
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: _FindMyCarPalette.amber(isLight),
                ),
              ),
              Text(
                distance,
                style: TextStyle(fontSize: 10, color: _FindMyCarPalette.inkMuted(isLight)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompassTrackingCard extends StatelessWidget {
  const _CompassTrackingCard({required this.headingDegrees});

  final double headingDegrees;

  String get _cardinal {
    const dirs = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"];
    final index = ((headingDegrees % 360) / 45).round() % 8;
    return dirs[index];
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _FindMyCarPalette.surface(isLight),
        borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
        boxShadow: isLight
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
        border: isLight ? null : Border.all(color: _FindMyCarPalette.gridLine(isLight), width: 1),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _FindMyCarPalette.red(isLight).withOpacity(0.35)),
                  ),
                ),
                Transform.rotate(
                  angle: headingDegrees * math.pi / 180,
                  child: Icon(Icons.navigation_rounded, size: 16, color: _FindMyCarPalette.red(isLight)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppScope.of(context).t('findCar_compassTracking'),
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _FindMyCarPalette.ink(isLight), letterSpacing: 0.5),
              ),
              const SizedBox(height: 2),
              Text(
                "${headingDegrees.toInt()}° $_cardinal",
                style: TextStyle(fontSize: 11, color: _FindMyCarPalette.inkMuted(isLight)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Thin wrapper around the parking grid — kept flat and flush with the
/// page background (no card border/shadow), matching the reference look.
class _ParkingMapCard extends StatelessWidget {
  const _ParkingMapCard({required this.headingDegrees, required this.pulse});

  final double headingDegrees;
  final Animation<double> pulse;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return _ParkingGrid(headingDegrees: headingDegrees, pulse: pulse, isLight: isLight);
  }
}

/// Grid-based parking locator: a 6x2 grid of stalls, the car's saved
/// stall highlighted, a dashed walking path, a directional arrow, and
/// the user's current (pulsing) position marker.
class _ParkingGrid extends StatelessWidget {
  const _ParkingGrid({required this.headingDegrees, required this.pulse, required this.isLight});

  final double headingDegrees;
  final Animation<double> pulse;
  final bool isLight;

  static const int columns = 6;
  static const int rows = 2;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final cellW = width / columns;
        final cellH = height / rows;

        final carCenter = Offset(cellW * 2 + cellW / 2, cellH / 2);
        final userCenter = Offset(cellW * 4 + cellW / 2, cellH * 0.85);

        return Stack(
          children: [
            Column(
              children: List.generate(rows, (row) {
                return Expanded(
                  child: Row(
                    children: List.generate(columns, (col) {
                      return Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: _FindMyCarPalette.gridLine(isLight), width: 0.75),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ),

            Positioned(
              left: 0,
              right: 0,
              top: cellH - 0.5,
              child: CustomPaint(
                size: Size(width, 1),
                painter: _DashedPathPainter(
                  start: const Offset(0, 0.5),
                  end: Offset(width, 0.5),
                  color: _FindMyCarPalette.amber(isLight).withOpacity(0.35),
                  dashWidth: 5,
                  dashSpace: 4,
                ),
              ),
            ),

            Positioned.fill(
              child: CustomPaint(
                painter: _DashedPathPainter(
                  start: userCenter,
                  end: carCenter,
                  color: _FindMyCarPalette.amber(isLight).withOpacity(0.55),
                ),
              ),
            ),

            Positioned(
              left: (userCenter.dx + carCenter.dx) / 2 - 12,
              top: (userCenter.dy + carCenter.dy) / 2 - 12,
              child: Transform.rotate(
                angle: math.atan2(
                  carCenter.dy - userCenter.dy,
                  carCenter.dx - userCenter.dx,
                ) + math.pi / 2,
                child: Icon(Icons.navigation_rounded, size: 22, color: _FindMyCarPalette.amber(isLight)),
              ),
            ),

            Positioned(
              left: carCenter.dx - 34,
              top: carCenter.dy - 34,
              child: AnimatedBuilder(
                animation: pulse,
                builder: (context, child) {
                  final t = Curves.easeInOut.transform(pulse.value);
                  final ringScale = 0.85 + (t * 0.45);
                  final ringOpacity = 0.45 - (t * 0.4);
                  final bob = -10 * t;
                  final iconScale = 1.0 + (t * 0.12);
                  return SizedBox(
                    width: 68,
                    height: 68,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.scale(
                          scale: ringScale,
                          child: CustomPaint(
                            size: const Size(68, 68),
                            painter: _DashedCirclePainter(
                              color: _FindMyCarPalette.teal(isLight).withOpacity(ringOpacity.clamp(0.0, 1.0)),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, bob),
                          child: Transform.scale(
                            scale: iconScale,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: _FindMyCarPalette.surface(isLight),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: _FindMyCarPalette.teal(isLight), width: 1.5),
                                boxShadow: isLight
                                    ? [
                                        BoxShadow(
                                          color: _FindMyCarPalette.teal(isLight).withOpacity(0.3),
                                          blurRadius: 8 + (t * 6),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Icon(Icons.directions_car_rounded, size: 16, color: _FindMyCarPalette.teal(isLight)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Positioned(
              left: userCenter.dx - 20,
              top: userCenter.dy - 20,
              child: AnimatedBuilder(
                animation: pulse,
                builder: (context, child) {
                  final scale = 0.85 + (pulse.value * 0.3);
                  return SizedBox(
                    width: 40,
                    height: 40,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.scale(
                          scale: scale,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _FindMyCarPalette.tealSoft(isLight).withOpacity(1 - pulse.value * 0.4),
                            ),
                          ),
                        ),
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _FindMyCarPalette.teal(isLight),
                            border: Border.all(color: isLight ? Colors.white : _FindMyCarPalette.surface(isLight), width: 2),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  _DashedCirclePainter({required this.color, this.dashCount = 24});

  final Color color;
  final int dashCount;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = size.center(Offset.zero);
    final radius = size.width / 2;
    const gapFraction = 0.5; // fraction of each segment left as a gap

    for (int i = 0; i < dashCount; i++) {
      final startAngle = (i / dashCount) * 2 * math.pi;
      final sweep = (1 / dashCount) * 2 * math.pi * (1 - gapFraction);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweep,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedCirclePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.dashCount != dashCount;
  }
}

class _DashedPathPainter extends CustomPainter {
  _DashedPathPainter({
    required this.start,
    required this.end,
    required this.color,
    this.dashWidth = 6,
    this.dashSpace = 5,
  });

  final Offset start;
  final Offset end;
  final Color color;
  final double dashWidth;
  final double dashSpace;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final totalDistance = (end - start).distance;
    if (totalDistance == 0) return;
    final direction = (end - start) / totalDistance;

    double covered = 0;
    while (covered < totalDistance) {
      final segmentStart = start + direction * covered;
      final segmentEndDistance = math.min(covered + dashWidth, totalDistance);
      final segmentEnd = start + direction * segmentEndDistance;
      canvas.drawLine(segmentStart, segmentEnd, paint);
      covered += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedPathPainter oldDelegate) {
    return oldDelegate.start != start || oldDelegate.end != end || oldDelegate.color != color;
  }
}