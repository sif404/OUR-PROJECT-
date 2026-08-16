import 'dart:async';
import 'package:flutter/material.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// SPLASH — logo, "AXN" wordmark (red N), tagline, pulsing dot trio.
/// Auto-advances to onboarding after 2.2s (matches `setTimeout(goToOnboarding,
/// 2200)`); tapping anywhere skips the wait, same as the HTML's click
/// listener on `#splash`.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  bool _advancing = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2200), _advance);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _advance() {
    if (_advancing) return;
    _advancing = true;
    _timer?.cancel();
    Navigator.of(context).pushReplacementNamed(Routes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: _advance,
      child: Scaffold(
        backgroundColor: cs.surface,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(-0.4, -1),
              radius: 1.3,
              colors: AppColors.getPaperGradient(isLight),
              stops: const [0.0, 0.55, 1.0],
            ),
          ),
          // Logo pinned to the top (centered horizontally), wordmark image +
          // dots pinned to the bottom.
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 210,
                    child: Image.asset('assets/images/axn_logo.png', fit: BoxFit.contain),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // NEW: wordmark + tagline now comes from the designed
                      // image (axn_wordmark.png) instead of RichText/Text,
                      // so it matches the AXN/AMRA EXCHANGE NEXUS/Arabic
                      // tagline lockup exactly.
                      SizedBox(
                        width: 160,
                        child: Image.asset('assets/images/axn_wordmark.png', fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 32),
                      const _PulsingDots(),
                    ],
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

/// .splash-dots — 3 dots, `dotPulse` 1.1s ease-in-out infinite, staggered
/// by 0.15s / 0.3s.
class _PulsingDots extends StatefulWidget {
  const _PulsingDots();

  @override
  State<_PulsingDots> createState() => _PulsingDotsState();
}

class _PulsingDotsState extends State<_PulsingDots> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  double _scaleFor(double t) {
    // 0%,80%,100% -> 1.0 ; 40% -> 1.5
    if (t < 0.4) return 1 + (0.5) * (t / 0.4);
    if (t < 0.8) return 1.5 - 0.5 * ((t - 0.4) / 0.4);
    return 1.0;
  }

  Color _colorFor(double t) {
    final scale = _scaleFor(t);
    final factor = ((scale - 1) / 0.5).clamp(0.0, 1.0);
    final cs = Theme.of(context).colorScheme;
    return Color.lerp(cs.primary.withValues(alpha: 0.3), cs.primary, factor)!;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final delay = i * 0.15 / 1.1; // 0.15s stagger over 1.1s cycle
            final t = (_ctrl.value - delay) % 1.0;
            final effT = t < 0 ? t + 1 : t;
            return Padding(
              padding: EdgeInsetsDirectional.only(start: i == 0 ? 0 : 7),
              child: Transform.scale(
                scale: _scaleFor(effT),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: _colorFor(effT)),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}