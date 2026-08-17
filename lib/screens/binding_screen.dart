import 'package:flutter/material.dart';
import '../models/app_scope.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/buttons.dart';
import '../widgets/screen_chrome.dart';

class BindingScreen extends StatelessWidget {
  const BindingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    void goTo(String route) => Navigator.of(context).pushReplacementNamed(route);

    return Scaffold(
      backgroundColor: AppColors.pageBgOf(context),
      body: Column(
        children: [
          const MosaicBand(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 6, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 26),
                  // .success-ring
                  SizedBox(
                    width: 96,
                    height: 96,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 112,
                          height: 112,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.pitch.withValues(alpha: 0.5), width: 2),
                          ),
                        ),
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.pitchTintOf(context)),
                          child: const Icon(Icons.check, size: 40, color: AppColors.successCheck),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(scope.t('bindTitle'), style: AppTextStyles.hTitle(color: AppColors.voidOf(context)), textAlign: TextAlign.center),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 0),
                    child: Text(scope.t('bindSub'), style: AppTextStyles.hSub.copyWith(color: AppColors.inkSoftOf(context)), textAlign: TextAlign.center),
                  ),

                  // .bind-list
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        _BindItem(title: scope.t('bind1Title'), sub: scope.t('bind1Sub')),
                        _BindItem(title: scope.t('bind2Title'), sub: scope.t('bind2Sub')),
                        _BindItem(title: scope.t('bind3Title'), sub: scope.t('bind3Sub'), showDivider: false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 24, 0),
            child: TealButton(label: scope.t('bindEnterBtn'), onTap: () => goTo(Routes.homeDashboard)),
          ),
          const SkylineBackdrop(),
        ],
      ),
    );
  }
}

class _BindItem extends StatelessWidget {
  const _BindItem({required this.title, required this.sub, this.showDivider = true});
  final String title;
  final String sub;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        border: showDivider ? Border(bottom: BorderSide(color: AppColors.stoneLineOf(context))) : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.pitchTintOf(context)),
            child: const Icon(Icons.check, size: 13, color: AppColors.pitch),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bindTextTitle.copyWith(color: AppColors.voidOf(context))),
                Text(sub, style: AppTextStyles.bindTextSub.copyWith(color: AppColors.inkSoftOf(context))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
