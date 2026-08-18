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
        return isAr ? 'أقل مشياً' : 'Less walking';
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
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
        final surfaceColor = AppColors.paperOf(sheetContext);
        final textPrimary = AppColors.voidOf(sheetContext);
        final textSecondary = AppColors.inkSoft;
        final borderColor = AppColors.stoneLineOf(sheetContext);

        final options = [
          (
            id: 'avoidCrowds',
            icon: Icons.groups_rounded,
            title: isAr ? 'تجنب الازدحام' : 'Avoid crowds',
            desc: isAr ? 'تفضيل المسارات الأقل ازدحاماً' : 'Prefer lower-crowd paths',
          ),
          (
            id: 'fastest',
            icon: Icons.bolt_rounded,
            title: isAr ? 'الأسرع' : 'Fastest',
            desc: isAr ? 'أقصر وقت للوصول' : 'Minimize arrival time',
          ),
          (
            id: 'lessWalking',
            icon: Icons.directions_walk_rounded,
            title: isAr ? 'أقل مشياً' : 'Less walking',
            desc: isAr ? 'تقليل مسافة المشي' : 'Reduce walking distance',
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
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: textSecondary.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  isAr ? 'تفضيلات المسار' : 'Route Preferences',
                  style: AppTextStyles.elMessiri(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isAr
                      ? 'سيستخدم المساعد الذكي هذا الخيار لاقتراح أفضل طريق.'
                      : 'AXN will optimize your route based on this selection.',
                  style: AppTextStyles.plexArabic(
                    fontSize: 11.5,
                    color: textSecondary,
                  ),
                ),
                const SizedBox(height: 14),
                ...options.map(
                  (option) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
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
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _routePreference == option.id
                                ? AppColors.ember.withValues(alpha: 0.4)
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
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    option.title,
                                    style: AppTextStyles.elMessiri(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    option.desc,
                                    style: AppTextStyles.plexArabic(
                                      fontSize: 10,
                                      color: textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_routePreference == option.id)
                              const Icon(
                                Icons.check_circle_rounded,
                                size: 20,
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
        : (isAr ? 'منخفض' : 'Low');

    final crowdColor = crowd == (isAr ? 'منخفض' : 'Low')
        ? const Color(0xFF10B981)
        : const Color(0xFFF59E0B);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Directionality(
          textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
          child: Column(
            children: [
              // 1. شريط الرأس النظيف مع زر التفضيل السريع
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                child: Row(
                  children: [
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
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isAr ? 'المسار النشط' : 'Active Navigation',
                            style: AppTextStyles.hTitle(
                              color: AppColors.void_,
                            ).copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            isAr ? 'إرشاد مباشر للمغادرة' : 'Live exit guidance',
                            style: AppTextStyles.hSub.copyWith(
                              color: AppColors.inkSoft,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // زر التفضيلات بالأعلى بدلاً من إخفائه بالأسفل
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => _openRoutePreferences(context, isAr),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.cardBgOf(context),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: borderColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.tune_rounded,
                              size: 13,
                              color: AppColors.ember,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              _preferenceLabel(isAr),
                              style: AppTextStyles.mono(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
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

              // 2. أزرار الوجهات المريحة (Categories Tabs)
              SizedBox(
                height: 38,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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

              // 3. المحتوى القابل للتمرير براحة تامة
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // بطاقة المسار الرئيسية المدمجة (Map + HUD Stats)
                      Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: borderColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // معاينة الخريطة التفاعلية
                            SizedBox(
                              height: 160,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(21)),
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
                                    // شارة حالة المسار
                                    PositionedDirectional(
                                      top: 10,
                                      start: 10,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: cardColor.withValues(alpha: 0.9),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: borderColor),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.near_me_rounded,
                                              size: 12,
                                              color: Color(0xFF10B981),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              isAr ? 'المسار النشط' : 'LIVE ROUTE',
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

                            // ملخص الوقت والمسافة ومستوى الازدحام
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // الوقت المتبقي
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            isAr ? 'الوقت المقدر' : 'ESTIMATED TIME',
                                            style: AppTextStyles.mono(
                                              fontSize: 8.5,
                                              color: textSecondary,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            routeInfo.eta,
                                            style: AppTextStyles.elMessiri(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                              color: textPrimary,
                                            ),
                                          ),
                                        ],
                                      ),

                                      // المسافة
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            isAr ? 'المسافة' : 'DISTANCE',
                                            style: AppTextStyles.mono(
                                              fontSize: 8.5,
                                              color: textSecondary,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            routeInfo.dist,
                                            style: AppTextStyles.elMessiri(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                              color: textPrimary,
                                            ),
                                          ),
                                        ],
                                      ),

                                      // شارة الازدحام
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: crowdColor.withValues(alpha: 0.12),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: crowdColor.withValues(alpha: 0.3),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.groups_rounded, size: 14, color: crowdColor),
                                            const SizedBox(width: 5),
                                            Text(
                                              crowd,
                                              style: AppTextStyles.mono(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w900,
                                                color: crowdColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  // شريط التقدم النحيف
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: LinearProgressIndicator(
                                      value: _progress,
                                      minHeight: 5,
                                      backgroundColor: borderColor.withValues(alpha: 0.4),
                                      valueColor: AlwaysStoppedAnimation<Color>(accentPrimary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // 4. بطاقة التنبيه والتوجيه الذكي الموحدة (Smart Dynamic Alert)
                      if (_selectedCategory == RouteCategory.gate)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF59E0B).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.warning_amber_rounded,
                                size: 20,
                                color: Color(0xFFF59E0B),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  _showAlternativeRoute
                                      ? (isAr
                                          ? 'تم تحويلك إلى مسار بديل أسرع لتجنب الازدحام.'
                                          : 'Rerouted to a faster path bypassing congestion.')
                                      : (isAr
                                          ? 'ازدحام متزايد عند B2 - تم تجهيز مسار بديل.'
                                          : 'Heavy crowd at B2. Alternative route ready.'),
                                  style: AppTextStyles.plexArabic(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: textPrimary,
                                  ),
                                ),
                              ),
                              if (!_showAlternativeRoute)
                                TextButton(
                                  onPressed: () => _recalculateRoute(isAr),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    isAr ? 'تطبيق البديل' : 'APPLY',
                                    style: AppTextStyles.mono(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.ember,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                      const SizedBox(height: 14),

                      // 5. نقاط الراحة والخدمات المساعدة (Waypoints Chips)
                      Row(
                        children: [
                          Text(
                            isAr ? "مرافق في طريقك" : "WAYPOINTS",
                            style: AppTextStyles.mono(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: textSecondary,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: SizedBox(
                              height: 30,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  _buildWaypointChip(
                                    isAr ? 'تبريد' : 'Cooling',
                                    Icons.ac_unit_rounded,
                                    const Color(0xFF14E0C4),
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
                                    isAr ? 'طعام' : 'Food',
                                    Icons.restaurant_rounded,
                                    const Color(0xFFF59E0B),
                                    textPrimary,
                                    borderColor,
                                    paperColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // 6. عنوان الخط الزمني للمسار
                      Text(
                        isAr ? "خطوات المغادرة التتابعية" : "EGRESS TIMELINE",
                        style: AppTextStyles.mono(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: AppColors.ember,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 7. الخط الزمني بدون حشر أو تقطيع
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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

                      const SizedBox(height: 80), // مساحة للأزرار الثابتة بالأسفل
                    ],
                  ),
                ),
              ),

              // 8. شريط الإجراءات السفلي النظيف والثابت (Floating Bottom Actions)
              Container(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                decoration: BoxDecoration(
                  color: bgColor,
                  border: Border(top: BorderSide(color: borderColor)),
                ),
                child: Row(
                  children: [
                    // زر العودة للخريطة
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 46,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.smartExit);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: borderColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            isAr ? "الخريطة" : "MAP",
                            style: AppTextStyles.mono(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // زر إعادة حساب المسار الرئيسي
                    Expanded(
                      flex: 2,
                      child: SizedBox(
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
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.refresh_rounded, size: 18),
                          label: Text(
                            _isRecalculating
                                ? (isAr ? 'جاري التحديث...' : 'UPDATING...')
                                : (isAr ? 'إعادة حساب المسار' : 'RECALCULATE ROUTE'),
                            style: AppTextStyles.mono(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.void_,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
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
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.stoneLineOf(context)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(
          width: 38,
          height: 38,
          child: Icon(
            icon,
            size: 18,
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
      padding: const EdgeInsetsDirectional.only(end: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.cardBgOf(context),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
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
      padding: const EdgeInsetsDirectional.only(end: 8),
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: chipBg,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isSelected ? AppColors.voidOf(context) : borderColor,
            ),
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
          // خط ومؤشر النقطة
          SizedBox(
            width: 20,
            child: Column(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: step.isCompleted
                        ? const Color(0xFF10B981)
                        : step.isOasis
                            ? AppColors.gold
                            : AppColors.ember,
                    border: Border.all(
                      color: AppColors.bg(context),
                      width: 2.5,
                    ),
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
          // تفاصيل الخطوة
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
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
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: step.isCompleted ? textSecondary : textPrimary,
                          ).copyWith(
                            decoration: step.isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ),
                      Text(
                        step.time,
                        style: AppTextStyles.mono(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    step.desc,
                    style: AppTextStyles.plexArabic(
                      fontSize: 10.5,
                      color: textSecondary,
                      height: 1.35,
                    ),
                  ),
                  // بطاقة واحة التبريد إن وجدت
                  if (step.isOasis && step.oasisName != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF10B981).withValues(alpha: 0.25),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.ac_unit_rounded,
                            color: Color(0xFF10B981),
                            size: 15,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  step.oasisName!,
                                  style: AppTextStyles.elMessiri(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.bold,
                                    color: textPrimary,
                                  ),
                                ),
                                if (step.oasisTemp != null)
                                  Text(
                                    step.oasisTemp!,
                                    style: AppTextStyles.mono(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF10B981),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.directions_walk_rounded, size: 12, color: textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        step.distance,
                        style: AppTextStyles.mono(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
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
          eta: isAr ? "٣ د" : "3 min",
          dist: isAr ? "٢٤٠ م" : "240 m",
          flow: isAr ? "سريع جداً" : "Fast Pace",
        );
      case RouteCategory.cooling:
        return _RouteInfo(
          eta: isAr ? "١ د" : "1 min",
          dist: isAr ? "٨٠ م" : "80 m",
          flow: isAr ? "مكيف مريح" : "Air-Cooled",
        );
      case RouteCategory.firstaid:
        return _RouteInfo(
          eta: isAr ? "٢ د" : "2 min",
          dist: isAr ? "١٥٠ م" : "150 m",
          flow: isAr ? "مسار أولوية" : "Priority",
        );
      case RouteCategory.food:
        return _RouteInfo(
          eta: isAr ? "٤ د" : "4 min",
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
              desc: "Proceed through the side concourse leading to Parking Zone B.",
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
              desc: "Vehicle located. Smooth exit path towards Exit Gate B.",
              distance: "110 m",
            ),
          ];
        case RouteCategory.cooling:
          return [
            _EgressStep(
              time: "14:15",
              title: "Turn Left at Corridor 3",
              desc: "Shaded misting corridor route with active air fresheners.",
              distance: "30 m",
              isCompleted: true,
            ),
            _EgressStep(
              time: "14:16",
              title: "Enter Air-Cooled Oasis Lounge",
              desc: "Stop for hydration & rest in a fully climate-controlled space.",
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
              desc: "Clear priority corridor reserved for fast medical access.",
              distance: "60 m",
              isCompleted: true,
            ),
            _EgressStep(
              time: "14:17",
              title: "Arrive at Urgent Care Center",
              desc: "On-site paramedics available 24/7 with immediate triage.",
              distance: "90 m",
            ),
          ];
        case RouteCategory.food:
          return [
            _EgressStep(
              time: "14:15",
              title: "East Plaza Concourse",
              desc: "Head towards the central Bazaar Dining area.",
              distance: "150 m",
              isCompleted: true,
            ),
            _EgressStep(
              time: "14:19",
              title: "Bazaar Dining & Refreshments",
              desc: "Fast service food stalls and cold beverage options.",
              distance: "160 m",
            ),
          ];
        case RouteCategory.gate:
        default:
          return [
            _EgressStep(
              time: "14:15",
              title: "Exit Row 12, Area B",
              desc: "Proceed through the upper corridor towards Stairwell 4.",
              distance: "50 m",
              isCompleted: true,
            ),
            _EgressStep(
              time: "14:17",
              title: "Pass through Breezeway 2",
              desc: "Stop at Oasis Station 2. Hydration and shade available.",
              distance: "120 m",
              isOasis: true,
              oasisName: "Oasis Station 2 (Al-Karak Lounge)",
              oasisTemp: "23°C Breeze Active",
            ),
            _EgressStep(
              time: "14:20",
              title: "Cross Concourse B",
              desc: "Optimal path bypassing the Gate B2 security checkpoint bottleneck.",
              distance: "450 m",
            ),
            _EgressStep(
              time: "14:22",
              title: "Arrive at Gate B3 (Egress)",
              desc: "Gate B3 is clear. Shuttle lines depart every 2 mins to parking.",
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
