import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// .scan-frame — 230x230 dark rounded square with corner brackets, a ghost
/// QR icon, and an animated horizontal scan line
/// (`@keyframes scanmove{ 0%,100%{top:16px} 50%{top:210px} }`, 2.1s
/// ease-in-out infinite).
class ScanFrame extends StatefulWidget {
  const ScanFrame({super.key});

  @override
  State<ScanFrame> createState() => _ScanFrameState();
}

class _ScanFrameState extends State<ScanFrame> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _pos;

  static const double _size = 230;
  static const double _top = 16;
  static const double _bottom = 210;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2100))..repeat(reverse: true);
    _pos = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;
    final frameBg = isLight ? AppColors.domeDeep : const Color(0xFF0B0B1F);
    final ghostColor = isLight ? const Color(0xFFFFFFFF) : const Color(0xFFE0E0FF);
    return Container(
      width: _size,
      height: _size,
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: frameBg,
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: 0.18,
              child: CustomPaint(size: const Size(120, 120), painter: _QrGhostPainter(color: ghostColor)),
            ),
          ),
          ..._corners(cs.primary),
          AnimatedBuilder(
            animation: _pos,
            builder: (context, _) {
              final top = _top + (_bottom - _top) * _pos.value;
              return Positioned(
                left: 14,
                right: 14,
                top: top,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppColors.pitch,
                    boxShadow: [BoxShadow(color: AppColors.pitch.withValues(alpha: 0.7), blurRadius: 14, spreadRadius: 2)],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _corners(Color accent) {
    final c = BorderSide(color: accent, width: 3);
    const none = BorderSide.none;
    return [
      Positioned(
        top: 14,
        left: 14,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            border: Border(top: c, left: c, right: none, bottom: none),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
          ),
        ),
      ),
      Positioned(
        top: 14,
        right: 14,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            border: Border(top: c, right: c, left: none, bottom: none),
            borderRadius: const BorderRadius.only(topRight: Radius.circular(8)),
          ),
        ),
      ),
      Positioned(
        bottom: 14,
        left: 14,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            border: Border(bottom: c, left: c, right: none, top: none),
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8)),
          ),
        ),
      ),
      Positioned(
        bottom: 14,
        right: 14,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            border: Border(bottom: c, right: c, left: none, top: none),
            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(8)),
          ),
        ),
      ),
    ];
  }
}

/// Ghost QR icon: three finder squares + a center dot, white on transparent,
/// mirrors the inline SVG `.qr-ghost` viewBox 0 0 100 100.
class _QrGhostPainter extends CustomPainter {
  _QrGhostPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final s = size.width / 100;
    void square(double x, double y, double w) => canvas.drawRect(Rect.fromLTWH(x * s, y * s, w * s, w * s), paint);
    square(6, 6, 26);
    square(68, 6, 26);
    square(6, 68, 26);
    square(42, 42, 16);
  }

  @override
  bool shouldRepaint(covariant _QrGhostPainter oldDelegate) => oldDelegate.color != color;
}
