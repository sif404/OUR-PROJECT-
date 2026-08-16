import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Crest extends StatelessWidget {
  const Crest({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final shadows = isLight
        ? const [
            BoxShadow(
              color: Color(0x598A3A1F),
              blurRadius: 18,
              offset: Offset(0, 12),
            ),
          ]
        : const <BoxShadow>[];
    return Column(
      children: [
        SizedBox(
          width: 92,
          height: 80,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(boxShadow: shadows),
                  child: CustomPaint(
                    size: const Size(92, 80),
                    painter: _CrestPainter(),
                  ),
                ),
              ),
              Positioned(
                left: 31,
                top: 15,
                child: CustomPaint(
                  size: const Size(30, 30),
                  painter: SevenPointedStarPainter(color: const Color(0xFFF5F0E6)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 30, height: 4, color: Colors.black),
            Container(width: 30, height: 4, color: Colors.white),
            Container(width: 30, height: 4, color: const Color(0xFF007A3D)),
          ],
        ),
      ],
    );
  }
}

class _CrestPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 100;
    final sy = size.height / 90;

    final path = Path()
      ..moveTo(10 * sx, 4 * sy)
      ..lineTo(90 * sx, 4 * sy)
      ..arcToPoint(Offset(96 * sx, 10 * sy), radius: Radius.elliptical(6 * sx, 6 * sy))
      ..lineTo(96 * sx, 32 * sy)
      ..quadraticBezierTo(96 * sx, 60 * sy, 50 * sx, 88 * sy)
      ..quadraticBezierTo(4 * sx, 60 * sy, 4 * sx, 32 * sy)
      ..lineTo(4 * sx, 10 * sy)
      ..arcToPoint(Offset(10 * sx, 4 * sy), radius: Radius.elliptical(6 * sx, 6 * sy))
      ..close();

    const gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.crestGradTop, AppColors.crestGradBottom],
    );
    final paint = Paint()..shader = gradient.createShader(Offset.zero & size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SevenPointedStarPainter extends CustomPainter {
  final Color color;
  SevenPointedStarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double outerRadius = size.width / 2;
    final double innerRadius = outerRadius * 0.45;
    const int points = 7;
    const double angleStep = (2 * math.pi) / points;
    const double startAngle = -math.pi / 2;

    final Path path = Path();
    for (int i = 0; i < points * 2; i++) {
      final double radius = (i % 2 == 0) ? outerRadius : innerRadius;
      final double angle = startAngle + (angleStep / 2) * i;
      final double x = cx + radius * math.cos(angle);
      final double y = cy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
