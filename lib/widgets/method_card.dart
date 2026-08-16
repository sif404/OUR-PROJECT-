import 'package:flutter/material.dart';
import '../models/app_scope.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';

/// .method-card — selectable row with icon tile, title/desc, and a radio
/// dot pinned to the trailing edge (mirrors in RTL since it's
/// `right:16px` in LTR CSS -> becomes the trailing edge either way here).
class MethodCard extends StatelessWidget {
  const MethodCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  final String icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isAr = AppScope.of(context).isArabic;
    // CSS: padding:18px with padding-start overridden to 44px (content indent).
    // EdgeInsetsDirectional mirrors automatically: start=44, end=18 in both LTR/RTL.
    // radio-dot absolute at top:18 right:16 (top-trailing corner). In RTL the
    // whole card mirrors: extra indent moves to the right, dot moves to left.
    const contentPadding = EdgeInsetsDirectional.fromSTEB(44, 18, 18, 18);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsetsDirectional.only(bottom: 14),
        decoration: BoxDecoration(
          color: selected ? AppColors.emberTintOf(context) : Colors.transparent,
          border: Border.all(color: selected ? cs.primary : AppColors.stoneLineOf(context), width: 1.6),
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        ),
        child: Stack(
          children: [
            Padding(
              padding: contentPadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected ? cs.primary : AppColors.iconBadgeBgOf(context),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(icon, style: const TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTextStyles.methodTitle),
                        const SizedBox(height: 3),
                        Text(description, style: AppTextStyles.methodDesc),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 18,
              right: isAr ? null : 16,
              left: isAr ? 16 : null,
              child: Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: selected ? cs.primary : AppColors.stoneLineOf(context), width: 2),
                ),
                child: selected
                    ? Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: cs.primary),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
