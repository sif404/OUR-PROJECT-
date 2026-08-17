import 'package:flutter/material.dart';

const _red = Color(0xFFCE1126);

/// Renders the small 48x48-viewBox badge icon for each onboarding slide,
/// transcribed from the `slides[i].icon` inline SVGs.
class OnboardingBadgeIcon extends StatelessWidget {
  const OnboardingBadgeIcon({super.key, required this.type, this.size = 62});
  final BadgeIconType type;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: switch (type) {
          BadgeIconType.discover => _DiscoverIconPainter(),
          BadgeIconType.parking => _ParkingIconPainter(),
          BadgeIconType.safety => _SafetyIconPainter(),
          BadgeIconType.getStarted => _SparkleIconPainter(),
        },
      ),
    );
  }
}

enum BadgeIconType { discover, parking, safety, getStarted }

/// Slide 1 — "Discover the smart city": a ticket/banner outline with a
/// map-pin glyph centered inside.
class _DiscoverIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 48;
    final stroke = Paint()
      ..color = _red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4 * s
      ..strokeJoin = StrokeJoin.round;

    final banner = Path()
      ..moveTo(6 * s, 12 * s)
      ..lineTo(17 * s, 8 * s)
      ..lineTo(31 * s, 12 * s)
      ..lineTo(42 * s, 8 * s)
      ..lineTo(42 * s, 36 * s)
      ..lineTo(31 * s, 40 * s)
      ..lineTo(17 * s, 36 * s)
      ..lineTo(6 * s, 40 * s)
      ..close();
    canvas.drawPath(banner, stroke);

    final dashStroke = Paint()
      ..color = _red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6 * s;
    _dashed(canvas, Offset(17 * s, 8 * s), Offset(17 * s, 36 * s), dashStroke, s);
    _dashed(canvas, Offset(31 * s, 12 * s), Offset(31 * s, 40 * s), dashStroke, s);

    final pin = Path()
      ..moveTo(24 * s, 14 * s)
      ..cubicTo(20.7 * s, 14 * s, 18 * s, 16.7 * s, 18 * s, 20 * s)
      ..cubicTo(18 * s, 24.5 * s, 24 * s, 32 * s, 24 * s, 32 * s)
      ..cubicTo(24 * s, 32 * s, 30 * s, 24.5 * s, 30 * s, 20 * s)
      ..cubicTo(30 * s, 16.7 * s, 27.3 * s, 14 * s, 24 * s, 14 * s)
      ..close();
    canvas.drawPath(pin, Paint()..color = _red);
    canvas.drawCircle(Offset(24 * s, 20 * s), 2.3 * s, Paint()..color = Colors.white);
  }

  void _dashed(Canvas canvas, Offset a, Offset b, Paint paint, double s) {
    const dash = 1.0, gap = 4.0;
    final total = (b - a).distance;
    final dir = (b - a) / total;
    double d = 0;
    while (d < total) {
      canvas.drawLine(a + dir * d, a + dir * (d + dash * s).clamp(0.0, total), paint);
      d += (dash + gap) * s;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Slide 2 — "Find your car": a simplified car glyph (roofline + body +
/// two wheels).
class _ParkingIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 48;
    final stroke = Paint()
      ..color = _red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6 * s
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final roof = Path()
      ..moveTo(8 * s, 29 * s)
      ..lineTo(11 * s, 20 * s)
      ..quadraticBezierTo(12.5 * s, 17 * s, 16 * s, 17 * s)
      ..lineTo(30 * s, 17 * s)
      ..quadraticBezierTo(33 * s, 17 * s, 35 * s, 20 * s)
      ..lineTo(38 * s, 29 * s);
    canvas.drawPath(roof, stroke);

    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(6 * s, 29 * s, 36 * s, 8.5 * s),
      Radius.circular(2 * s),
    );
    canvas.drawRRect(body, stroke);

    final wheelFill = Paint()..color = const Color(0xFFFBF6EA);
    final wheelStroke = Paint()
      ..color = _red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4 * s;
    canvas.drawCircle(Offset(15 * s, 37.5 * s), 3.4 * s, wheelFill);
    canvas.drawCircle(Offset(15 * s, 37.5 * s), 3.4 * s, wheelStroke);
    canvas.drawCircle(Offset(31 * s, 37.5 * s), 3.4 * s, wheelFill);
    canvas.drawCircle(Offset(31 * s, 37.5 * s), 3.4 * s, wheelStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Slide 3 — "Your safety first": a shield/circle with an exclamation
/// mark, matching the emergency-SOS motif.
class _SafetyIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 48;
    final ring = Paint()
      ..color = _red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3 * s;
    canvas.drawCircle(Offset(24 * s, 24 * s), 19 * s, ring);

    final bar = Paint()
      ..color = _red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.4 * s
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(24 * s, 14 * s), Offset(24 * s, 27 * s), bar);

    canvas.drawCircle(Offset(24 * s, 34 * s), 1.9 * s, Paint()..color = _red);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Slide 4 — "Ready to start?": a 4-point sparkle/star.
class _SparkleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 48;
    final stroke = Paint()
      ..color = _red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6 * s
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(24 * s, 6 * s)
      ..lineTo(27.4 * s, 18.6 * s)
      ..lineTo(40 * s, 22 * s)
      ..lineTo(27.4 * s, 25.4 * s)
      ..lineTo(24 * s, 38 * s)
      ..lineTo(20.6 * s, 25.4 * s)
      ..lineTo(8 * s, 22 * s)
      ..lineTo(20.6 * s, 18.6 * s)
      ..close();
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
