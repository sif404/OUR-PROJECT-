import 'package:flutter/material.dart';
import '../models/app_scope.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import '../widgets/buttons.dart';
import '../widgets/crest.dart';
import '../widgets/misc_widgets.dart';
import '../widgets/screen_chrome.dart';
import '../widgets/welcome_header.dart';

/// SCREEN 1 — WELCOME. The highest-fidelity target screen: crest, city
/// label, stadium title, tagline, ticket image, CTA stack, minor links row,
/// guest note — all pinned above the bottom-anchored skyline silhouette.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _nudgeTrigger = 0;

  void _goTo(String route) => Navigator.of(context).pushReplacementNamed(route);

  void _nudgeCreateAccount() => setState(() => _nudgeTrigger++);

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: AppColors.pageBgOf(context),
      body: Stack(
        children: [
          // .screen background(white) + pinned skyline + scrollable content
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 54, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // .hero-mark
                      const SizedBox(height: 6),
                      const Crest(),
                      const SizedBox(height: 14),
                      Text(scope.t('city'), style: AppTextStyles.cityName.copyWith(color: cs.primary), textAlign: TextAlign.center),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 270,
                        child: Text(
                          scope.t('stadium'),
                          style: AppTextStyles.stadiumName.copyWith(color: AppColors.voidOf(context)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 240,
                        child: Text(
                          scope.t('tagline'),
                          style: AppTextStyles.tagline.copyWith(color: AppColors.inkSoftOf(context)),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // .hero-mark{margin-bottom:10px} + .bottom{padding-top:10px} (both
                      // additive, not collapsing, since .bottom has non-zero padding) +
                      // .ticket-img{margin-top:4px} = 24px total gap before the ticket art.
                      const SizedBox(height: 20),

                      // .ticket-img — 1030:515 aspect (~2:1), radius-lg, shadow-card
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 24),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                            boxShadow: AppDimens.shadowCard,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: AspectRatio(
                            aspectRatio: 1030 / 515,
                            child: Image.asset('assets/images/ticket_card.png', fit: BoxFit.cover),
                          ),
                        ),
                      ),

                      // .cta-stack
                      PrimaryButton(label: scope.t('ctaTicket'), onTap: () => _goTo(Routes.method)),
                      const SizedBox(height: 14),
                      OutlineButton(
                        label: scope.t('ctaCreate'),
                        nudgeTrigger: _nudgeTrigger,
                        onTap: () => _goTo(Routes.createAccount),
                      ),

                      // .minor-row
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            GhostButton(label: scope.t('ctaLogin'), fontSize: 12.5, onTap: () => _goTo(Routes.login)),
                            Padding(
                              padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                              child: Text(scope.t('welcome_pipe'), style: TextStyle(color: AppColors.stoneLineOf(context), fontSize: 12.5)),
                            ),
                            GestureDetector(
                              onTap: _nudgeCreateAccount,
                              child: Text(
                                scope.t('ctaGuest'),
                                style: AppTextStyles.guestLink.copyWith(
                                  color: AppColors.inkSoftOf(context),
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.dotted,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      GuestNote(text: scope.t('guestNote')),
                    ],
                  ),
                ),
              ),
              const SkylineBackdrop(),
            ],
          ),

          // absolutely-positioned header: lang toggle + bell + notif panel
          const WelcomeHeader(),
        ],
      ),
    );
  }
}
