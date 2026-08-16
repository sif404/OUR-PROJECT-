import 'package:flutter/material.dart';

import '../models/app_scope.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum RouteCategory { gate, car, cooling, firstaid, food }

class ActiveRouteScreen extends StatefulWidget {
  const ActiveRouteScreen({super.key});

  @override
  State<ActiveRouteScreen> createState() => _ActiveRouteScreenState();
}

class _ActiveRouteScreenState extends State<ActiveRouteScreen> with SingleTickerProviderStateMixin {
  RouteCategory _selectedCategory = RouteCategory.gate;
  late AnimationController _pulseController;

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

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final isAr = scope.isArabic;
    final isLight = Theme.of(context).brightness != Brightness.dark;

    final bgColor = AppColors.bg(context);
    final surfaceColor = AppColors.surf(context);
    final textPrimary = AppColors.textP(context);
    final textSecondary = AppColors.textS(context);
    final borderColor = AppColors.border(context);
    final accentPrimary = isLight ? const Color(0xFF0D9488) : AppColors.pitch;

    final routeInfo = _getRouteInfo(_selectedCategory, isAr);
    final steps = _getSteps(_selectedCategory, isAr);

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
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).maybePop();
                        } else {
                          Navigator.of(context).pushNamed(Routes.smartExit);
                        }
                      },
                      icon: Icon(
                        isAr ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded,
                        color: textPrimary,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: surfaceColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: borderColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isAr ? "تفاصيل المسار الذكي" : "AI Route Details",
                          style: AppTextStyles.elMessiri(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isAr ? "إرشاد حي وتوجيه مغادرة بالملاحة" : "Step-by-Step Egress Guidance",
                          style: AppTextStyles.elMessiri(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 38,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCategoryChip(RouteCategory.gate, isAr ? "بوابة B3" : "Gate B3", Icons.sensor_door_rounded, accentPrimary, context),
                      _buildCategoryChip(RouteCategory.car, isAr ? "المواقف B" : "Parking B", Icons.directions_car_rounded, accentPrimary, context),
                      _buildCategoryChip(RouteCategory.cooling, isAr ? "واحة التبريد" : "Cooling Oasis", Icons.ac_unit_rounded, accentPrimary, context),
                      _buildCategoryChip(RouteCategory.firstaid, isAr ? "العيادة الطبية" : "Medical Zone", Icons.medical_services_rounded, accentPrimary, context),
                      _buildCategoryChip(RouteCategory.food, isAr ? "ساحة الطعام" : "Food Court", Icons.restaurant_rounded, accentPrimary, context),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(18),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              AnimatedBuilder(
                                animation: _pulseController,
                                builder: (context, child) {
                                  return Icon(
                                    Icons.explore_rounded,
                                    size: 16,
                                    color: accentPrimary.withValues(alpha: 0.6 + 0.4 * _pulseController.value),
                                  );
                                },
                              ),
                              const SizedBox(width: 6),
                              Text(
                                isAr ? "توجيه المسار النشط بالذكاء الاصطناعي" : "ACTIVE PATH GUIDANCE",
                                style: AppTextStyles.mono(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.8,
                                  color: accentPrimary,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
                            ),
                            child: Text(
                              isAr ? "مسار محسّن" : "AI OPTIMIZED",
                              style: AppTextStyles.mono(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF10B981),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStepStat(Icons.timer_rounded, isAr ? "الوقت المتبقي" : "TIME LEFT", routeInfo.eta, textPrimary, textSecondary),
                          Container(width: 1, height: 28, color: borderColor),
                          _buildStepStat(Icons.place_rounded, isAr ? "المسافة" : "DISTANCE", routeInfo.dist, textPrimary, textSecondary),
                          Container(width: 1, height: 28, color: borderColor),
                          _buildStepStat(Icons.trending_up_rounded, isAr ? "حالة التدفق" : "FLOW STATUS", routeInfo.flow, textPrimary, textSecondary, valueColor: const Color(0xFF10B981)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  isAr ? "خطوات المغادرة التتابعية" : "STEP-BY-STEP EGRESS TIMELINE",
                  style: AppTextStyles.mono(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: textSecondary,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
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
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.smartExit);
                      },
                      icon: const Icon(Icons.near_me_rounded, size: 18),
                      label: Text(
                        isAr ? "العودة إلى الخريطة التفاعلية" : "RETURN TO MAP",
                        style: AppTextStyles.mono(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                          color: textPrimary,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: surfaceColor,
                        foregroundColor: textPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: accentPrimary.withValues(alpha: 0.4)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(RouteCategory category, String label, IconData icon, Color accentPrimary, BuildContext context) {
    final isSelected = _selectedCategory == category;
    final surfaceColor = AppColors.surf(context);
    final textPrimary = AppColors.textP(context);
    final borderColor = AppColors.border(context);

    final chipBg = isSelected ? accentPrimary : surfaceColor;
    final chipText = isSelected ? Colors.white : textPrimary;
    final chipIcon = isSelected ? Colors.white : accentPrimary;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCategory = category;
          });
        },
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: chipBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? accentPrimary : borderColor,
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
                        ? const Color(0xFF10B981)
                        : step.isOasis
                            ? accentPrimary
                            : Colors.grey.withValues(alpha: 0.4),
                    border: Border.all(color: AppColors.bg(context), width: 2.5),
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
                      ? const Icon(Icons.check, size: 8, color: Colors.white)
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
                            color: step.isCompleted ? textSecondary : textPrimary,
                          ).copyWith(decoration: step.isCompleted ? TextDecoration.lineThrough : null),
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
                        color: accentPrimary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: accentPrimary.withValues(alpha: 0.25)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: accentPrimary.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.ac_unit_rounded, color: accentPrimary, size: 14),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isAr ? "منطقة واحة مكيفة" : "Air-Cooled Rest Oasis",
                                  style: AppTextStyles.mono(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w900,
                                    color: accentPrimary,
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
                      Icon(Icons.directions_walk_rounded, size: 11, color: textSecondary),
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
          dist: isAr ? "١.٢ كم" : "1.2 km",
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
