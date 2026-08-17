import 'package:flutter/material.dart';
import '../models/app_scope.dart';
import '../theme/app_colors.dart';

class BackButton38 extends StatelessWidget {
  const BackButton38({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isAr = AppScope.of(context).isArabic;
    return GestureDetector(
      onTap: onTap,
      child: Transform.flip(
        flipX: isAr,
        child: Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.paperOf(context),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.stoneLineOf(context), width: 1),
          ),
          child: Text('←', style: TextStyle(fontSize: 16, color: AppColors.voidOf(context))),
        ),
      ),
    );
  }
}

class StepDots extends StatelessWidget {
  const StepDots({super.key, required this.total, required this.activeIndex});
  final int total;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final isNow = i == activeIndex;
        final isDone = i < activeIndex;
        return Padding(
          padding: EdgeInsetsDirectional.only(end: i == total - 1 ? 0 : 6),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isNow ? 28 : 20,
            height: 4,
            decoration: BoxDecoration(
              color: (isDone || isNow) ? cs.primary : AppColors.stoneLineOf(context),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );
      }),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.onBack, this.activeStep, this.totalSteps = 5});
  final VoidCallback onBack;
  final int? activeStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24, 56, 24, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackButton38(onTap: onBack),
          if (activeStep != null) StepDots(total: totalSteps, activeIndex: activeStep!),
          const SizedBox(width: 38, height: 38),
        ],
      ),
    );
  }
}

class MosaicBand extends StatelessWidget {
  const MosaicBand({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      height: 8,
      width: double.infinity,
      child: CustomPaint(painter: _MosaicPainter(backgroundColor: cs.surface)),
    );
  }
}

class _MosaicPainter extends CustomPainter {
  final Color backgroundColor;
  _MosaicPainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = backgroundColor);
    final emberPaint = Paint()
      ..color = AppColors.ember.withValues(alpha: 0.9)
      ..strokeWidth = 2.4;
    final goldPaint = Paint()
      ..color = AppColors.gold.withValues(alpha: 0.9)
      ..strokeWidth = 1.6;
    const period = 9.0;
    for (double x = -size.height; x < size.width + size.height; x += period) {
      canvas.drawLine(Offset(x, size.height), Offset(x + size.height, 0), emberPaint);
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), goldPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _MosaicPainter oldDelegate) =>
      oldDelegate.backgroundColor != backgroundColor;
}

class SkylineBackdrop extends StatelessWidget {
  const SkylineBackdrop({super.key});

  static const double _aspect = 1170 / 209;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AspectRatio(
        aspectRatio: _aspect,
        child: Image.asset(
          'assets/images/city_skyline.png',
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}

class ScreenWithSkyline extends StatelessWidget {
  const ScreenWithSkyline({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.pageBgOf(context),
      child: Column(
        children: [
          Expanded(child: child),
          const SkylineBackdrop(),
        ],
      ),
    );
  }
}

class StandardScreenScaffold extends StatelessWidget {
  const StandardScreenScaffold({
    super.key,
    required this.onBack,
    this.activeStep,
    this.totalSteps = 5,
    required this.bodyChildren,
    this.bottomChildren = const [],
    this.bodyCrossAxisAlignment = CrossAxisAlignment.start,
    this.bodyPaddingTop = 6,
    this.showTopBar = true,
  });

  final VoidCallback onBack;
  final int? activeStep;
  final int totalSteps;
  final List<Widget> bodyChildren;
  final List<Widget> bottomChildren;
  final CrossAxisAlignment bodyCrossAxisAlignment;
  final double bodyPaddingTop;
  final bool showTopBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBgOf(context),
      body: Column(
        children: [
          if (showTopBar) TopBar(onBack: onBack, activeStep: activeStep, totalSteps: totalSteps),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsetsDirectional.fromSTEB(24, bodyPaddingTop, 24, 24),
              child: Column(
                crossAxisAlignment: bodyCrossAxisAlignment,
                children: bodyChildren,
              ),
            ),
          ),
          if (bottomChildren.isNotEmpty)
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 24, 0),
              child: Column(children: bottomChildren),
            ),
          const SkylineBackdrop(),
        ],
      ),
    );
  }
}
