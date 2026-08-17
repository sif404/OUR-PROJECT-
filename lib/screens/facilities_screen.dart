import 'package:flutter/material.dart';
import '../models/app_scope.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// AXN Facilities — quick experience screen.
///
/// Design intent:
/// - Focuses on ACCESS, CARE, and COMFORT rather than a location directory.
/// - Covers prayer spaces and health/support facilities.
/// - Keeps location as supporting information, not the main concept.
/// - Does not claim specific real-time availability or exact facility locations.
class FacilitiesScreen extends StatelessWidget {
  const FacilitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isAr = AppScope.of(context).isArabic;

    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.bg(context),
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              SliverToBoxAdapter(child: _buildQuickAccess(context)),
              SliverToBoxAdapter(child: _buildCareCard(context)),
              SliverToBoxAdapter(child: _buildSectionTitle(context)),
              SliverToBoxAdapter(child: _buildFacilityCards(context)),
              SliverToBoxAdapter(child: _buildExperienceNote(context)),
              const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final t = AppScope.of(context).t;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t('facilities_eyebrow'),
            style: AppTextStyles.eyebrow,
          ),
          const SizedBox(height: 6),
          Text(
            t('facilities_title'),
            style: AppTextStyles.hTitle(
              color: AppColors.void_,
            ).copyWith(fontSize: 24, height: 1.22),
          ),
          const SizedBox(height: 6),
          Text(
            t('facilities_subtitle'),
            style: AppTextStyles.hSub.copyWith(
              color: AppColors.inkSoft,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccess(BuildContext context) {
    final t = AppScope.of(context).t;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
      child: Row(
        children: [
          Expanded(
            child: _quickCard(
              context,
              icon: Icons.mosque_outlined,
              title: t('facilities_quick_prayer_title'),
              subtitle: t('facilities_quick_prayer_subtitle'),
              color: AppColors.gold,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _quickCard(
              context,
              icon: Icons.health_and_safety_outlined,
              title: t('facilities_quick_health_title'),
              subtitle: t('facilities_quick_health_subtitle'),
              color: AppColors.pitch,
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBgOf(context),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.stoneLineOf(context),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _iconBadge(context, icon: icon, color: color),
          const SizedBox(height: 14),
          Text(
            title,
            style: AppTextStyles.methodTitle.copyWith(
              color: AppColors.void_,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: AppTextStyles.plexArabic(
              fontSize: 10.5,
              color: AppColors.inkSoft,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareCard(BuildContext context) {
    final t = AppScope.of(context).t;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.dome,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.pitch.withOpacity(.24),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.domeDeep.withOpacity(.13),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            PositionedDirectional(
              end: -34,
              bottom: -54,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.pitch.withOpacity(.13),
                    width: 20,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _iconBadge(
                      context,
                      icon: Icons.favorite_outline_rounded,
                      color: AppColors.pitch,
                      background: AppColors.pitchTint,
                    ),
                    const SizedBox(width: 9),
                    Text(
                      t('facilities_care_label'),
                      style: AppTextStyles.mono(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.pitch,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  t('facilities_care_title'),
                  style: AppTextStyles.elMessiri(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.paper,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  t('facilities_care_desc'),
                  style: AppTextStyles.plexArabic(
                    fontSize: 12.5,
                    color: AppColors.paper.withOpacity(.76),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    final t = AppScope.of(context).t;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t('facilities_section_label'),
            style: AppTextStyles.mono(
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              color: AppColors.brandRed,
              letterSpacing: 1.15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            t('facilities_section_title'),
            style: AppTextStyles.methodTitle.copyWith(
              color: AppColors.void_,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityCards(BuildContext context) {
    final t = AppScope.of(context).t;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _facilityCard(
            context,
            icon: Icons.mosque_outlined,
            color: AppColors.gold,
            label: t('facilities_prayer_label'),
            title: t('facilities_prayer_title'),
            body: t('facilities_prayer_body'),
            chips: [
              t('facilities_prayer_chip1'),
              t('facilities_prayer_chip2'),
            ],
          ),
          const SizedBox(height: 10),
          _facilityCard(
            context,
            icon: Icons.medical_services_outlined,
            color: AppColors.pitch,
            label: t('facilities_health_label'),
            title: t('facilities_health_title'),
            body: t('facilities_health_body'),
            chips: [
              t('facilities_health_chip1'),
              t('facilities_health_chip2'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _facilityCard(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String label,
    required String title,
    required String body,
    required List<String> chips,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBgOf(context),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.stoneLineOf(context),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _iconBadge(context, icon: icon, color: color),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.mono(
                    fontSize: 8.5,
                    fontWeight: FontWeight.w600,
                    color: color,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: AppTextStyles.methodTitle.copyWith(
                    color: AppColors.void_,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  body,
                  style: AppTextStyles.plexArabic(
                    fontSize: 11,
                    color: AppColors.inkSoft,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: chips
                      .map((chip) => _chip(context, chip))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceNote(BuildContext context) {
    final t = AppScope.of(context).t;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.stone,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.stoneLineOf(context),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.auto_awesome_outlined,
              size: 18,
              color: AppColors.brandRed,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                t('facilities_note'),
                style: AppTextStyles.plexArabic(
                  fontSize: 11.5,
                  color: AppColors.inkSoft,
                  height: 1.55,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.paperOf(context),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.stoneLineOf(context),
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.mono(
          fontSize: 8.5,
          color: AppColors.inkSoft,
        ),
      ),
    );
  }

  Widget _iconBadge(
    BuildContext context, {
    required IconData icon,
    required Color color,
    Color? background,
  }) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: background ?? color.withOpacity(.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        size: 19,
        color: color,
      ),
    );
  }
}