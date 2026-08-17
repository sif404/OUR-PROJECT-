import 'package:flutter/material.dart';
import '../models/app_scope.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';

class WelcomeHeader extends StatefulWidget {
  const WelcomeHeader({super.key});

  @override
  State<WelcomeHeader> createState() => _WelcomeHeaderState();
}

class _WelcomeHeaderState extends State<WelcomeHeader> {
  bool _notifOpen = false;

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final isAr = scope.isArabic;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 18,
          right: isAr ? null : 20,
          left: isAr ? 24 : null,
          child: _LangToggle(onTap: scope.toggle, label: scope.t('toggleLabel')),
        ),
        Positioned(
          top: 18,
          left: isAr ? null : 20,
          right: isAr ? 24 : null,
          child: _BellButton(onTap: () => setState(() => _notifOpen = !_notifOpen)),
        ),
        Positioned(
          top: 62,
          left: 20,
          right: 20,
          child: IgnorePointer(
            ignoring: !_notifOpen,
            child: AnimatedOpacity(
              opacity: _notifOpen ? 1 : 0,
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              child: AnimatedSlide(
                offset: _notifOpen ? Offset.zero : const Offset(0, -0.06),
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                child: _NotifPanel(
                  items: [
                    _NotifData(icon: Icons.explore_outlined, title: scope.t('notif1Title'), body: scope.t('notif1Body')),
                    _NotifData(icon: Icons.confirmation_num_outlined, title: scope.t('notif2Title'), body: scope.t('notif2Body')),
                    _NotifData(icon: Icons.person_outline, title: scope.t('notif3Title'), body: scope.t('notif3Body')),
                  ],
                  headText: scope.t('notifHead'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LangToggle extends StatelessWidget {
  const _LangToggle({required this.onTap, required this.label});
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.cardBgOf(context),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: cs.primary, width: 1.4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.language, size: 12, color: cs.primary),
            const SizedBox(width: 6),
            Text(label, style: AppTextStyles.langToggle.copyWith(color: cs.primary)),
          ],
        ),
      ),
    );
  }
}

class _BellButton extends StatelessWidget {
  const _BellButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final cardBg = AppColors.cardBgOf(context);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 36,
        height: 36,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cardBg,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.stoneLineOf(context), width: 1.4),
              ),
              child: Icon(Icons.notifications_outlined, size: 17, color: cs.primary),
            ),
            Positioned(
              top: 2,
              right: 3,
              child: Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: cs.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: cardBg, width: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotifData {
  const _NotifData({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;
}

class _NotifPanel extends StatelessWidget {
  const _NotifPanel({required this.items, required this.headText});
  final List<_NotifData> items;
  final String headText;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;
    final shadow = isLight ? AppDimens.shadowNotifPanel : const <BoxShadow>[];
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBgOf(context),
        border: Border.all(color: AppColors.stoneLineOf(context)),
        borderRadius: BorderRadius.circular(18),
        boxShadow: shadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 16, 10),
            child: Text(
              headText.toUpperCase(),
              style: AppTextStyles.notifPanelHead.copyWith(color: AppColors.inkSoftOf(context)),
            ),
          ),
          for (final item in items)
            Container(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 11),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.stoneLineOf(context))),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.paperOf(context),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Icon(item.icon, size: 15, color: cs.primary),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: AppTextStyles.notifTitle.copyWith(color: AppColors.voidOf(context)),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.body,
                          style: AppTextStyles.notifBody.copyWith(color: AppColors.inkSoftOf(context)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
