import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/app_scope.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum RouteType { gate, car, cooling, firstaid, food }

class RouteConfig {
  final String titleEn;
  final String titleAr;
  final String etaEn;
  final String etaAr;
  final String distEn;
  final String distAr;
  final String descEn;
  final String descAr;
  final Color color;
  final IconData icon;
  final List<Color> activeGradient;
  final List<Color> buttonGradient;
  final Color activeTextColor;
  final Color inactiveBgLight;
  final Color inactiveBorderLight;
  final Color inactiveTextLight;
  final Color inactiveBgDark;
  final Color inactiveBorderDark;
  final Color inactiveTextDark;

  const RouteConfig({
    required this.titleEn,
    required this.titleAr,
    required this.etaEn,
    required this.etaAr,
    required this.distEn,
    required this.distAr,
    required this.descEn,
    required this.descAr,
    required this.color,
    required this.icon,
    required this.activeGradient,
    required this.buttonGradient,
    required this.activeTextColor,
    required this.inactiveBgLight,
    required this.inactiveBorderLight,
    required this.inactiveTextLight,
    required this.inactiveBgDark,
    required this.inactiveBorderDark,
    required this.inactiveTextDark,
  });
}

const Map<RouteType, RouteConfig> kRouteConfigs = {
  RouteType.gate: RouteConfig(
    titleEn: "Smart Navigation",
    titleAr: "الملاحة الذكية",
    etaEn: "8 min",
    etaAr: "٨ دقائق",
    distEn: "1.2 km",
    distAr: "١٫٢ كم",
    descEn: "Optimal smart navigation path avoiding Gate B2 bottleneck",
    descAr: "مسار خروج مثالي ذكي يتفادى الزحام عند بوابة B2",
    color: Color(0xFF10B981),
    icon: Icons.explore_rounded,
    activeGradient: [Color(0xFF10B981), Color(0xFF2DD4BF), Color(0xFF6EE7B7)],
    buttonGradient: [Color(0xFF34D399), Color(0xFF2DD4BF)],
    activeTextColor: Color(0xFF020617),
    inactiveBgLight: Color(0xFFECFDF5),
    inactiveBorderLight: Color(0xFFA7F3D0),
    inactiveTextLight: Color(0xFF065F46),
    inactiveBgDark: Color(0x66022C22),
    inactiveBorderDark: Color(0x4D10B981),
    inactiveTextDark: Color(0xFF6EE7B7),
  ),
  RouteType.car: RouteConfig(
    titleEn: "Find My Car",
    titleAr: "العثور على سيارتي",
    etaEn: "3 min",
    etaAr: "٣ دقائق",
    distEn: "240 m",
    distAr: "٢٤٠ م",
    descEn: "Direct covered, cooled route to Zone B parking",
    descAr: "مسار مغطى ومبرد مباشرة إلى مواقف المنطقة ب",
    color: Color(0xFFFBBF24),
    icon: Icons.directions_car_rounded,
    activeGradient: [Color(0xFFFBBF24), Color(0xFFFACC15), Color(0xFFFDE047)],
    buttonGradient: [Color(0xFFFBBF24), Color(0xFFFACC15)],
    activeTextColor: Color(0xFF020617),
    inactiveBgLight: Color(0xFFFFFBEB),
    inactiveBorderLight: Color(0xFFFDE68A),
    inactiveTextLight: Color(0xFF92400E),
    inactiveBgDark: Color(0x66451A03),
    inactiveBorderDark: Color(0x4DFBBF24),
    inactiveTextDark: Color(0xFFFDE68A),
  ),
  RouteType.cooling: RouteConfig(
    titleEn: "Cooling Zones",
    titleAr: "مناطق التبريد",
    etaEn: "1 min",
    etaAr: "دقيقة واحدة",
    distEn: "80 m",
    distAr: "٨٠ م",
    descEn: "Cooling Oasis Lounge equipped with smart micro-cooling",
    descAr: "الواحة المبردة مجهزة بنظام نسيم مكيف نشط",
    color: Color(0xFF14E0C4),
    icon: Icons.ac_unit_rounded,
    activeGradient: [Color(0xFF22D3EE), Color(0xFF5EEAD4), Color(0xFF7DD3FC)],
    buttonGradient: [Color(0xFF22D3EE), Color(0xFF5EEAD4)],
    activeTextColor: Color(0xFF020617),
    inactiveBgLight: Color(0xFFECFEFF),
    inactiveBorderLight: Color(0xFFA5F3FC),
    inactiveTextLight: Color(0xFF155E75),
    inactiveBgDark: Color(0x66083344),
    inactiveBorderDark: Color(0x4D14E0C4),
    inactiveTextDark: Color(0xFF67E8F9),
  ),
  RouteType.firstaid: RouteConfig(
    titleEn: "First Aid",
    titleAr: "الإسعافات الأولية",
    etaEn: "2 min",
    etaAr: "دقيقتان",
    distEn: "150 m",
    distAr: "١٥٠ م",
    descEn: "West Medical Clinic - On-duty emergency staff active",
    descAr: "العيادة الطبية الغربية - كادر متاح حالياً",
    color: Color(0xFFEF4444),
    icon: Icons.medical_services_rounded,
    activeGradient: [Color(0xFFF43F5E), Color(0xFFEF4444), Color(0xFFEC4899)],
    buttonGradient: [Color(0xFFF43F5E), Color(0xFFEF4444)],
    activeTextColor: Colors.white,
    inactiveBgLight: Color(0xFFFFF1F2),
    inactiveBorderLight: Color(0xFFFECDD3),
    inactiveTextLight: Color(0xFF9F1239),
    inactiveBgDark: Color(0x664C0519),
    inactiveBorderDark: Color(0x4DEF4444),
    inactiveTextDark: Color(0xFFFDA4AF),
  ),
  RouteType.food: RouteConfig(
    titleEn: "Food Court",
    titleAr: "ساحة الطعام",
    etaEn: "4 min",
    etaAr: "٤ دقائق",
    distEn: "310 m",
    distAr: "٣١٠ م",
    descEn: "Eastern Bazaar Dining - Open air and covered food options",
    descAr: "ساحة الطعام الشرقية مجهزة بكافة المرافق والمطاعم",
    color: Color(0xFFF59E0B),
    icon: Icons.restaurant_rounded,
    activeGradient: [Color(0xFFFB923C), Color(0xFFFBBF24), Color(0xFFFDE047)],
    buttonGradient: [Color(0xFFFB923C), Color(0xFFFBBF24)],
    activeTextColor: Color(0xFF020617),
    inactiveBgLight: Color(0xFFFFF7ED),
    inactiveBorderLight: Color(0xFFFED7AA),
    inactiveTextLight: Color(0xFF9A3412),
    inactiveBgDark: Color(0x66431407),
    inactiveBorderDark: Color(0x4DF59E0B),
    inactiveTextDark: Color(0xFFFDBA74),
  ),
};

class SmartExitScreen extends StatefulWidget {
  const SmartExitScreen({super.key});

  @override
  State<SmartExitScreen> createState() => _SmartExitScreenState();
}

class _SmartExitScreenState extends State<SmartExitScreen> with TickerProviderStateMixin {
  final TransformationController _transformationController = TransformationController();

  RouteType _activeRoute = RouteType.gate;
  late AnimationController _pulseController;
  late AnimationController _pathPulseController;
  late AnimationController _dashController;

  @override
  void initState() {
    super.initState();
    _transformationController.value = Matrix4.identity();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _pathPulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400))..repeat(reverse: true);
    _dashController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _pathPulseController.dispose();
    _dashController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _selectRoute(RouteType route) {
    setState(() {
      _activeRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final isAr = scope.isArabic;
    final isLight = Theme.of(context).brightness != Brightness.dark;

    final bgColor = isLight ? const Color(0xFFF7F6F2) : AppColors.void_;
    final cardBgColor = isLight ? Colors.white : const Color(0xBF0B1220);
    final textColor = isLight ? const Color(0xFF111111) : Colors.white;
    final subTextColor = isLight ? const Color(0xFF6E6E6E) : Colors.white70;
    final borderColor = isLight ? const Color(0xFFE7E2DA) : Colors.white24;

    final config = kRouteConfigs[_activeRoute]!;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 8),
              child: Directionality(
                textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
                child: Column(
                  children: [
                    Row(
                      children: [
                        _AnimatedPressButton(
                          onTap: () => Navigator.of(context).maybePop(),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isLight ? Colors.white : Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: isLight ? borderColor : Colors.white.withValues(alpha: 0.10)),
                            ),
                            child: Icon(Icons.arrow_back_rounded, color: textColor, size: 20),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              scope.t('smartExit_title'),
                              style: AppTextStyles.elMessiri(fontSize: 18, fontWeight: FontWeight.w800, color: textColor),
                            ),
                            Text(
                              scope.t('smartExit_subtitle'),
                              style: AppTextStyles.plexArabic(fontSize: 11, fontWeight: FontWeight.w600, color: subTextColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _glassWrap(
                      isLight: isLight,
                      borderRadius: 16,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: cardBgColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isLight ? const Color(0xFFE7E2DA).withValues(alpha: 0.7) : Colors.white.withValues(alpha: 0.10),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isLight ? Colors.black.withValues(alpha: 0.04) : Colors.black.withValues(alpha: 0.35),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    AnimatedBuilder(
                                      animation: _pulseController,
                                      builder: (context, child) {
                                        return Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: config.color,
                                            boxShadow: [
                                              BoxShadow(
                                                color: config.color.withValues(alpha: 0.6 * _pulseController.value),
                                                blurRadius: 8,
                                                spreadRadius: 2,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 200),
                                      child: Text(
                                        isAr ? config.titleAr.toUpperCase() : config.titleEn.toUpperCase(),
                                        key: ValueKey(config.titleEn),
                                        style: AppTextStyles.mono(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w800,
                                          color: textColor,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: config.color.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: config.color.withValues(alpha: 0.3)),
                                  ),
                                  child: Text(
                                    scope.t('smartExit_live'),
                                    style: AppTextStyles.mono(fontSize: 8, fontWeight: FontWeight.w800, color: config.color),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        scope.t('smartExit_etaLabel'),
                                        style: AppTextStyles.mono(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                          color: subTextColor,
                                          letterSpacing: 0.4,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 200),
                                        child: Text(
                                          isAr ? config.etaAr : config.etaEn,
                                          key: ValueKey(config.etaEn),
                                          style: AppTextStyles.elMessiri(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w800,
                                            color: config.color,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        scope.t('smartExit_distanceLabel'),
                                        style: AppTextStyles.mono(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                          color: subTextColor,
                                          letterSpacing: 0.4,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 200),
                                        child: Text(
                                          isAr ? config.distAr : config.distEn,
                                          key: ValueKey(config.distEn),
                                          style: AppTextStyles.elMessiri(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w800,
                                            color: config.color,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: Text(
                                isAr ? config.descAr : config.descEn,
                                key: ValueKey(config.descEn),
                                style: AppTextStyles.plexArabic(fontSize: 11.5, color: subTextColor, height: 1.35),
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
            const SizedBox(height: 4),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isLight ? const Color(0xFFFAF7F2) : const Color(0xFF151D2A),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: borderColor),
                        ),
                        child: InteractiveViewer(
                          transformationController: _transformationController,
                          minScale: 0.8,
                          maxScale: 2.5,
                          child: AnimatedBuilder(
                            animation: Listenable.merge([_pulseController, _pathPulseController, _dashController]),
                            builder: (context, _) {
                              return Stack(
                                children: [
                                  Positioned.fill(
                                    child: CustomPaint(
                                      painter: TargetStadiumPainter(
                                        isLight: isLight,
                                        activeRoute: _activeRoute,
                                        pulseValue: _pathPulseController.value,
                                        dashPhase: _dashController.value,
                                      ),
                                    ),
                                  ),
                                  _buildMapBadge(
                                    top: 55,
                                    left: 25,
                                    label: scope.t('smartExit_firstAid'),
                                    dotColor: const Color(0xFFEF4444),
                                    routeType: RouteType.firstaid,
                                  ),
                                  _buildMapBadge(
                                    top: 55,
                                    right: 25,
                                    label: scope.t('smartExit_foodCourt'),
                                    dotColor: const Color(0xFFF59E0B),
                                    routeType: RouteType.food,
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: _mapBadgeContent(
                                        label: scope.t('smartExit_gate', {'name': 'B1 - Low'}),
                                        dotColor: const Color(0xFF10B981),
                                        routeType: RouteType.gate,
                                      ),
                                    ),
                                  ),
                                  _buildMapBadge(
                                    top: 90,
                                    right: 30,
                                    label: scope.t('smartExit_gate', {'name': 'B3 - Heavy'}),
                                    dotColor: const Color(0xFF10B981),
                                    routeType: RouteType.gate,
                                  ),
                                  _buildMapBadge(
                                    top: 145,
                                    right: 18,
                                    label: scope.t('smartExit_gate', {'name': 'B2 - Moderate'}),
                                    dotColor: const Color(0xFF10B981),
                                    routeType: RouteType.gate,
                                  ),
                                  _buildMapBadge(
                                    top: 185,
                                    left: 105,
                                    label: scope.t('activeRoute_oasisLabel'),
                                    dotColor: const Color(0xFF14E0C4),
                                    routeType: RouteType.cooling,
                                  ),
                                  _buildMapBadge(
                                    bottom: 50,
                                    left: 35,
                                    label: scope.t('smartExit_findMyCar'),
                                    dotColor: const Color(0xFFFBBF24),
                                    routeType: RouteType.car,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 16,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildMapControlButton(
                            icon: Icons.add,
                            onTap: () {
                              _transformationController.value = Matrix4.copy(_transformationController.value)..scale(1.2, 1.2, 1.0);
                            },
                            text: textColor,
                            border: borderColor,
                            isLight: isLight,
                          ),
                          const SizedBox(height: 6),
                          _buildMapControlButton(
                            icon: Icons.remove,
                            onTap: () {
                              _transformationController.value = Matrix4.copy(_transformationController.value)..scale(0.8, 0.8, 1.0);
                            },
                            text: textColor,
                            border: borderColor,
                            isLight: isLight,
                          ),
                          const SizedBox(height: 6),
                          _buildMapControlButton(
                            icon: Icons.aspect_ratio_rounded,
                            onTap: () => _transformationController.value = Matrix4.identity(),
                            text: textColor,
                            border: borderColor,
                            isLight: isLight,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
              child: Directionality(
                textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      _buildRouteChip(route: RouteType.gate, label: scope.t('smartExit_exitStrategy'), icon: Icons.explore_rounded, isLight: isLight),
                      const SizedBox(width: 8),
                      _buildRouteChip(route: RouteType.car, label: scope.t('smartExit_findMyCar'), icon: Icons.directions_car_rounded, isLight: isLight),
                      const SizedBox(width: 8),
                      _buildRouteChip(route: RouteType.cooling, label: scope.t('smartExit_coolingZones'), icon: Icons.ac_unit_rounded, isLight: isLight),
                      const SizedBox(width: 8),
                      _buildRouteChip(route: RouteType.firstaid, label: scope.t('smartExit_firstAid'), icon: Icons.medical_services_rounded, isLight: isLight),
                      const SizedBox(width: 8),
                      _buildRouteChip(route: RouteType.food, label: scope.t('smartExit_foodCourt'), icon: Icons.restaurant_rounded, isLight: isLight),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 16),
              child: _glassWrap(
                isLight: isLight,
                borderRadius: 16,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isLight ? const Color(0xFFE7E2DA) : Colors.white.withValues(alpha: 0.10), width: 1.2),
                    boxShadow: [
                      BoxShadow(
                        color: isLight ? Colors.black.withValues(alpha: 0.06) : Colors.black.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: _AnimatedPressButton(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(scope.t('smartExit_comingSoon'))),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: config.buttonGradient, begin: AlignmentDirectional.centerStart, end: AlignmentDirectional.centerEnd),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: config.color.withValues(alpha: 0.30), blurRadius: 10, offset: const Offset(0, 4))],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shortcut_rounded, size: 18, color: config.activeTextColor),
                            const SizedBox(width: 8),
                            Text(
                              scope.t('smartExit_startGuidedExit'),
                              style: AppTextStyles.mono(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassWrap({required Widget child, required double borderRadius, required bool isLight}) {
    if (isLight) return child;
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: child,
      ),
    );
  }

  Widget _buildRouteChip({required RouteType route, required String label, required IconData icon, required bool isLight}) {
    final isSelected = _activeRoute == route;
    final config = kRouteConfigs[route]!;

    final chipBgColor = isSelected ? Colors.transparent : (isLight ? config.inactiveBgLight : config.inactiveBgDark);
    final chipBorderColor = isSelected ? config.activeGradient.first : (isLight ? config.inactiveBorderLight : config.inactiveBorderDark);
    final chipTextColor = isSelected ? config.activeTextColor : (isLight ? config.inactiveTextLight : config.inactiveTextDark);

    final chipCore = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? null : chipBgColor,
        gradient: isSelected ? LinearGradient(colors: config.activeGradient, begin: AlignmentDirectional.centerStart, end: AlignmentDirectional.centerEnd) : null,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipBorderColor, width: 1.2),
        boxShadow: isSelected ? [BoxShadow(color: config.color.withValues(alpha: 0.35), blurRadius: 10, offset: const Offset(0, 4))] : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: chipTextColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.plexArabic(fontSize: 12, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600, color: chipTextColor),
          ),
        ],
      ),
    );

    return _AnimatedPressButton(
      onTap: () => _selectRoute(route),
      child: AnimatedScale(
        scale: isSelected ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: isSelected
            ? Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: config.color.withValues(alpha: 0.5), width: 2),
                ),
                child: chipCore,
              )
            : chipCore,
      ),
    );
  }

  Widget _mapBadgeContent({required String label, required Color dotColor, required RouteType routeType}) {
    final isSelected = _activeRoute == routeType;

    return _AnimatedPressButton(
      onTap: () => _selectRoute(routeType),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? dotColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: dotColor, width: 1.4),
          boxShadow: [BoxShadow(color: dotColor.withValues(alpha: isSelected ? 0.4 : 0.15), blurRadius: isSelected ? 8 : 4, offset: const Offset(0, 2))],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.white : dotColor,
                    boxShadow: isSelected ? [BoxShadow(color: Colors.white.withValues(alpha: 0.8 * _pulseController.value), blurRadius: 4)] : [],
                  ),
                );
              },
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: AppTextStyles.mono(
                fontSize: 8.5,
                fontWeight: FontWeight.w800,
                color: isSelected ? Colors.black : Colors.black87,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapBadge({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required String label,
    required Color dotColor,
    required RouteType routeType,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: _mapBadgeContent(label: label, dotColor: dotColor, routeType: routeType),
    );
  }

  Widget _buildMapControlButton({required IconData icon, required VoidCallback onTap, required Color text, required Color border, required bool isLight}) {
    return _AnimatedPressButton(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isLight ? Colors.white : Colors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isLight ? border : Colors.white.withValues(alpha: 0.10)),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4)],
        ),
        child: Icon(icon, color: text, size: 16),
      ),
    );
  }
}

class _AnimatedPressButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _AnimatedPressButton({required this.child, required this.onTap});

  @override
  State<_AnimatedPressButton> createState() => _AnimatedPressButtonState();
}

class _AnimatedPressButtonState extends State<_AnimatedPressButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}

class TargetStadiumPainter extends CustomPainter {
  final bool isLight;
  final RouteType activeRoute;
  final double pulseValue;
  final double dashPhase;

  TargetStadiumPainter({
    required this.isLight,
    required this.activeRoute,
    required this.pulseValue,
    required this.dashPhase,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final center = Offset(width / 2, height / 2);

    final config = kRouteConfigs[activeRoute]!;

    final gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.10)
      ..strokeWidth = 1.0;

    const step = 20.0;
    for (double i = 0; i < width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, height), gridPaint);
    }
    for (double i = 0; i < height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(width, i), gridPaint);
    }

    final baseW = width * 0.88;

    final outerRingPaint = Paint()
      ..color = (isLight ? Colors.black : Colors.white).withValues(alpha: 0.06)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawOval(Rect.fromCenter(center: center, width: baseW, height: baseW * 0.70), outerRingPaint);

    final redDashPaint = Paint()
      ..color = const Color(0xFFC8102E)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    _drawDashedOval(
      canvas,
      Rect.fromCenter(center: center, width: baseW * 0.78, height: baseW * 0.78 * 0.68),
      redDashPaint,
    );

    final innerRingPaint = Paint()
      ..color = const Color(0xFFC8102E).withValues(alpha: 0.6)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    canvas.drawOval(Rect.fromCenter(center: center, width: baseW * 0.53, height: baseW * 0.53 * 0.64), innerRingPaint);

    final pitchPaint = Paint()
      ..color = const Color(0xFFD1FAE5)
      ..style = PaintingStyle.fill;

    final pitchBorderPaint = Paint()
      ..color = const Color(0xFF10B981)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final pitchW = baseW * 0.24;
    final pitchRect = Rect.fromCenter(center: center, width: pitchW, height: pitchW / 1.6);
    canvas.drawRRect(RRect.fromRectAndRadius(pitchRect, const Radius.circular(8)), pitchPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(pitchRect, const Radius.circular(8)), pitchBorderPaint);

    final markingPaint = Paint()
      ..color = const Color(0xFF10B981).withValues(alpha: 0.7)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(center.dx, pitchRect.top), Offset(center.dx, pitchRect.bottom), markingPaint);
    canvas.drawCircle(center, 9, markingPaint);

    final path = Path();
    final start = Offset(center.dx - 20, center.dy + 120);
    path.moveTo(start.dx, start.dy);

    switch (activeRoute) {
      case RouteType.car:
        path.cubicTo(center.dx - 40, center.dy + 130, center.dx - 80, center.dy + 140, center.dx - 100, center.dy + 150);
        break;
      case RouteType.cooling:
        path.cubicTo(center.dx - 20, center.dy + 60, center.dx - 10, center.dy + 30, center.dx, center.dy);
        break;
      case RouteType.firstaid:
        path.cubicTo(center.dx - 50, center.dy + 60, center.dx - 80, center.dy - 20, center.dx - 90, center.dy - 80);
        break;
      case RouteType.food:
        path.cubicTo(center.dx + 20, center.dy + 40, center.dx + 70, center.dy - 20, center.dx + 90, center.dy - 80);
        break;
      case RouteType.gate:
        path.cubicTo(center.dx - 40, center.dy + 50, center.dx - 15, center.dy, center.dx + 80, center.dy - 90);
        break;
    }

    final outerOpacity = 0.2 + (pulseValue * 0.35);
    final innerOpacity = 0.75 + (pulseValue * 0.25);

    final pathOuterGlow = Paint()
      ..color = config.color.withValues(alpha: outerOpacity)
      ..strokeWidth = 14.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final pathFillPaint = Paint()
      ..color = config.color.withValues(alpha: innerOpacity)
      ..strokeWidth = 7.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final pathHatchPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, pathOuterGlow);
    canvas.drawPath(path, pathFillPaint);
    _drawDashedPath(canvas, path, pathHatchPaint, 6.0, 4.0, dashPhase * 10.0);

    final youPing = Paint()..color = const Color(0xFF10B981).withValues(alpha: 0.22 * (1 - pulseValue) + 0.05);
    canvas.drawCircle(start, 11 + (pulseValue * 5), youPing);

    canvas.drawCircle(start, 6, Paint()..color = const Color(0xFF10B981));
    canvas.drawCircle(
      start,
      6,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    final youLabelRect = Rect.fromCenter(center: Offset(start.dx, start.dy + 20), width: 34, height: 15);
    canvas.drawRRect(
      RRect.fromRectAndRadius(youLabelRect, const Radius.circular(5)),
      Paint()..color = isLight ? Colors.white : const Color(0xFF0F172A),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(youLabelRect, const Radius.circular(5)),
      Paint()
        ..color = const Color(0xFF10B981)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'YOU',
        style: TextStyle(color: Color(0xFF10B981), fontSize: 7.5, fontWeight: FontWeight.w800),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(youLabelRect.center.dx - textPainter.width / 2, youLabelRect.center.dy - textPainter.height / 2));
  }

  void _drawDashedOval(Canvas canvas, Rect rect, Paint paint) {
    const dashWidth = 6.0;
    const dashSpace = 4.0;

    final path = Path()..addOval(rect);
    for (final metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + dashWidth), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint, double dashWidth, double dashSpace, double phaseOffset) {
    final cycle = dashWidth + dashSpace;
    for (final metric in path.computeMetrics()) {
      double distance = -(phaseOffset % cycle);
      while (distance < metric.length) {
        final segStart = distance < 0 ? 0 : distance;
        final segEnd = distance + dashWidth;
        if (segEnd > 0) {
          canvas.drawPath(
            metric.extractPath(
              segStart.clamp(0.0, metric.length).toDouble(),
              segEnd.clamp(0.0, metric.length).toDouble(),
            ),
            paint,
          );
        }
        distance += cycle;
      }
    }
  }

  @override
  bool shouldRepaint(covariant TargetStadiumPainter oldDelegate) {
    return oldDelegate.isLight != isLight ||
        oldDelegate.activeRoute != activeRoute ||
        oldDelegate.pulseValue != pulseValue ||
        oldDelegate.dashPhase != dashPhase;
  }
}
