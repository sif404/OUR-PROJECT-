import 'package:flutter/material.dart';
import '../models/app_scope.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// AXN Food — quick food experience screen.
///
/// Design intent:
/// - Focuses on the FOOD EXPERIENCE, not a generic location directory.
/// - Uses Jordanian brands as illustrative local partners.
/// - Makes the business-model concept visible through the partner section.
/// - Contains no real offers, prices, ratings, or partnership claims.
class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

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
              SliverToBoxAdapter(
                child: _buildHeader(context),
              ),
              SliverToBoxAdapter(
                child: _buildCategories(context),
              ),
              SliverToBoxAdapter(
                child: _buildMatchdayHero(context),
              ),
              SliverToBoxAdapter(
                child: _buildSectionTitle(context),
              ),
              SliverToBoxAdapter(
                child: _buildBrandRail(context),
              ),
              SliverToBoxAdapter(
                child: _buildBusinessModel(context),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(bottom: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // HEADER
  // ─────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    final t = AppScope.of(context).t;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _backButton(context),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t('food_eyebrow'),
                  style: AppTextStyles.eyebrow,
                ),
                const SizedBox(height: 6),
                Text(
                  t('food_title'),
                  style: AppTextStyles.hTitle(
                    color: AppColors.void_,
                  ).copyWith(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  t('food_subtitle'),
                  style: AppTextStyles.hSub.copyWith(
                    color: AppColors.inkSoft,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _roundIconButton(
            context,
            icon: Icons.tune_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // CATEGORIES
  // ─────────────────────────────────────────────

  Widget _buildCategories(BuildContext context) {
    final t = AppScope.of(context).t;

    final categories = [
      (
        t('food_cat_quickBite'),
        Icons.bolt_rounded,
      ),
      (
        t('food_cat_coffee'),
        Icons.local_cafe_outlined,
      ),
      (
        t('food_cat_jordanian'),
        Icons.restaurant_rounded,
      ),
      (
        t('food_cat_sweets'),
        Icons.cake_outlined,
      ),
    ];

    return SizedBox(
      height: 54,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = categories[index];
          final selected = index == 0;

          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.voidOf(context)
                  : AppColors.cardBgOf(context),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: selected
                    ? AppColors.voidOf(context)
                    : AppColors.stoneLineOf(context),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.$2,
                  size: 16,
                  color: selected
                      ? AppColors.paperOf(context)
                      : AppColors.inkSoftOf(context),
                ),
                const SizedBox(width: 7),
                Text(
                  item.$1,
                  style: AppTextStyles.plexArabic(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selected
                        ? AppColors.paperOf(context)
                        : AppColors.voidOf(context),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────────
  // MATCHDAY HERO
  // ─────────────────────────────────────────────

  Widget _buildMatchdayHero(BuildContext context) {
    final t = AppScope.of(context).t;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 22),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.dome,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.gold.withOpacity(.28),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.domeDeep.withOpacity(.14),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            PositionedDirectional(
              top: -38,
              end: -30,
              child: Container(
                width: 125,
                height: 125,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.gold.withOpacity(.16),
                    width: 18,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _miniBadge(
                      context,
                      icon: Icons.local_fire_department_rounded,
                      color: AppColors.gold,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      t('food_hero_badge'),
                      style: AppTextStyles.mono(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  t('food_hero_title'),
                  style: AppTextStyles.elMessiri(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: AppColors.paper,
                    height: 1.18,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  t('food_hero_desc'),
                  style: AppTextStyles.plexArabic(
                    fontSize: 12.5,
                    color: AppColors.paper.withOpacity(.76),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _heroPill(
                      context,
                      t('food_pill_quick'),
                      Icons.bolt_rounded,
                    ),
                    const SizedBox(width: 7),
                    _heroPill(
                      context,
                      t('food_pill_local'),
                      Icons.auto_awesome_rounded,
                    ),
                    const SizedBox(width: 7),
                    _heroPill(
                      context,
                      t('food_pill_group'),
                      Icons.groups_rounded,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // SECTION TITLE
  // ─────────────────────────────────────────────

  Widget _buildSectionTitle(BuildContext context) {
    final t = AppScope.of(context).t;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t('food_section_eyebrow'),
                  style: AppTextStyles.mono(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.brandRed,
                    letterSpacing: 1.15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  t('food_section_title'),
                  style: AppTextStyles.methodTitle.copyWith(
                    color: AppColors.void_,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Text(
            // We have 4 brands now.
            '04',
            style: AppTextStyles.mono(
              fontSize: 9,
              color: AppColors.inkSoft,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // BRAND RAIL
  // ─────────────────────────────────────────────

  Widget _buildBrandRail(BuildContext context) {
    final t = AppScope.of(context).t;
    final isAr = AppScope.of(context).isArabic;

    final brands = [
      _Brand(
        name: 'BLK',
        arabic: 'بلاك',
        category: t('food_brand_qahwa_category'),
        logoAsset: 'assets/logos/BLK.png',
        accent: AppColors.brandRed,
        tag: t('food_brand_qahwa_tag'),
      ),

      _Brand(
        name: 'Habibah Sweets',
        arabic: 'حلويات حبيبة',
        category: t('food_brand_habibah_category'),
        logoAsset: 'assets/logos/Habiba.png',
        accent: AppColors.gold,
        tag: t('food_brand_habibah_tag'),
      ),

      _Brand(
        name: 'Mansafha',
        arabic: 'منسفها',
        category: t('food_brand_mansafha_category'),
        logoAsset: 'assets/logos/Mansefha.png',
        accent: AppColors.pitch,
        tag: t('food_brand_mansafha_tag'),
      ),

      // NEW BRAND
      _Brand(
        name: 'Taameya',
        arabic: 'طعمية',
        category: isAr ? 'مأكولات' : 'Food',
        logoAsset: 'assets/logos/Tameeya.png',
        accent: AppColors.brandRed,
        tag: isAr ? 'محلي' : 'LOCAL',
      ),
    ];

    return SizedBox(
      height: 218,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: brands.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final brand = brands[index];

          return SizedBox(
            width: 246,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBgOf(context),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.stoneLineOf(context),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _brandLogo(
                        context,
                        brand,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: brand.accent.withOpacity(.10),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          brand.tag,
                          style: AppTextStyles.mono(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: brand.accent,
                            letterSpacing: .7,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Text(
                    isAr ? brand.arabic : brand.name,
                    style: AppTextStyles.stadiumName.copyWith(
                      color: AppColors.void_,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    isAr ? brand.name : brand.arabic,
                    style: AppTextStyles.plexArabic(
                      fontSize: 11,
                      color: AppColors.inkSoft,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    brand.category,
                    style: AppTextStyles.tagline.copyWith(
                      color: AppColors.inkSoft,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(
                        isAr
                            ? Icons.arrow_back_rounded
                            : Icons.arrow_forward_rounded,
                        size: 15,
                        color: brand.accent,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        t('food_explore'),
                        style: AppTextStyles.btnGhost(
                          fontSize: 11.5,
                        ).copyWith(
                          color: brand.accent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────────
  // BRAND LOGO
  // ─────────────────────────────────────────────

  Widget _brandLogo(
    BuildContext context,
    _Brand brand,
  ) {
    return Container(
      width: 48,
      height: 48,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.paperOf(context),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: brand.accent.withOpacity(.18),
        ),
      ),
      child: Image.asset(
        brand.logoAsset,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.restaurant_rounded,
            color: brand.accent,
            size: 22,
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────────
  // BUSINESS MODEL
  // ─────────────────────────────────────────────

  Widget _buildBusinessModel(BuildContext context) {
    final t = AppScope.of(context).t;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: AppColors.stone,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.stoneLineOf(context),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _miniBadge(
              context,
              icon: Icons.handshake_outlined,
              color: AppColors.brandRed,
              background: AppColors.emberTintOf(context),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t('food_bizmodel_label'),
                    style: AppTextStyles.mono(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: AppColors.brandRed,
                      letterSpacing: 1.05,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    t('food_bizmodel_title'),
                    style: AppTextStyles.methodTitle.copyWith(
                      color: AppColors.void_,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    t('food_bizmodel_desc'),
                    style: AppTextStyles.plexArabic(
                      fontSize: 11.5,
                      color: AppColors.inkSoft,
                      height: 1.55,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _modelChip(
                        context,
                        t('food_chip_partnerVisibility'),
                      ),
                      _modelChip(
                        context,
                        t('food_chip_eventDiscovery'),
                      ),
                      _modelChip(
                        context,
                        t('food_chip_futureOffers'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // MODEL CHIP
  // ─────────────────────────────────────────────

  Widget _modelChip(
    BuildContext context,
    String label,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
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

  // ─────────────────────────────────────────────
  // HERO PILL
  // ─────────────────────────────────────────────

  Widget _heroPill(
    BuildContext context,
    String label,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.paper.withOpacity(.09),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.paper.withOpacity(.13),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: AppColors.gold,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: AppTextStyles.mono(
              fontSize: 8,
              fontWeight: FontWeight.w600,
              color: AppColors.paper.withOpacity(.86),
              letterSpacing: .7,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // MINI BADGE
  // ─────────────────────────────────────────────

  Widget _miniBadge(
    BuildContext context, {
    required IconData icon,
    required Color color,
    Color? background,
  }) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: background ?? color.withOpacity(.12),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Icon(
        icon,
        size: 17,
        color: color,
      ),
    );
  }

  // ─────────────────────────────────────────────
  // ROUND BUTTON
  // ─────────────────────────────────────────────

  // ─────────────────────────────────────────────
  // BACK BUTTON
  // ─────────────────────────────────────────────

  Widget _backButton(BuildContext context) {
    return Material(
      color: AppColors.cardBgOf(context),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () {
          Navigator.of(context).maybePop();
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.stoneLineOf(context),
            ),
          ),
          child: Icon(
            AppScope.of(context).isArabic
                ? Icons.arrow_forward_rounded
                : Icons.arrow_back_rounded,
            size: 18,
            color: AppColors.voidOf(context),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // ROUND BUTTON
  // ─────────────────────────────────────────────

  Widget _roundIconButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.cardBgOf(context),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.stoneLineOf(context),
            ),
          ),
          child: Icon(
            icon,
            size: 18,
            color: AppColors.voidOf(context),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// BRAND MODEL
// ─────────────────────────────────────────────

class _Brand {
  const _Brand({
    required this.name,
    required this.arabic,
    required this.category,
    required this.logoAsset,
    required this.accent,
    required this.tag,
  });

  final String name;
  final String arabic;
  final String category;
  final String logoAsset;
  final Color accent;
  final String tag;
}