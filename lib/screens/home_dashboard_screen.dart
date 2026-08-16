import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/app_scope.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'evacuation_screen.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final isAr = scope.isArabic;
    final isLight = Theme.of(context).brightness != Brightness.dark;

    final bgColor = isLight ? const Color(0xFFF7F6F2) : AppColors.void_;
    final cardBg = isLight ? Colors.white : const Color(0xFF141B2E);
    final textColor = isLight ? const Color(0xFF111111) : Colors.white;
    final subTextColor = isLight ? const Color(0xFF6E6E6E) : Colors.white70;
    final borderColor = isLight ? const Color(0xFFE7E2DA) : Colors.white24;

    return Scaffold(
      extendBody: true,
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 92),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeaderRow(isAr: isAr, textColor: textColor),
              const SizedBox(height: 16),
              Text(
                isAr ? 'زوار الاستاد حالياً' : 'LIVE STADIUM VISITORS',
                style: AppTextStyles.mono(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: subTextColor,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              _HeroVisitorsCard(
                isAr: isAr,
                cardBg: cardBg,
                textColor: textColor,
                subTextColor: subTextColor,
                borderColor: borderColor,
              ),
              const SizedBox(height: 18),
              Text(
                isAr ? 'بيئة الاستاد' : 'STADIUM ENVIRONMENTS',
                style: AppTextStyles.mono(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: subTextColor,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              _EnvironmentGrid(isAr: isAr, textColor: textColor),
              const SizedBox(height: 18),
              _EveningPlanCard(
                isAr: isAr,
                cardBg: cardBg,
                textColor: textColor,
                subTextColor: subTextColor,
                borderColor: borderColor,
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.tripScreen);
                },
              ),
              const SizedBox(height: 10),
              _RewardsCompactCard(
                isAr: isAr,
                cardBg: cardBg,
                textColor: textColor,
                subTextColor: subTextColor,
                borderColor: borderColor,
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.rewards);
                },
              ),
              const SizedBox(height: 16),
              Text(
                isAr ? 'الخدمات السريعة' : 'QUICK ASSIST',
                style: AppTextStyles.mono(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: subTextColor,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              _QuickAssistRow(isAr: isAr, textColor: textColor),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _FloatingBottomNavBar(isAr: isAr),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.isAr, required this.textColor});

  final bool isAr;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final avatarBg = isLight ? Colors.white : const Color(0xFF141B2E);
    final avatarBorder = isLight ? const Color(0xFFE7E2DA) : Colors.white24;
    final avatarText = isLight ? const Color(0xFF111111) : Colors.white;
    final avatarShadow = isLight
        ? [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 4))]
        : <BoxShadow>[];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isAr ? 'أهلاً، User Name 👋' : 'Ahlan, User Name 👋',
          style: AppTextStyles.elMessiri(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(Routes.profile),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: avatarBg,
              border: Border.all(color: avatarBorder),
              boxShadow: avatarShadow,
            ),
            child: Center(
              child: Text(
                'US',
                style: AppTextStyles.mono(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: avatarText,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Live visitor counter card. The count animates through a short sequence
/// of steps once (mirrors the demo/marketing animation from the reference
/// mockup) and, once it reaches capacity, swaps the "LIVE NOW" footer for a
/// "Stadium at full capacity" state.
class _HeroVisitorsCard extends StatefulWidget {
  const _HeroVisitorsCard({
    required this.isAr,
    required this.cardBg,
    required this.textColor,
    required this.subTextColor,
    required this.borderColor,
  });

  final bool isAr;
  final Color cardBg;
  final Color textColor;
  final Color subTextColor;
  final Color borderColor;

  @override
  State<_HeroVisitorsCard> createState() => _HeroVisitorsCardState();
}

class _HeroVisitorsCardState extends State<_HeroVisitorsCard> {
  static const _steps = [39105, 39403, 39701, 40000];
  static const _stepDuration = Duration(milliseconds: 1667);

  int _stepIndex = 0;
  bool _atCapacity = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_stepDuration, (t) {
      if (_stepIndex >= _steps.length - 1) {
        t.cancel();
        setState(() => _atCapacity = true);
        return;
      }
      setState(() => _stepIndex++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final cardShadow = isLight
        ? [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 18, offset: const Offset(0, 8))]
        : <BoxShadow>[];
    final redAccent = const Color(0xFFC8102E);
    final capacityGreen = isLight ? const Color(0xFF0F6E56) : const Color(0xFF5DCAA5);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: widget.borderColor),
        boxShadow: cardShadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 2, color: redAccent),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedOpacity(
                  opacity: _atCapacity ? 0 : 1,
                  duration: const Duration(milliseconds: 400),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 5, height: 5, decoration: BoxDecoration(shape: BoxShape.circle, color: redAccent)),
                      const SizedBox(width: 5),
                      Text(
                        'LIVE',
                        style: AppTextStyles.mono(fontSize: 10, fontWeight: FontWeight.w500, color: redAccent, letterSpacing: 0.6),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _formatNumber(_steps[_stepIndex]),
                  style: AppTextStyles.elMessiri(fontSize: 30, fontWeight: FontWeight.w500, color: widget.textColor, letterSpacing: -0.5),
                ),
                Text(
                  widget.isAr ? 'الأشخاص داخل الاستاد' : 'People in the Stadium',
                  style: AppTextStyles.plexArabic(fontSize: 11, fontWeight: FontWeight.w400, color: widget.subTextColor),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: CustomPaint(painter: StadiumBowlPainter(isLight: isLight)),
                ),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: _atCapacity
                ? Padding(
                    key: const ValueKey('capacity'),
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_rounded, size: 13, color: capacityGreen),
                          const SizedBox(width: 6),
                          Text(
                            widget.isAr ? 'الاستاد ممتلئ بكامل طاقته' : 'Stadium at full capacity',
                            style: AppTextStyles.mono(fontSize: 10, fontWeight: FontWeight.w500, color: capacityGreen, letterSpacing: 0.4),
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    key: const ValueKey('live'),
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.sensors_rounded, size: 13, color: redAccent),
                          const SizedBox(width: 6),
                          Text(
                            widget.isAr ? 'مباشر الآن' : 'LIVE NOW',
                            style: AppTextStyles.mono(fontSize: 10, fontWeight: FontWeight.w500, color: redAccent, letterSpacing: 0.8),
                          ),
                          const SizedBox(width: 6),
                          Icon(Icons.sensors_rounded, size: 13, color: redAccent),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    final str = number.toString();
    final reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return str.replaceAllMapped(reg, (m) => '${m[1]},');
  }
}

/// 2x2 grid of stadium environment readings: air quality, temperature,
/// noise level, and humidity — each with a status badge.
class _EnvironmentGrid extends StatelessWidget {
  const _EnvironmentGrid({required this.isAr, required this.textColor});

  final bool isAr;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      childAspectRatio: 2.9,
      children: [
        _EnvironmentCard(
          icon: Icons.eco_rounded,
          iconColor: const Color(0xFF3FA65B),
          label: isAr ? 'جودة الهواء' : 'Air Quality',
          value: isAr ? 'مؤشر ٣٢' : 'AQI 32',
          badgeLabel: isAr ? 'جيد' : 'Good',
          badgeColor: const Color(0xFF0F6E56),
          badgeBg: const Color(0xFFE1F5EE),
          textColor: textColor,
        ),
        _EnvironmentCard(
          icon: Icons.device_thermostat_rounded,
          iconColor: const Color(0xFFF2C94C),
          label: isAr ? 'الحرارة' : 'Temperature',
          value: isAr ? '٢٤° داخل · ٢٨° خارج' : '24° in · 28° out',
          badgeLabel: isAr ? 'جيد' : 'Good',
          badgeColor: const Color(0xFF0F6E56),
          badgeBg: const Color(0xFFE1F5EE),
          textColor: textColor,
        ),
        _EnvironmentCard(
          icon: Icons.volume_up_rounded,
          iconColor: const Color(0xFF8C6FE0),
          label: isAr ? 'مستوى الضجيج' : 'Noise Level',
          value: isAr ? '٧٢ داخل · ٦٨ خارج' : '72 in · 68 out dB',
          badgeLabel: isAr ? 'متوسط' : 'Mod.',
          badgeColor: const Color(0xFF854F0B),
          badgeBg: const Color(0xFFFAEEDA),
          textColor: textColor,
        ),
        _EnvironmentCard(
          icon: Icons.water_drop_rounded,
          iconColor: const Color(0xFF2F6FED),
          label: isAr ? 'الرطوبة' : 'Humidity',
          value: isAr ? '٤٨٪ داخل · ٤٢٪ خارج' : '48% in · 42% out',
          badgeLabel: isAr ? 'جيد' : 'Good',
          badgeColor: const Color(0xFF0F6E56),
          badgeBg: const Color(0xFFE1F5EE),
          textColor: textColor,
        ),
      ],
    );
  }
}

class _EnvironmentCard extends StatelessWidget {
  const _EnvironmentCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.badgeLabel,
    required this.badgeColor,
    required this.badgeBg,
    required this.textColor,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final String badgeLabel;
  final Color badgeColor;
  final Color badgeBg;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final cardShadow = isLight
        ? [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 3))]
        : <BoxShadow>[];
    final labelColor = isLight ? const Color(0xFF8E8E8E) : Colors.white60;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isLight ? Colors.white : const Color(0xFF141B2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isLight ? const Color(0xFFE7E2DA) : Colors.white24),
        boxShadow: cardShadow,
      ),
      child: Row(
        children: [
          Icon(icon, size: 15, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: AppTextStyles.plexArabic(fontSize: 9, fontWeight: FontWeight.w400, color: labelColor)),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.plexArabic(fontSize: 11, fontWeight: FontWeight.w500, color: textColor),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(7)),
            child: Text(
              badgeLabel,
              style: AppTextStyles.plexArabic(fontSize: 8.5, fontWeight: FontWeight.w500, color: badgeColor),
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact "evening plan" summary card, sitting between the stadium
/// environment readings and Quick Assist. Shows the next stop + a live
/// countdown so the plan stays visible without needing its own tab.
///
/// NOTE: `onTap` is a placeholder toast for now. Wire it to the real
/// Trip Itinerary screen route once that screen is registered (see the
/// TODO left at the call site in HomeDashboardScreen.build).
class _EveningPlanCard extends StatelessWidget {
  const _EveningPlanCard({
    required this.isAr,
    required this.cardBg,
    required this.textColor,
    required this.subTextColor,
    required this.borderColor,
    required this.onTap,
  });

  final bool isAr;
  final Color cardBg;
  final Color textColor;
  final Color subTextColor;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final cardShadow = isLight
        ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))]
        : <BoxShadow>[];
    final redAccent = const Color(0xFFC8102E);
    final redBadgeBg = isLight ? const Color(0xFFEF6B6B).withValues(alpha: 0.14) : const Color(0xFFE63946).withValues(alpha: 0.18);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
          boxShadow: cardShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: redAccent.withValues(alpha: isLight ? 0.12 : 0.18),
              ),
              child: Icon(Icons.sports_soccer_rounded, size: 15, color: redAccent),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAr ? 'خطة المساء' : 'Your evening plan',
                    style: AppTextStyles.elMessiri(fontSize: 13, fontWeight: FontWeight.w500, color: textColor),
                  ),
                  Text(
                    isAr ? 'التالي: الأردن × إسبانيا · ٧:٠٠ م' : 'Next: Jordan vs Spain · 7:00 PM',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.plexArabic(fontSize: 11, fontWeight: FontWeight.w400, color: subTextColor),
                  ),
                  Text(
                    isAr ? 'باقي ٣ محطات الليلة' : '3 stops left tonight',
                    style: AppTextStyles.plexArabic(fontSize: 10, fontWeight: FontWeight.w400, color: subTextColor),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(color: redBadgeBg, borderRadius: BorderRadius.circular(8)),
              child: Text(
                isAr ? 'الانطلاق خلال ٤٥ د' : 'Kickoff in 45m',
                style: AppTextStyles.mono(fontSize: 9, fontWeight: FontWeight.w500, color: redAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RewardsCompactCard extends StatelessWidget {
  const _RewardsCompactCard({
    required this.isAr,
    required this.cardBg,
    required this.textColor,
    required this.subTextColor,
    required this.borderColor,
    required this.onTap,
  });

  final bool isAr;
  final Color cardBg;
  final Color textColor;
  final Color subTextColor;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFF2C94C);
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final cardShadow = isLight
        ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))]
        : <BoxShadow>[];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
          boxShadow: cardShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(shape: BoxShape.circle, color: accent.withValues(alpha: 0.14)),
              child: const Icon(Icons.emoji_events_rounded, size: 15, color: accent),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAr ? 'المكافآت' : 'Rewards',
                    style: AppTextStyles.elMessiri(fontSize: 13, fontWeight: FontWeight.w500, color: textColor),
                  ),
                  Text(
                    isAr ? '٦٨٠ نقطة · وسامان' : '680 points · 2 badges',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.plexArabic(fontSize: 11, fontWeight: FontWeight.w400, color: subTextColor),
                  ),
                ],
              ),
            ),
            Icon(
              isAr ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
              size: 16,
              color: subTextColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAssistRow extends StatelessWidget {
  const _QuickAssistRow({required this.isAr, required this.textColor});

  final bool isAr;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickAssistItem(
            icon: Icons.local_parking_rounded,
            label: isAr ? 'سيارتي' : 'Find Car',
            color: const Color(0xFF8C6FE0),
            onTap: () => Navigator.of(context).pushNamed(Routes.findMyCar),
            textColor: textColor,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: _QuickAssistItem(
            icon: Icons.navigation_rounded,
            label: isAr ? 'المسار' : 'Route',
            color: const Color(0xFF2F6FED),
            onTap: () => Navigator.of(context).pushNamed(Routes.activeRoute),
            textColor: textColor,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: _QuickAssistItem(
            icon: Icons.wc_rounded,
            label: isAr ? 'المرافق' : 'Facilities',
            color: const Color(0xFF3FA65B),
            onTap: () => _showBottomToast(context, isAr ? 'المرافق' : 'Facilities'),
            textColor: textColor,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: _QuickAssistItem(
            icon: Icons.lunch_dining_rounded,
            label: isAr ? 'الطعام' : 'Food',
            color: const Color(0xFFF2C94C),
            onTap: () => _showBottomToast(context, isAr ? 'الطعام' : 'Food'),
            textColor: textColor,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: _QuickAssistItem(
            icon: Icons.confirmation_number_rounded,
            label: isAr ? 'تذكرتي' : 'My Ticket',
            color: const Color(0xFFC8102E),
            onTap: () => _showBottomToast(context, isAr ? 'تذكرتي' : 'My Ticket'),
            textColor: textColor,
          ),
        ),
      ],
    );
  }
}

class _QuickAssistItem extends StatelessWidget {
  const _QuickAssistItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    required this.textColor,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final cardShadow = isLight
        ? [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 3))]
        : <BoxShadow>[];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 2),
        decoration: BoxDecoration(
          color: isLight ? Colors.white : const Color(0xFF141B2E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isLight ? const Color(0xFFE7E2DA) : Colors.white24),
          boxShadow: cardShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: color),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label.toUpperCase(),
                style: AppTextStyles.mono(fontSize: 6.8, fontWeight: FontWeight.w500, color: textColor, letterSpacing: 0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom nav bar with the floating SOS button in the center.
///
/// The SOS button keeps its normal single-tap behavior (opens the SOS
/// screen). A silent 5-second press-and-hold on the same button opens the
/// hidden demo controls sheet — there is deliberately NO visual feedback
/// (no color change, no ripple, no loading state) while the hold is in
/// progress, so the trigger stays invisible to anyone watching the screen.
class _FloatingBottomNavBar extends StatefulWidget {
  const _FloatingBottomNavBar({required this.isAr});

  final bool isAr;

  @override
  State<_FloatingBottomNavBar> createState() => _FloatingBottomNavBarState();
}

class _FloatingBottomNavBarState extends State<_FloatingBottomNavBar> {
  static const _holdDuration = Duration(seconds: 5);

  Timer? _holdTimer;
  bool _demoTriggered = false;

  void _onSosPressStart() {
    _demoTriggered = false;
    _holdTimer?.cancel();
    _holdTimer = Timer(_holdDuration, () {
      _demoTriggered = true;
      _EmergencySimSheet.show(context);
    });
  }

  void _onSosPressEnd() {
    _holdTimer?.cancel();
    _holdTimer = null;
  }

  void _onSosTap() {
    // A completed 5s hold already opened the demo sheet — a normal tap
    // firing right after release should not also navigate to /sos.
    if (_demoTriggered) {
      _demoTriggered = false;
      return;
    }
    Navigator.of(context).pushNamed(Routes.sos);
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAr = widget.isAr;
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final barColor = isLight ? Colors.white : const Color(0xFF0B1220);
    final itemColor = isLight ? const Color(0xFF8E8E8E) : Colors.white70;
    final barShadow = isLight
        ? [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 16, offset: const Offset(0, -6))]
        : <BoxShadow>[];
    final sosBorder = isLight ? Colors.white : Colors.white38;

    return SafeArea(
      top: false,
      child: SizedBox(
        height: 84,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 66,
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                border: Border(top: BorderSide(color: isLight ? const Color(0xFFE7E2DA) : Colors.white24)),
                boxShadow: barShadow,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _BottomNavItem(
                      icon: Icons.navigation_rounded,
                      label: isAr ? 'المسار' : 'ROUTE',
                      color: itemColor,
                      onTap: () => Navigator.of(context).pushNamed(Routes.activeRoute),
                    ),
                  ),
                  Expanded(
                    child: _BottomNavItem(
                      icon: Icons.auto_awesome_rounded,
                      label: isAr ? 'مخطط AI' : 'AI PLANNER',
                      color: itemColor,
                      onTap: () => Navigator.of(context).pushNamed(Routes.aiPlanner),
                    ),
                  ),
                  const SizedBox(width: 60),
                  Expanded(
                    child: _BottomNavItem(
                      icon: Icons.door_back_door_rounded,
                      label: isAr ? 'خروج ذكي' : 'SMART EXIT',
                      color: itemColor,
                      onTap: () => Navigator.of(context).pushNamed(Routes.smartExit),
                    ),
                  ),
                  Expanded(
                    child: _BottomNavItem(
                      icon: Icons.settings_rounded,
                      label: isAr ? 'الإعدادات' : 'SETTINGS',
                      color: itemColor,
                      onTap: () => Navigator.of(context).pushNamed(Routes.settings),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              // GestureDetector.onTapDown/onTapUp/onTapCancel is used instead
              // of onLongPress so the hold duration can be a custom 5s timer
              // with zero visual feedback while it's counting.
              child: GestureDetector(
                onTapDown: (_) => _onSosPressStart(),
                onTapUp: (_) => _onSosPressEnd(),
                onTapCancel: _onSosPressEnd,
                onTap: _onSosTap,
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFC8102E),
                    border: Border.all(color: sosBorder, width: 2),
                    boxShadow: isLight
                        ? [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 16, offset: const Offset(0, 8))]
                        : [BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 14, offset: const Offset(0, 6))],
                  ),
                  child: const Icon(Icons.gpp_maybe_rounded, color: Colors.white, size: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({required this.icon, required this.label, required this.color, required this.onTap});

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 66,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.mono(fontSize: 7, fontWeight: FontWeight.w500, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

/// Hidden demo-controls bottom sheet, opened only via the 5s SOS long-press.
///
/// Design spec (per brief, deliberately distinct from the app's normal dark
/// navy / Electric Teal identity so it visually reads as a debug/demo
/// surface, not a real screen a regular user would ever see):
///   - Font: Playfair Display
///   - Red accent: #CE1126
///   - Background: pure white (#FFFFFF)
///
/// NOTE: `onSimulateStart` is a placeholder for now. Once the
/// evacuation_screen widget is added, wire it here — e.g. push/overlay the
/// evacuation screen when the toggle switches on, and pop/dismiss it when
/// switched off.
class _EmergencySimSheet extends StatefulWidget {
  const _EmergencySimSheet();

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const _EmergencySimSheet(),
    );
  }

  @override
  State<_EmergencySimSheet> createState() => _EmergencySimSheetState();
}

class _EmergencySimSheetState extends State<_EmergencySimSheet> {
  static const _red = Color(0xFFCE1126);
  static const _playfair = 'Playfair Display';

  bool _active = false;

  void _toggle() {
    setState(() => _active = !_active);

    if (_active) {
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => EvacuationScreen(
            onExitEvacuation: () {
              if (mounted && _active) {
                setState(() => _active = false);
              }
            },
          ),
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 18),
                decoration: BoxDecoration(color: const Color(0xFFE5E5E5), borderRadius: BorderRadius.circular(4)),
              ),
            ),
            const Text(
              'DEMO CONTROLS',
              style: TextStyle(fontFamily: _playfair, fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF6E6E6E), letterSpacing: 1.2),
            ),
            const SizedBox(height: 4),
            const Text(
              'Not visible to regular users',
              style: TextStyle(fontFamily: _playfair, fontSize: 12, color: Color(0xFF9A9A9A)),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _active ? _red.withValues(alpha: 0.06) : const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _active ? _red.withValues(alpha: 0.3) : const Color(0xFFE5E5E5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _active ? _red : _red.withValues(alpha: 0.1),
                        ),
                        child: Icon(Icons.campaign_rounded, size: 18, color: _active ? Colors.white : _red),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _active ? 'Emergency broadcast active' : 'Simulate emergency broadcast',
                              style: const TextStyle(fontFamily: _playfair, fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF111111)),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _active ? 'Evacuation mode is showing on the app now' : 'Forces evacuation mode over any screen',
                              style: const TextStyle(fontFamily: _playfair, fontSize: 11.5, color: Color(0xFF7A7A7A)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (_active) ...[
                    const SizedBox(height: 12),
                    const Divider(height: 1, color: Color(0xFFF0DADC)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _PulsingDot(color: _red),
                        const SizedBox(width: 6),
                        const Text(
                          'Broadcast live on screen',
                          style: TextStyle(fontFamily: _playfair, fontSize: 12, fontWeight: FontWeight.w700, color: _red),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: _toggle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _active ? const Color(0xFF2C2C2C) : _red,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        _active ? 'Stop simulation' : 'Simulate broadcast',
                        style: const TextStyle(fontFamily: _playfair, fontSize: 13, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(color: const Color(0xFFFAFAFA), borderRadius: BorderRadius.circular(10)),
              child: const Row(
                children: [
                  Icon(Icons.info_outline_rounded, size: 14, color: Color(0xFF9A9A9A)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Tap stop anytime to instantly restore the normal screen — safe to use live during the demo.',
                      style: TextStyle(fontFamily: _playfair, fontSize: 10.5, color: Color(0xFF9A9A9A), height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  const _PulsingDot({required this.color});

  final Color color;

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 1, end: 0.25).animate(_controller),
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(shape: BoxShape.circle, color: widget.color),
      ),
    );
  }
}

void _showBottomToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message), duration: const Duration(milliseconds: 900)));
}

class StadiumBowlPainter extends CustomPainter {
  const StadiumBowlPainter({required this.isLight});

  final bool isLight;

  static const _seatGrey = Color(0xFFD9D4CC);
  static const _seatLine = Color(0xFFE6E1D9);
  static const _fieldFill = Color(0xFFF3F1ED);
  static const _fieldLine = Color(0xFFE1DDD6);
  static const _green = Color(0xFF79C77E);
  static const _yellow = Color(0xFFF2C94C);
  static const _red = Color(0xFFEF6B6B);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final outerRx = size.width * 0.49;
    final outerRy = size.height * 0.44;
    final innerRx = size.width * 0.30;
    final innerRy = size.height * 0.26;

    final outlinePaint = Paint()
      ..color = _seatLine.withValues(alpha: isLight ? 1 : 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawOval(Rect.fromCenter(center: center, width: outerRx * 2, height: outerRy * 2), outlinePaint);
    canvas.drawOval(Rect.fromCenter(center: center, width: innerRx * 2.15, height: innerRy * 2.15), outlinePaint);

    _paintField(canvas, center, Size(innerRx * 2.05, innerRy * 1.55));
    _paintSeats(canvas, center, outerRx, outerRy, innerRx, innerRy);
  }

  void _paintField(Canvas canvas, Offset center, Size fieldSize) {
    final fieldRect = Rect.fromCenter(center: center, width: fieldSize.width, height: fieldSize.height);
    final field = RRect.fromRectAndRadius(fieldRect, Radius.circular(fieldRect.height * 0.22));

    canvas.drawRRect(field, Paint()..color = _fieldFill.withValues(alpha: isLight ? 1 : 0.16));
    canvas.drawRRect(
      field,
      Paint()
        ..color = _fieldLine.withValues(alpha: isLight ? 1 : 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    final linePaint = Paint()
      ..color = _fieldLine.withValues(alpha: isLight ? 1 : 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawLine(Offset(fieldRect.center.dx, fieldRect.top), Offset(fieldRect.center.dx, fieldRect.bottom), linePaint);
    canvas.drawCircle(fieldRect.center, fieldRect.height * 0.18, linePaint);
    canvas.drawCircle(fieldRect.center, 1.4, Paint()..color = _fieldLine.withValues(alpha: isLight ? 1 : 0.45));

    final boxW = fieldRect.width * 0.18;
    final boxH = fieldRect.height * 0.48;
    final leftBox = RRect.fromRectAndRadius(
      Rect.fromLTWH(fieldRect.left, fieldRect.center.dy - boxH / 2, boxW, boxH),
      Radius.circular(fieldRect.height * 0.08),
    );
    final rightBox = RRect.fromRectAndRadius(
      Rect.fromLTWH(fieldRect.right - boxW, fieldRect.center.dy - boxH / 2, boxW, boxH),
      Radius.circular(fieldRect.height * 0.08),
    );
    canvas.drawRRect(leftBox, linePaint);
    canvas.drawRRect(rightBox, linePaint);
  }

  void _paintSeats(Canvas canvas, Offset center, double outerRx, double outerRy, double innerRx, double innerRy) {
    const rings = 7;
    const seats = 70;

    for (int ring = 0; ring < rings; ring++) {
      final t = ring / (rings - 1);
      final rx = outerRx - (outerRx - innerRx) * (0.18 + t * 0.82);
      final ry = outerRy - (outerRy - innerRy) * (0.18 + t * 0.82);

      for (int i = 0; i < seats; i++) {
        final angle = (2 * math.pi * i) / seats;
        final p = Offset(center.dx + rx * math.cos(angle), center.dy + ry * math.sin(angle));
        final c = _seatColorForAngle(angle, ring);

        final seatW = 2.6 - ring * 0.14;
        final seatH = 1.3 - ring * 0.08;

        canvas.save();
        canvas.translate(p.dx, p.dy);
        canvas.rotate(angle);
        final rect = Rect.fromCenter(center: Offset.zero, width: seatW, height: seatH);
        canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(0.6)), Paint()..color = c);
        canvas.restore();
      }
    }
  }

  Color _seatColorForAngle(double angle, int ring) {
    final a = angle % (2 * math.pi);
    final base = switch (a) {
      < 1.10 => _red,
      < 2.05 => _yellow,
      < 3.35 => _green,
      > 5.15 => _red,
      _ => _seatGrey,
    };

    final depth = (ring / 7) * 0.20;
    final alpha = isLight ? (0.92 - depth) : (0.30 - depth).clamp(0.10, 0.26);
    return base.withValues(alpha: alpha);
  }

  @override
  bool shouldRepaint(covariant StadiumBowlPainter oldDelegate) => oldDelegate.isLight != isLight;
}