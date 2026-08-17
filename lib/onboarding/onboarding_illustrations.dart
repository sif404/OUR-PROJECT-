import 'package:flutter/material.dart';

/// Faithful-as-practical CustomPainter transcriptions of the four inline
/// `<svg viewBox="0 0 375 190">` illustrations from the onboarding
/// `illustrations` object in the HTML `<script>`. All stroke work uses the
/// same `#B89968` line colour and per-shape opacities as the source; the
/// ground silhouette uses `#DFCEA3` at 0.6 opacity, matching
/// `--illustration`/`--illustration-dark` in the CSS palette.
const _lineColor = Color(0xFFB89968);
const _groundColor = Color(0xFFDFCEA3);
const _flagRed = Color(0xFFCE1126);

class OnboardingIllustration extends StatelessWidget {
  const OnboardingIllustration({super.key, required this.type});
  final IllustrationType type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 190,
      child: CustomPaint(
        size: const Size(double.infinity, 190),
        painter: switch (type) {
          IllustrationType.smartCity => _SmartCityPainter(),
          IllustrationType.parking => _ParkingPainter(),
          IllustrationType.stadium => _StadiumPainter(),
          IllustrationType.getStarted => _GetStartedPainter(),
        },
      ),
    );
  }
}

enum IllustrationType { smartCity, parking, stadium, getStarted }

// ---- shared helpers -------------------------------------------------

Paint _stroke(double w, double opacity, {Color color = _lineColor}) => Paint()
  ..color = color.withValues(alpha: opacity)
  ..style = PaintingStyle.stroke
  ..strokeWidth = w;

Paint _fill(Color color, double opacity) => Paint()
  ..color = color.withValues(alpha: opacity)
  ..style = PaintingStyle.fill;

void _rect(Canvas canvas, double sx, double sy, double x, double y, double w, double h, Paint paint) {
  canvas.drawRect(Rect.fromLTWH(x * sx, y * sy, w * sx, h * sy), paint);
}

void _line(Canvas canvas, double sx, double sy, double x1, double y1, double x2, double y2, Paint paint) {
  canvas.drawLine(Offset(x1 * sx, y1 * sy), Offset(x2 * sx, y2 * sy), paint);
}

void _compass(Canvas canvas, double sx, double sy, double cx, double cy, double r, Paint paint) {
  canvas.drawCircle(Offset(cx * sx, cy * sy), r * sx, paint);
  _line(canvas, sx, sy, cx - r, cy, cx + r, cy, paint);
  _line(canvas, sx, sy, cx, cy - r, cx, cy + r, paint);
  _line(canvas, sx, sy, cx - r * 0.72, cy - r * 0.72, cx + r * 0.72, cy + r * 0.72, paint);
  _line(canvas, sx, sy, cx - r * 0.72, cy + r * 0.72, cx + r * 0.72, cy - r * 0.72, paint);
}

void _dashedLine(Canvas canvas, double sx, double sy, double x1, double y1, double x2, double y2, Paint paint) {
  const dashW = 6.0, gapW = 6.0;
  final p1 = Offset(x1 * sx, y1 * sy);
  final p2 = Offset(x2 * sx, y2 * sy);
  final total = (p2 - p1).distance;
  final dir = (p2 - p1) / total;
  double dist = 0;
  while (dist < total) {
    final start = p1 + dir * dist;
    final end = p1 + dir * (dist + dashW).clamp(0.0, total);
    canvas.drawLine(start, end, paint);
    dist += dashW + gapW;
  }
}

/// Roadside parking-sign glyph (Q-curve roof + slot rectangle + 2 wheels),
/// reused by both the parking and getStarted illustrations.
void _parkingSign(Canvas canvas, double sx, double sy, double ox, double oy, Paint paint) {
  double gx(double x) => (ox + x) * sx;
  double gy(double y) => (oy + y) * sy;
  final path = Path()
    ..moveTo(gx(2), gy(20))
    ..lineTo(gx(6), gy(4))
    ..quadraticBezierTo(gx(8), gy(0), gx(14), gy(0))
    ..lineTo(gx(30), gy(0))
    ..quadraticBezierTo(gx(36), gy(0), gx(38), gy(4))
    ..lineTo(gx(42), gy(20))
    ..close();
  canvas.drawPath(path, paint);
  canvas.drawRect(Rect.fromLTWH(gx(0), gy(20), 44 * sx, 10 * sy), paint);
  canvas.drawCircle(Offset(gx(11), gy(30)), 4 * sx, paint);
  canvas.drawCircle(Offset(gx(33), gy(30)), 4 * sx, paint);
}

// ---- SMART CITY -------------------------------------------------------

class _SmartCityPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 375, sy = size.height / 190;

    final ground = Path()
      ..moveTo(0, 150 * sy)
      ..cubicTo(60 * sx, 130 * sy, 110 * sx, 150 * sy, 180 * sx, 140 * sy)
      ..cubicTo(240 * sx, 132 * sy, 300 * sx, 148 * sy, 375 * sx, 128 * sy)
      ..lineTo(375 * sx, 190 * sy)
      ..lineTo(0, 190 * sy)
      ..close();
    canvas.drawPath(ground, _fill(_groundColor, 0.6));

    final p1 = _stroke(1.4, 0.5);
    _rect(canvas, sx, sy, 292, 62, 14, 68, p1);
    _rect(canvas, sx, sy, 312, 44, 14, 86, p1);
    _rect(canvas, sx, sy, 332, 70, 14, 60, p1);

    _compass(canvas, sx, sy, 238, 58, 25, _stroke(1.4, 0.6));

    // small tree/antenna near x=30,y=108
    final treeP = _stroke(1.6, 0.55);
    _line(canvas, sx, sy, 30, 108, 30, 150, treeP);
    _line(canvas, sx, sy, 30, 108, 47, 102, treeP);
    _line(canvas, sx, sy, 30, 117, 13, 111, treeP);

    // rolling path
    final path2 = Path()
      ..moveTo(0, 160 * sy)
      ..cubicTo(40 * sx, 148 * sy, 70 * sx, 165 * sy, 105 * sx, 158 * sy)
      ..cubicTo(130 * sx, 152 * sy, 140 * sx, 138 * sy, 165 * sx, 134 * sy)
      ..cubicTo(185 * sx, 131 * sy, 195 * sx, 142 * sy, 220 * sx, 140 * sy);
    canvas.drawPath(path2, _stroke(2, 0.55));

    // domed pavilion near x=90..150,y=128..162
    final domeP = _stroke(1.8, 0.6);
    final dome = Path()
      ..moveTo((90 + 0) * sx, (128 + 26) * sy)
      ..cubicTo((90 + 0) * sx, (128 + 10) * sy, (90 + 12) * sx, (128 + 0) * sy, (90 + 30) * sx, (128 + 0) * sy)
      ..cubicTo((90 + 48) * sx, (128 + 0) * sy, (90 + 60) * sx, (128 + 10) * sy, (90 + 60) * sx, (128 + 26) * sy);
    canvas.drawPath(dome, domeP);
    _line(canvas, sx, sy, 90, 154, 90, 162, domeP);
    _line(canvas, sx, sy, 150, 154, 150, 162, domeP);
    _line(canvas, sx, sy, 98, 145, 98, 158, domeP);
    _line(canvas, sx, sy, 112, 138, 112, 158, domeP);
    _line(canvas, sx, sy, 128, 138, 128, 158, domeP);
    _line(canvas, sx, sy, 142, 145, 142, 158, domeP);

    final horizon = Path()
      ..moveTo(0, 178 * sy)
      ..cubicTo(90 * sx, 162 * sy, 160 * sx, 184 * sy, 230 * sx, 170 * sy)
      ..cubicTo(280 * sx, 160 * sy, 330 * sx, 174 * sy, 375 * sx, 162 * sy);
    canvas.drawPath(horizon, _stroke(2, 0.5));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---- STADIUM ------------------------------------------------------------

class _StadiumPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 375, sy = size.height / 190;

    final ground = Path()
      ..moveTo(0, 150 * sy)
      ..cubicTo(60 * sx, 130 * sy, 110 * sx, 150 * sy, 180 * sx, 140 * sy)
      ..cubicTo(240 * sx, 132 * sy, 300 * sx, 148 * sy, 375 * sx, 128 * sy)
      ..lineTo(375 * sx, 190 * sy)
      ..lineTo(0, 190 * sy)
      ..close();
    canvas.drawPath(ground, _fill(_groundColor, 0.6));

    final p1 = _stroke(1.4, 0.55);
    _rect(canvas, sx, sy, 18, 70, 14, 60, p1);
    _rect(canvas, sx, sy, 36, 55, 14, 75, p1);
    _rect(canvas, sx, sy, 54, 80, 14, 50, p1);
    _rect(canvas, sx, sy, 300, 60, 14, 70, p1);
    _rect(canvas, sx, sy, 320, 45, 14, 85, p1);
    _rect(canvas, sx, sy, 340, 75, 14, 55, p1);

    _compass(canvas, sx, sy, 300, 55, 26, _stroke(1.4, 0.6));

    // stadium bowl (two nested ellipses + corner floodlight posts)
    canvas.save();
    canvas.translate(90 * sx, 150 * sy);
    canvas.drawOval(Rect.fromCenter(center: Offset(0, 10 * sy), width: 190 * sx, height: 52 * sy), _stroke(2, 0.7));
    canvas.drawOval(Rect.fromCenter(center: Offset(0, 4 * sy), width: 160 * sx, height: 40 * sy), _stroke(1.6, 0.7));
    final postP = _stroke(1.6, 0.7);
    canvas.drawLine(Offset(-70 * sx, -8 * sy), Offset(-70 * sx, -24 * sy), postP);
    canvas.drawLine(Offset(70 * sx, -8 * sy), Offset(70 * sx, -24 * sy), postP);
    canvas.drawLine(Offset(-70 * sx, -24 * sy), Offset(-58 * sx, -24 * sy), postP);
    canvas.drawLine(Offset(70 * sx, -24 * sy), Offset(58 * sx, -24 * sy), postP);
    canvas.restore();

    final horizon = Path()
      ..moveTo(0, 178 * sy)
      ..cubicTo(90 * sx, 160 * sy, 160 * sx, 185 * sy, 230 * sx, 168 * sy)
      ..cubicTo(280 * sx, 156 * sy, 330 * sx, 172 * sy, 375 * sx, 160 * sy);
    canvas.drawPath(horizon, _stroke(2, 0.5));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---- PARKING --------------------------------------------------------------

class _ParkingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 375, sy = size.height / 190;

    final ground = Path()
      ..moveTo(0, 150 * sy)
      ..cubicTo(70 * sx, 138 * sy, 140 * sx, 152 * sy, 200 * sx, 142 * sy)
      ..cubicTo(260 * sx, 133 * sy, 320 * sx, 148 * sy, 375 * sx, 132 * sy)
      ..lineTo(375 * sx, 190 * sy)
      ..lineTo(0, 190 * sy)
      ..close();
    canvas.drawPath(ground, _fill(_groundColor, 0.6));

    final p1 = _stroke(1.4, 0.55);
    _rect(canvas, sx, sy, 290, 60, 16, 75, p1);
    _rect(canvas, sx, sy, 310, 42, 16, 93, p1);
    _rect(canvas, sx, sy, 330, 70, 16, 65, p1);
    _line(canvas, sx, sy, 30, 60, 30, 135, _stroke(2, 0.55));
    canvas.drawCircle(Offset(30 * sx, 55 * sy), 4 * sx, _fill(_lineColor, 0.55));

    // small lamp post
    final lampP = _stroke(1.6, 0.6);
    _line(canvas, sx, sy, 320, 40, 320, 75, lampP);
    _line(canvas, sx, sy, 320, 40, 338, 50, lampP);

    _line(canvas, sx, sy, 0, 168, 375, 148, _stroke(2, 0.5));
    _dashedLine(canvas, sx, sy, 0, 172, 375, 152, _stroke(1, 0.4));

    // small car (rounded rect + wheels)
    final carP = _stroke(1.8, 0.85);
    final carRect = RRect.fromRectAndRadius(Rect.fromLTWH(60 * sx, 140 * sy, 46 * sx, 18 * sy), Radius.circular(4 * sx));
    canvas.drawRRect(carRect, carP);
    canvas.drawCircle(Offset(70 * sx, 160 * sy), 4 * sx, carP);
    canvas.drawCircle(Offset(96 * sx, 160 * sy), 4 * sx, carP);

    _parkingSign(canvas, sx, sy, 180, 132, _stroke(1.8, 0.9));

    // "P" roundel
    canvas.save();
    canvas.translate(170 * sx, 90 * sy);
    final pin = Path()
      ..moveTo(14 * sx, 0)
      ..cubicTo(21.7 * sx, 0, 28 * sx, 6.3 * sy, 28 * sx, 14 * sy)
      ..cubicTo(28 * sx, 24.5 * sy, 14 * sx, 40 * sy, 14 * sx, 40 * sy)
      ..cubicTo(14 * sx, 40 * sy, 0, 24.5 * sy, 0, 14 * sy)
      ..cubicTo(0, 6.3 * sy, 6.3 * sx, 0, 14 * sx, 0)
      ..close();
    canvas.drawPath(pin, _fill(_flagRed, 1));
    canvas.drawCircle(Offset(14 * sx, 14 * sy), 7 * sx, _fill(Colors.white, 1));
    final tp = TextPainter(
      text: TextSpan(text: 'P', style: TextStyle(fontSize: 10 * sx, fontWeight: FontWeight.w700, color: _flagRed)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(14 * sx - tp.width / 2, 14 * sy - tp.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---- GET STARTED ----------------------------------------------------------

class _GetStartedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 375, sy = size.height / 190;

    final ground = Path()
      ..moveTo(0, 150 * sy)
      ..cubicTo(70 * sx, 136 * sy, 140 * sx, 152 * sy, 200 * sx, 140 * sy)
      ..cubicTo(260 * sx, 130 * sy, 320 * sx, 148 * sy, 375 * sx, 130 * sy)
      ..lineTo(375 * sx, 190 * sy)
      ..lineTo(0, 190 * sy)
      ..close();
    canvas.drawPath(ground, _fill(_groundColor, 0.6));

    final p1 = _stroke(1.4, 0.55);
    _rect(canvas, sx, sy, 20, 70, 14, 60, p1);
    _rect(canvas, sx, sy, 38, 52, 14, 78, p1);
    _rect(canvas, sx, sy, 56, 80, 14, 50, p1);
    _rect(canvas, sx, sy, 290, 58, 14, 72, p1);
    _rect(canvas, sx, sy, 310, 38, 14, 92, p1);
    _rect(canvas, sx, sy, 330, 66, 14, 64, p1);

    final lampP = _stroke(1.6, 0.6);
    _line(canvas, sx, sy, 310, 32, 310, 68, lampP);
    _line(canvas, sx, sy, 310, 32, 330, 44, lampP);

    final treeP = _stroke(1.6, 0.55);
    _line(canvas, sx, sy, 46, 110, 46, 150, treeP);
    _line(canvas, sx, sy, 46, 110, 62, 104, treeP);
    _line(canvas, sx, sy, 46, 118, 30, 112, treeP);

    _line(canvas, sx, sy, 0, 172, 375, 150, _stroke(2, 0.5));
    _dashedLine(canvas, sx, sy, 0, 176, 375, 154, _stroke(1, 0.4));

    _parkingSign(canvas, sx, sy, 245, 140, _stroke(1.8, 0.9));

    // waypoint flag pin with a 4-point sparkle inside (as in the source)
    canvas.save();
    canvas.translate(150 * sx, 80 * sy);
    final pin = Path()
      ..moveTo(16 * sx, 0)
      ..cubicTo(24.8 * sx, 0, 32 * sx, 7.2 * sy, 32 * sx, 16 * sy)
      ..cubicTo(32 * sx, 28 * sy, 16 * sx, 46 * sy, 16 * sx, 46 * sy)
      ..cubicTo(16 * sx, 46 * sy, 0, 28 * sy, 0, 16 * sy)
      ..cubicTo(0, 7.2 * sy, 7.2 * sx, 0, 16 * sx, 0)
      ..close();
    canvas.drawPath(pin, _fill(_flagRed, 1));
    final sparkle = Path()
      ..moveTo(16 * sx, 8 * sy)
      ..lineTo(18.3 * sx, 14.7 * sy)
      ..lineTo(25 * sx, 17 * sy)
      ..lineTo(18.3 * sx, 19.3 * sy)
      ..lineTo(16 * sx, 26 * sy)
      ..lineTo(13.7 * sx, 19.3 * sy)
      ..lineTo(7 * sx, 17 * sy)
      ..lineTo(13.7 * sx, 14.7 * sy)
      ..close();
    canvas.drawPath(sparkle, _fill(Colors.white, 1));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
