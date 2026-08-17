import 'package:flutter/material.dart';

import '../models/app_scope.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'smart_exit_screen.dart';

enum RouteCategory { gate, car, cooling, firstaid, food }

class ActiveRouteScreen extends StatefulWidget {
  const ActiveRouteScreen({super.key});

  @override
  State<ActiveRouteScreen> createState() => _ActiveRouteScreenState();
}

class _ActiveRouteScreenState extends State<ActiveRouteScreen>
    with SingleTickerProviderStateMixin {
  RouteCategory _selectedCategory = RouteCategory.gate;
  late AnimationController _pulseController;

  String _routePreference = 'avoidCrowds';
  bool _showAlternativeRoute = false;
  bool _isRecalculating = false;
  double _progress = 0.62;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  RouteType _mapRouteType(RouteCategory category) {
    switch (category) {
      case RouteCategory.car:
        return RouteType.car;
      case RouteCategory.cooling:
        return RouteType.cooling;
      case RouteCategory.firstaid:
        return RouteType.firstaid;
      case RouteCategory.food:
        return RouteType.food;
      case RouteCategory.gate:
        return RouteType.gate;
    }
  }

  String _preferenceLabel(bool isAr) {
    switch (_routePreference) {
      case 'fastest':
        return isAr ? 'الأسرع' : 'Fastest';
      case 'lessWalking':
        return isAr ? 'أقل مشيًا' : 'Less walking';
      case 'accessible':
        return isAr ? 'مسار ميسّر' : 'Accessible';
      case 'avoidCrowds':
      default:
        return isAr ? 'تجنب الازدحام' : 'Avoid crowds';
    }
  }

  void _recalculateRoute(bool isAr) {
    setState(() => _isRecalculating = true);

    Future.delayed(const Duration(milliseconds: 850), () {
      if (!mounted) return;
      setState(() {
        _isRecalculating = false;
        _showAlternativeRoute = true;
        _progress = 0.68;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isAr
                ? 'تم تحديث المسار وتجنب منطقة الازدحام.'
                : 'Route updated to avoid the crowded area.',
          ),
        ),
      );
    });
  }

  void _openRoutePreferences(BuildContext context, bool isAr) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final isLight = Theme.of(sheetContext).brightness != Brightness.dark;
        final surfaceColor = AppColors.paperOf(sheetContext);
        final textPrimary = AppColors.voidOf(sheetContext);
        final textSecondary = AppColors.inkSoft;
        final borderColor = AppColors.stoneLineOf(sheetContext);

        final options = [
          (
            id: 'fastest',
            icon: Icons.bolt_rounded,
            title: isAr ? 'الأسرع' : 'Fastest',
            desc: isAr ? 'أقصر وقت للوصول' : 'Minimize arrival time',
          ),
          (
            id: 'lessWalking',
            icon: Icons.directions_walk_rounded,
            title: isAr ? 'أقل مشيًا' : 'Less walking',
            desc: isAr ? 'تقليل مسافة المشي' : 'Reduce walking distance',
          ),
          (
            id: 'avoidCrowds',
            icon: Icons.groups_rounded,
            title: isAr ? 'تجنب الازدحام' : 'Avoid crowds',
            desc: isAr ? 'تفضيل المسارات الأقل ازدحامًا' : 'Prefer lower-crowd paths',
          ),
          (
            id: 'accessible',
            icon: Icons.accessible_rounded,
            title: isAr ? 'مسار ميسّر' : 'Accessible',
            desc: isAr ? 'تفضيل المسارات الميسّرة' : 'Prefer accessible paths',
          ),
        ];

        return SafeArea(
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAr ? 'تفضيلات المسار' : 'Route preferences',
                  style: AppTextStyles.elMessiri(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isAr
                      ? 'سيستخدم AXN هذا التفضيل لتحسين المسار المقترح.'
                      : 'AXN will use this preference to optimize the recommended route.',
                  style: AppTextStyles.plexArabic(
                    fontSize: 11,
                    color: textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                ...options.map(
                  (option) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        setState(() => _routePreference = option.id);
                        Navigator.pop(sheetContext);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _routePreference == option.id
                              ? AppColors.emberTint
                              : AppColors.cardBgOf(sheetContext),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: _routePreference == option.id
                                ? AppColors.ember.withValues(alpha: 0.35)
                                : borderColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              option.icon,
                              size: 20,
                              color: _routePreference == option.id
                                  ? AppColors.ember
                                  : textSecondary,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    option.title,
                                    style: AppTextStyles.elMessiri(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    option.desc,
                                    style: AppTextStyles.plexArabic(
                                      fontSize: 9.5,
                                      color: textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_routePreference == option.id)
                              const Icon(
                                Icons.check_circle_rounded,
                                size: 18,
                                color: AppColors.pitch,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final isAr = scope.isArabic;
    final isLight = Theme.of(context).brightness != Brightness.dark;

    final bgColor = AppColors.bg(context);
    final surfaceColor = AppColors.surf(context);
    final textPrimary = AppColors.textP(context);
    final textSecondary = AppColors.textS(context);
    final borderColor = AppColors.stoneLineOf(context);
    final accentPrimary = AppColors.ember;
    final cardColor = AppColors.cardBgOf(context);
    final paperColor = AppColors.paperOf(context);

    final routeInfo = _getRouteInfo(_selectedCategory, isAr);
    final steps = _getSteps(_selectedCategory, isAr);

    final crowd = _selectedCategory == RouteCategory.gate
        ? (isAr ? 'متوسط' : 'Moderate')
        : (_selectedCategory == RouteCategory.car
            ? (isAr ? 'منخفض' : 'Low')
            : (isAr ? 'منخفض' : 'Low'));

    final crowdColor = crowd == (isAr ? 'منخفض' : 'Low')
        ? const Color(0xFF10B981)
        : const Color(0xFFF59E0B);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Directionality(
          textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                // Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isAr ? 'MOBILITY / تنقّل' : 'MOBILITY / NAVIGATION',
                            style: AppTextStyles.eyebrow,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            isAr
                                ? 'تفاصيل المسار الذكي'
                                : 'AI Route Details',
                            style: AppTextStyles.hTitle(
                              color: AppColors.void_,
                            ).copyWith(
                              fontSize: 24,
                              height: 1.18,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            isAr
                                ? 'إرشاد خطوة بخطوة للخروج من الملعب.'
                                : 'Step-by-step guidance for your exit.',
                            style: AppTextStyles.hSub.copyWith(
                              color: AppColors.inkSoft,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildRoundIconButton(
                      context,
                      icon: isAr
                          ? Icons.arrow_forward_rounded
                          : Icons.arrow_back_rounded,
                      onTap: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).maybePop();
                        } else {
                          Navigator.of(context).pushNamed(Routes.smartExit);
                        }
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Destination categories
                SizedBox(
                  height: 38,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCategoryChip(
                        RouteCategory.gate,
                        isAr ? "بوابة B3" : "Gate B3",
                        Icons.sensor_door_rounded,
                        accentPrimary,
                        context,
                      ),
                      _buildCategoryChip(
                        RouteCategory.car,
                        isAr ? "المواقف B" : "Parking B",
                        Icons.directions_car_rounded,
                        accentPrimary,
                        context,
                      ),
                      _buildCategoryChip(
                        RouteCategory.cooling,
                        isAr ? "واحة التبريد" : "Cooling Oasis",
                        Icons.ac_unit_rounded,
                        accentPrimary,
                        context,
                      ),
                      _buildCategoryChip(
                        RouteCategory.firstaid,
                        isAr ? "العيادة الطبية" : "Medical Zone",
                        Icons.medical_services_rounded,
                        accentPrimary,
                        context,
                      ),
                      _buildCategoryChip(
                        RouteCategory.food,
                        isAr ? "ساحة الطعام" : "Food Court",
                        Icons.restaurant_rounded,
                        accentPrimary,
                        context,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Route map preview
                SizedBox(
                  height: 190,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isLight
                            ? AppColors.stone
                            : AppColors.surf(context),
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, _) {
                                return CustomPaint(
                                  painter: TargetStadiumPainter(
                                    isLight: isLight,
                                    activeRoute:
                                        _mapRouteType(_selectedCategory),
                                    pulseValue: _pulseController.value,
                                    dashPhase: _pulseController.value,
                                  ),
                                );
                              },
                            ),
                          ),
                          PositionedDirectional(
                            top: 10,
                            start: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: cardColor.withValues(alpha: 0.96),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: borderColor),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.explore_rounded,
                                    size: 13,
                                    color: Color(0xFF10B981),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    isAr ? 'المسار الحالي' : 'CURRENT ROUTE',
                                    style: AppTextStyles.mono(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900,
                                      color: textPrimary,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          PositionedDirectional(
                            bottom: 10,
                            end: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: cardColor.withValues(alpha: 0.96),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: borderColor),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.groups_rounded,
                                    size: 13,
                                    color: crowdColor,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${isAr ? "الازدحام" : "CROWD"} · $crowd',
                                    style: AppTextStyles.mono(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900,
                                      color: textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // AI recommendation
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.dome,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.28),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 18,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.pitch.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Icon(
                          Icons.auto_awesome_rounded,
                          color: AppColors.pitch,
                          size: 17,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isAr
                                  ? 'اقتراح AI لهذا المسار'
                                  : 'AI ROUTE RECOMMENDATION',
                              style: AppTextStyles.mono(
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                                color: AppColors.gold,
                                letterSpacing: 0.7,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              _showAlternativeRoute
                                  ? (isAr
                                      ? 'تم اختيار مسار بديل لتجنب منطقة الازدحام.'
                                      : 'Alternative route selected to avoid the crowded area.')
                                  : (isAr
                                      ? 'المسار الحالي يوازن بين الوقت والازدحام.'
                                      : 'Current route balances arrival time and crowd level.'),
                              style: AppTextStyles.plexArabic(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // ETA / distance / progress
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: borderColor),
                    boxShadow: isLight
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildStepStat(
                              Icons.timer_rounded,
                              isAr ? "الوقت المتبقي" : "TIME LEFT",
                              routeInfo.eta,
                              textPrimary,
                              textSecondary,
                            ),
                          ),
                          Container(width: 1, height: 28, color: borderColor),
                          Expanded(
                            child: _buildStepStat(
                              Icons.place_rounded,
                              isAr ? "المسافة" : "DISTANCE",
                              routeInfo.dist,
                              textPrimary,
                              textSecondary,
                            ),
                          ),
                          Container(width: 1, height: 28, color: borderColor),
                          Expanded(
                            child: _buildStepStat(
                              Icons.groups_rounded,
                              isAr ? "الازدحام" : "CROWD",
                              crowd,
                              textPrimary,
                              textSecondary,
                              valueColor: crowdColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            isAr ? 'التقدم' : 'PROGRESS',
                            style: AppTextStyles.mono(
                              fontSize: 8,
                              fontWeight: FontWeight.w800,
                              color: textSecondary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${(_progress * 100).round()}%',
                            style: AppTextStyles.mono(
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              color: accentPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: _progress,
                          minHeight: 7,
                          backgroundColor:
                              borderColor.withValues(alpha: 0.35),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(accentPrimary),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Predictive alert
                if (_selectedCategory == RouteCategory.gate)
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: AppColors.goldSoft,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.gold.withValues(alpha: 0.38),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          size: 18,
                          color: Color(0xFFF59E0B),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            isAr
                                ? 'تنبيه تنبؤي: الازدحام يتزايد أمام نقطة التفتيش B2.'
                                : 'Predictive alert: crowd is building near Gate B2 security.',
                            style: AppTextStyles.plexArabic(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _recalculateRoute(isAr),
                          child: Text(
                            isAr ? 'بديل' : 'ALTERNATIVE',
                            style: AppTextStyles.mono(
                              fontSize: 8,
                              fontWeight: FontWeight.w900,
                              color: AppColors.gold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 10),

                // Smart waypoints
                SizedBox(
                  height: 34,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildWaypointChip(
                        isAr ? 'طعام' : 'Food',
                        Icons.restaurant_rounded,
                        const Color(0xFFF59E0B),
                        textPrimary,
                        borderColor,
                        paperColor,
                      ),
                      _buildWaypointChip(
                        isAr ? 'مرافق' : 'Facilities',
                        Icons.apartment_rounded,
                        accentPrimary,
                        textPrimary,
                        borderColor,
                        paperColor,
                      ),
                      _buildWaypointChip(
                        isAr ? 'صلاة' : 'Prayer',
                        Icons.mosque_rounded,
                        const Color(0xFF8B5CF6),
                        textPrimary,
                        borderColor,
                        paperColor,
                      ),
                      _buildWaypointChip(
                        isAr ? 'إسعاف' : 'First Aid',
                        Icons.medical_services_rounded,
                        const Color(0xFFEF4444),
                        textPrimary,
                        borderColor,
                        paperColor,
                      ),
                      _buildWaypointChip(
                        isAr ? 'تبريد' : 'Cooling',
                        Icons.ac_unit_rounded,
                        const Color(0xFF14E0C4),
                        textPrimary,
                        borderColor,
                        paperColor,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  isAr ? "خطوات المغادرة التتابعية" : "STEP-BY-STEP EGRESS TIMELINE",
                  style: AppTextStyles.mono(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: AppColors.ember,
                    letterSpacing: 1.15,
                  ),
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: ListView.builder(
                    itemCount: steps.length,
                    itemBuilder: (context, index) {
                      final step = steps[index];
                      return _buildTimelineStep(
                        step: step,
                        isLast: index == steps.length - 1,
                        textPrimary: textPrimary,
                        textSecondary: textSecondary,
                        surfaceColor: surfaceColor,
                        borderColor: borderColor,
                        accentPrimary: accentPrimary,
                        context: context,
                        isAr: isAr,
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton.icon(
                          onPressed: _isRecalculating
                              ? null
                              : () => _recalculateRoute(isAr),
                          icon: _isRecalculating
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(
                                  Icons.refresh_rounded,
                                  size: 18,
                                ),
                          label: Text(
                            _isRecalculating
                                ? (isAr
                                    ? 'جاري تحديث المسار...'
                                    : 'UPDATING ROUTE...')
                                : (isAr
                                    ? 'إعادة حساب المسار'
                                    : 'RECALCULATE ROUTE'),
                            style: AppTextStyles.mono(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.7,
                              color: textPrimary,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.void_,
                            foregroundColor: AppColors.white,
                            disabledBackgroundColor: AppColors.void_,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: AppColors.void_,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${isAr ? "التفضيل" : "Preference"}: ${_preferenceLabel(isAr)}',
                              style: AppTextStyles.mono(
                                fontSize: 8.5,
                                fontWeight: FontWeight.w800,
                                color: AppColors.inkSoft,
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () =>
                                _openRoutePreferences(context, isAr),
                            icon: const Icon(
                              Icons.tune_rounded,
                              size: 14,
                            ),
                            label: Text(
                              isAr ? 'تفضيلات المسار' : 'Route preferences',
                              style: AppTextStyles.mono(
                                fontSize: 8.5,
                                fontWeight: FontWeight.w800,
                                color: AppColors.ember,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.smartExit);
                          },
                          icon: const Icon(
                            Icons.near_me_rounded,
                            size: 17,
                          ),
                          label: Text(
                            isAr
                                ? "العودة إلى الخريطة التفاعلية"
                                : "RETURN TO MAP",
                            style: AppTextStyles.mono(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.7,
                              color: textPrimary,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.void_,
                            side: BorderSide(color: borderColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoundIconButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.cardBgOf(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: AppColors.stoneLineOf(context)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(
            icon,
            size: 19,
            color: AppColors.voidOf(context),
          ),
        ),
      ),
    );
  }

  Widget _buildWaypointChip(
    String label,
    IconData icon,
    Color color,
    Color textPrimary,
    Color borderColor,
    Color paperColor,
  ) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 7),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.paperOf(context),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 5),
            Text(
              label,
              style: AppTextStyles.plexArabic(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(
    RouteCategory category,
    String label,
    IconData icon,
    Color accentPrimary,
    BuildContext context,
  ) {
    final isSelected = _selectedCategory == category;
    final borderColor = AppColors.border(context);

    final chipBg = isSelected ? AppColors.voidOf(context) : AppColors.cardBgOf(context);
    final chipText = isSelected ? AppColors.white : AppColors.voidOf(context);
    final chipIcon = isSelected ? AppColors.white : accentPrimary;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCategory = category;
            _showAlternativeRoute = false;
            _progress = 0.62;
          });
        },
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: chipBg,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isSelected ? AppColors.voidOf(context) : borderColor,
              width: 1.2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: accentPrimary.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: chipIcon),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.elMessiri(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: chipText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepStat(
    IconData icon,
    String title,
    String value,
    Color textPrimary,
    Color textSecondary, {
    Color? valueColor,
  }) {
    return Column(
      children: [
        Icon(icon, color: textSecondary, size: 15),
        const SizedBox(height: 4),
        Text(
          title,
          style: AppTextStyles.mono(
            fontSize: 8,
            color: textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.elMessiri(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: valueColor ?? textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineStep({
    required _EgressStep step,
    required bool isLast,
    required Color textPrimary,
    required Color textSecondary,
    required Color surfaceColor,
    required Color borderColor,
    required Color accentPrimary,
    required BuildContext context,
    required bool isAr,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: step.isCompleted
                        ? AppColors.pitch
                        : step.isOasis
                            ? AppColors.gold
                            : AppColors.ember,
                    border: Border.all(
                      color: AppColors.bg(context),
                      width: 2.5,
                    ),
                    boxShadow: step.isOasis
                        ? [
                            BoxShadow(
                              color: accentPrimary.withValues(alpha: 0.6),
                              blurRadius: 6,
                            )
                          ]
                        : [],
                  ),
                  child: step.isCompleted
                      ? const Icon(
                          Icons.check,
                          size: 8,
                          color: Colors.white,
                        )
                      : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: borderColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          step.title,
                          style: AppTextStyles.elMessiri(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: step.isCompleted
                                ? textSecondary
                                : textPrimary,
                          ).copyWith(
                            decoration: step.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                      Text(
                        step.time,
                        style: AppTextStyles.elMessiri(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step.desc,
                    style: AppTextStyles.plexArabic(
                      fontSize: 11,
                      color: textSecondary,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (step.isOasis && step.oasisName != null) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.pitchTint,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.pitch.withValues(alpha: 0.28),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.pitchTint,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.ac_unit_rounded,
                              color: AppColors.pitch,
                              size: 14,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isAr
                                      ? "منطقة واحة مكيفة"
                                      : "Air-Cooled Rest Oasis",
                                  style: AppTextStyles.mono(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.pitch,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  step.oasisName!,
                                  style: AppTextStyles.elMessiri(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: textPrimary,
                                  ),
                                ),
                                if (step.oasisTemp != null) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    step.oasisTemp!,
                                    style: AppTextStyles.elMessiri(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF10B981),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.directions_walk_rounded,
                        size: 11,
                        color: textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "+ ${step.distance}",
                        style: AppTextStyles.elMessiri(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _RouteInfo _getRouteInfo(RouteCategory category, bool isAr) {
    switch (category) {
      case RouteCategory.car:
        return _RouteInfo(
          eta: isAr ? "٣ دقائق" : "3 min",
          dist: isAr ? "٢٤٠ م" : "240 m",
          flow: isAr ? "سريع جداً" : "Fast Pace",
        );
      case RouteCategory.cooling:
        return _RouteInfo(
          eta: isAr ? "دقيقة واحدة" : "1 min",
          dist: isAr ? "٨٠ م" : "80 m",
          flow: isAr ? "مكيف مريح" : "Air-Cooled",
        );
      case RouteCategory.firstaid:
        return _RouteInfo(
          eta: isAr ? "دقيقتان" : "2 min",
          dist: isAr ? "١٥٠ م" : "150 m",
          flow: isAr ? "مسار أولوية" : "Priority",
        );
      case RouteCategory.food:
        return _RouteInfo(
          eta: isAr ? "٤ دقائق" : "4 min",
          dist: isAr ? "٣١٠ م" : "310 m",
          flow: isAr ? "تدفق معتدل" : "Moderate",
        );
      case RouteCategory.gate:
      default:
        return _RouteInfo(
          eta: isAr ? "٨ دقائق" : "8 min",
          dist: isAr ? "١٫٢ كم" : "1.2 km",
          flow: isAr ? "سرعة معتادة" : "Normal Pace",
        );
    }
  }

  List<_EgressStep> _getSteps(RouteCategory category, bool isAr) {
    if (isAr) {
      switch (category) {
        case RouteCategory.car:
          return [
            _EgressStep(
              time: "١٤:١٥",
              title: "مغادرة مدرج القطاع ٤",
              desc: "توجه عبر الممر الجانبي الموصل لمواقف السيارات.",
              distance: "٤٠ م",
              isCompleted: true,
            ),
            _EgressStep(
              time: "١٤:١٧",
              title: "نزول المنحدر إلى المستوى P2",
              desc: "استخدم المصعد الكهربائي للوصول للمنطقة ب.",
              distance: "٩٠ م",
            ),
            _EgressStep(
              time: "١٤:١٨",
              title: "الوصول للمركبة رقم AXN-789",
              desc: "تم العثور على المركبة. خروج سلس باتجاه المخرج B.",
              distance: "١١٠ م",
            ),
          ];
        case RouteCategory.cooling:
          return [
            _EgressStep(
              time: "١٤:١٥",
              title: "الانعطاف يساراً عند الممر ٣",
              desc: "مسار مظلل ومزود برذاذ الماء العليل.",
              distance: "٣٠ م",
              isCompleted: true,
            ),
            _EgressStep(
              time: "١٤:١٦",
              title: "دخول صالة واحة التبريد",
              desc: "توقف للراحة والاستراحة في بيئة مبردة بالكامل.",
              distance: "٥٠ م",
              isOasis: true,
              oasisName: "واحة التبريد ٢ (صالة الكرك المبردة)",
              oasisTemp: "نسيم ٢٣°م نشط",
            ),
          ];
        case RouteCategory.firstaid:
          return [
            _EgressStep(
              time: "١٤:١٥",
              title: "مصعد الممر الشمالي",
              desc: "مسار طوارئ مخصص خالٍ من العوائق.",
              distance: "٦٠ م",
              isCompleted: true,
            ),
            _EgressStep(
              time: "١٤:١٧",
              title: "الوصول لمركز الرعاية العاجلة",
              desc: "فريق مسعفين متواجد على مدار الساعة.",
              distance: "٩٠ م",
            ),
          ];
        case RouteCategory.food:
          return [
            _EgressStep(
              time: "١٤:١٥",
              title: "ساحة البلازا الشرقية",
              desc: "التوجه نحو سوق البازار والمطاعم.",
              distance: "١٥٠ م",
              isCompleted: true,
            ),
            _EgressStep(
              time: "١٤:١٩",
              title: "مطاعم البازار والمشروبات",
              desc: "منافذ تقديم سريعة وخيارات متعددة.",
              distance: "١٦٠ م",
            ),
          ];
        case RouteCategory.gate:
        default:
          return [
            _EgressStep(
              time: "١٤:١٥",
              title: "مغادرة الصف ١٢، منطقة ب",
              desc: "توجه عبر الممر العلوي باتجاه الدرج ٤.",
              distance: "٥٠ م",
              isCompleted: true,
            ),
            _EgressStep(
              time: "١٤:١٧",
              title: "المرور عبر ممر النسيم ٢",
              desc: "توقف عند واحة التبريد ٢. مياه وظل متوفر حالياً.",
              distance: "١٢٠ م",
              isOasis: true,
              oasisName: "واحة التبريد ٢ (صالة الكرك المبردة)",
              oasisTemp: "نسيم ٢٣°م نشط",
            ),
            _EgressStep(
              time: "١٤:٢٠",
              title: "عبور الساحة ب",
              desc: "مسار تفادي الازدحام عند بوابه التفتيش الأمنية ب٢.",
              distance: "٤٥٠ م",
            ),
            _EgressStep(
              time: "١٤:٢٢",
              title: "الوصول إلى بوابة B3 (المخرج)",
              desc: "البوابة خالية. حافلات النقل تغادر كل دقيقتين للمواقف.",
              distance: "٦٠٠ م",
            ),
          ];
      }
    } else {
      switch (category) {
        case RouteCategory.car:
          return [
            _EgressStep(
              time: "14:15",
              title: "Exit Section 4 Stand",
              desc:
                  "Proceed through the side concourse leading to Parking Zone B.",
              distance: "40 m",
              isCompleted: true,
            ),
            _EgressStep(
              time: "14:17",
              title: "Ramp Down to Level P2",
              desc: "Take the quick escalator down directly to Row B.",
              distance: "90 m",
            ),
            _EgressStep(
              time: "14:18",
              title: "Reach Vehicle #AXN-789",
              desc:
                  "Vehicle located. Smooth exit path towards Exit Gate B.",
              distance: "110 m",
            ),
          ];
        case RouteCategory.cooling:
          return [
            _EgressStep(
              time: "14:15",
              title: "Turn Left at Corridor 3",
              desc:
                  "Shaded misting corridor route with active air fresheners.",
              distance: "30 m",
              isCompleted: true,
            ),
            _EgressStep(
              time: "14:16",
              title: "Enter Air-Cooled Oasis Lounge",
              desc:
                  "Stop for hydration & rest in a fully climate-controlled space.",
              distance: "50 m",
              isOasis: true,
              oasisName: "Oasis Station 2 (Al-Karak Lounge)",
              oasisTemp: "23°C Breeze Active",
            ),
          ];
        case RouteCategory.firstaid:
          return [
            _EgressStep(
              time: "14:15",
              title: "North Corridor Escalator",
              desc:
                  "Clear priority corridor reserved for fast medical access.",
              distance: "60 m",
              isCompleted: true,
            ),
            _EgressStep(
              time: "14:17",
              title: "Arrive at Urgent Care Center",
              desc:
                  "On-site paramedics available 24/7 with immediate triage.",
              distance: "90 m",
            ),
          ];
        case RouteCategory.food:
          return [
            _EgressStep(
              time: "14:15",
              title: "East Plaza Concourse",
              desc:
                  "Head towards the central Bazaar Dining area.",
              distance: "150 m",
              isCompleted: true,
            ),
            _EgressStep(
              time: "14:19",
              title: "Bazaar Dining & Refreshments",
              desc:
                  "Fast service food stalls and cold beverage options.",
              distance: "160 m",
            ),
          ];
        case RouteCategory.gate:
        default:
          return [
            _EgressStep(
              time: "14:15",
              title: "Exit Row 12, Area B",
              desc:
                  "Proceed through the upper corridor towards Stairwell 4.",
              distance: "50 m",
              isCompleted: true,
            ),
            _EgressStep(
              time: "14:17",
              title: "Pass through Breezeway 2",
              desc:
                  "Stop at Oasis Station 2. Hydration and shade available.",
              distance: "120 m",
              isOasis: true,
              oasisName: "Oasis Station 2 (Al-Karak Lounge)",
              oasisTemp: "23°C Breeze Active",
            ),
            _EgressStep(
              time: "14:20",
              title: "Cross Concourse B",
              desc:
                  "Optimal path bypassing the Gate B2 security checkpoint bottleneck.",
              distance: "450 m",
            ),
            _EgressStep(
              time: "14:22",
              title: "Arrive at Gate B3 (Egress)",
              desc:
                  "Gate B3 is clear. Shuttle lines depart every 2 mins to parking.",
              distance: "600 m",
            ),
          ];
      }
    }
  }
}

class _RouteInfo {
  final String eta;
  final String dist;
  final String flow;

  _RouteInfo({
    required this.eta,
    required this.dist,
    required this.flow,
  });
}

class _EgressStep {
  final String time;
  final String title;
  final String desc;
  final String distance;
  final bool isCompleted;
  final bool isOasis;
  final String? oasisName;
  final String? oasisTemp;

  _EgressStep({
    required this.time,
    required this.title,
    required this.desc,
    required this.distance,
    this.isCompleted = false,
    this.isOasis = false,
    this.oasisName,
    this.oasisTemp,
  });
}