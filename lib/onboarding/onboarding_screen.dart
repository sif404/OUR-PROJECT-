import 'package:flutter/material.dart';
import '../models/app_scope.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'onboarding_icons.dart';
import 'onboarding_illustrations.dart';

class _SlideData {
  const _SlideData({required this.titleKey, required this.subtitleKey, required this.icon, required this.illustration});
  final String titleKey;
  final String subtitleKey;
  final BadgeIconType icon;
  final IllustrationType illustration;
}

const _slides = [
  _SlideData(
    titleKey: 'ob1Title',
    subtitleKey: 'ob1Desc',
    icon: BadgeIconType.discover,
    illustration: IllustrationType.smartCity,
  ),
  _SlideData(
    titleKey: 'ob2Title',
    subtitleKey: 'ob2Desc',
    icon: BadgeIconType.parking,
    illustration: IllustrationType.parking,
  ),
  _SlideData(
    titleKey: 'ob3Title',
    subtitleKey: 'ob3Desc',
    icon: BadgeIconType.safety,
    illustration: IllustrationType.stadium,
  ),
  _SlideData(
    titleKey: 'ob4Title',
    subtitleKey: 'ob4Desc',
    icon: BadgeIconType.getStarted,
    illustration: IllustrationType.getStarted,
  ),
];

/// The 4-slide intro carousel. Fully localized via [AppScope]/ARB keys
/// (`ob1Title`..`ob4Desc`, `obSkip`, `obNext`, `obStart`); direction comes
/// from the app-level [Directionality] wired up in `main.dart`, so this
/// screen no longer forces RTL on its own.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _current = 0;

  bool get _isLast => _current == _slides.length - 1;

  void _next() {
    if (_isLast) {
      Navigator.of(context).pushReplacementNamed(Routes.welcome);
    } else {
      setState(() => _current++);
    }
  }

  void _skip() => setState(() => _current = _slides.length - 1);

  @override
  Widget build(BuildContext context) {
    final slide = _slides[_current];
    final scope = AppScope.of(context);
    final scheme = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
        backgroundColor: scheme.surface,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(-0.4, -1),
              radius: 1.3,
              colors: AppColors.getPaperGradient(isLight),
              stops: const [0.0, 0.55, 1.0],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // .ob-topbar: skip + progress segments
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 22, 24, 0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 44,
                        child: Visibility(
                          visible: !_isLast,
                          maintainState: true,
                          maintainAnimation: true,
                          maintainSize: true,
                          child: GestureDetector(
                            onTap: _skip,
                            child: Text(scope.t('obSkip'), style: AppTextStyles.obSkip.copyWith(color: scheme.primary)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Row(
                          children: List.generate(_slides.length, (i) {
                            final filled = i <= _current;
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(end: i == _slides.length - 1 ? 0 : 6),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: Container(
                                    height: 4,
                                    color: AppColors.inkOf(context).withValues(alpha: 0.15),
                                    child: TweenAnimationBuilder<double>(
                                      tween: Tween(begin: 0, end: filled ? 1.0 : 0.0),
                                      duration: const Duration(milliseconds: 350),
                                      curve: Curves.easeInOut,
                                      builder: (context, value, _) => Align(
                                        alignment: AlignmentDirectional.centerStart,
                                        widthFactor: value,
                                        child: Container(height: 4, color: scheme.primary),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),

                // badge
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 60),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: Container(
                      key: ValueKey('badge-$_current'),
                      width: 148,
                      height: 148,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.cardBgOf(context),
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: scheme.primary.withValues(alpha: 0.14), blurRadius: 30, offset: const Offset(0, 18))],
                        border: Border.all(color: scheme.primary.withValues(alpha: 0.35), width: 1.5),
                      ),
                      child: OnboardingBadgeIcon(type: slide.icon, size: 62),
                    ),
                  ),
                ),

                // title / underline / subtitle
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 30),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: Column(
                      key: ValueKey('text-$_current'),
                      children: [
                        const SizedBox(height: 26),
                        Text(scope.t(slide.titleKey), textAlign: TextAlign.center, style: AppTextStyles.obTitle.copyWith(color: AppColors.inkOf(context))),
                        Container(
                          width: 34,
                          height: 3,
                          margin: const EdgeInsetsDirectional.symmetric(vertical: 10),
                          decoration: BoxDecoration(color: scheme.primary, borderRadius: BorderRadius.circular(2)),
                        ),
                        SizedBox(
                          width: 260,
                          child: Text(scope.t(slide.subtitleKey), textAlign: TextAlign.center, style: AppTextStyles.obSubtitle.copyWith(color: AppColors.mutedOf(context))),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // illustration, pinned above the bottom nav
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: KeyedSubtree(
                    key: ValueKey('illustration-$_current'),
                    child: OnboardingIllustration(type: slide.illustration),
                  ),
                ),

                // bottom nav
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 26),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: _next,
                        child: Text(_isLast ? scope.t('obStart') : scope.t('obNext'), style: AppTextStyles.obNextLabel.copyWith(color: scheme.primary)),
                      ),
                      GestureDetector(
                        onTap: _next,
                        child: Container(
                          width: 54,
                          height: 54,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: scheme.primary,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: scheme.primary.withValues(alpha: 0.35), blurRadius: 20, offset: const Offset(0, 10))],
                          ),
                          child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 20),
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

