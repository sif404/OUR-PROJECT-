import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'models/app_scope.dart';
import 'models/groups_scope.dart';
import 'models/i18n.dart';
import 'routes.dart';
import 'providers/theme_controller.dart';
import 'theme/app_theme_data.dart';
import 'onboarding/splash_screen.dart';
import 'onboarding/onboarding_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/method_screen.dart';
import 'screens/qr_screen.dart';
import 'screens/manual_screen.dart';
import 'screens/manual_code_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/create_account_screen.dart';
import 'screens/binding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/smart_exit_screen.dart';
import 'screens/sos_screen.dart';
import 'screens/sos_confirmation_screen.dart';
import 'screens/safty_dev_screen.dart';
import 'screens/child_consent_gate.dart';
import 'screens/create_group_flow_screen.dart';
import 'screens/family_account_consent_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/active_route_screen.dart';
import 'screens/rewards_screen.dart' as rewards;
import 'screens/settings_screen.dart';
import 'screens/trip_screen.dart';
import 'screens/ai_planner_screen.dart' as ai_planner;
import 'screens/find_my_car_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final controller = await ThemeController.load();
  // Apply the correct status bar / system chrome style BEFORE the very first
  // render frame so the splash screen never flashes white.
  final resolvedBrightness =
      controller.mode == AxnThemeMode.system ? PlatformDispatcher.instance.platformBrightness
      : controller.mode == AxnThemeMode.dark ? Brightness.dark
      : Brightness.light;
  final overlayStyle = resolvedBrightness == Brightness.dark
      ? SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: const Color(0xFF121212),
          systemNavigationBarIconBrightness: Brightness.light,
        )
      : SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        );
  SystemChrome.setSystemUIOverlayStyle(overlayStyle);
  runApp(
    ProviderScope(
      overrides: [
        themeControllerProvider.overrideWith((ref) => controller),
      ],
      child: AxnApp(themeController: controller),
    ),
  );
}

class AxnApp extends ConsumerStatefulWidget {
  const AxnApp({super.key, required this.themeController});

  final ThemeController themeController;

  @override
  ConsumerState<AxnApp> createState() => _AxnAppState();
}

class _AxnAppState extends ConsumerState<AxnApp> {
  late final LocaleController _locale;
  final GroupsController _groups = GroupsController();

  @override
  void initState() {
    super.initState();
    _locale = LocaleController()..setLang(widget.themeController.languageCode);
  }

  @override
  void dispose() {
    _locale.dispose();
    _groups.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ThemeController>(themeControllerProvider, (previous, next) {
      if (_locale.lang != next.languageCode) {
        _locale.setLang(next.languageCode);
      }
    });
    final themeCtrl = ref.watch(themeControllerProvider);
    return GroupsScope(
      controller: _groups,
      child: AppScope(
        controller: _locale,
        child: AnimatedBuilder(
          animation: Listenable.merge([themeCtrl, _locale]),
          builder: (context, _) {
            return MaterialApp(
              title: 'AXN — Ticket Activation',
              debugShowCheckedModeBanner: false,
              theme: AppThemeData.light(isArabic: _locale.isArabic),
              darkTheme: AppThemeData.dark(isArabic: _locale.isArabic),
              themeMode: themeCtrl.themeMode,
              locale: Locale(_locale.lang),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              localeResolutionCallback: (deviceLocale, supported) {
                if (themeCtrl.languageCode == 'en' || themeCtrl.languageCode == 'ar') {
                  return Locale(themeCtrl.languageCode);
                }
                if (deviceLocale != null) {
                  for (final s in supported) {
                    if (s.languageCode == deviceLocale.languageCode) return s;
                  }
                }
                return const Locale('en');
              },
              builder: (context, child) {
                return Directionality(textDirection: _locale.direction, child: child!);
              },
              initialRoute: Routes.splash,
              onGenerateRoute: (settings) {
                final builders = <String, WidgetBuilder>{
                  Routes.splash: (_) => const SplashScreen(),
                  Routes.onboarding: (_) => const OnboardingScreen(),
                  Routes.welcome: (_) => const WelcomeScreen(),
                  Routes.method: (_) => const MethodScreen(),
                  Routes.qr: (_) => const QrScreen(),
                  Routes.manual: (_) => const ManualScreen(),
                  Routes.manualCode: (_) => const ManualCodeScreen(),
                  Routes.otp: (_) => const OtpScreen(),
                  Routes.createAccount: (_) => const CreateAccountScreen(),
                  Routes.binding: (_) => const BindingScreen(),
                  Routes.login: (_) => const LoginScreen(),
                  Routes.homeDashboard: (_) => const HomeDashboardScreen(),
                  Routes.smartExit: (_) => const SmartExitScreen(),
                  Routes.sos: (_) => const SosScreen(),
                  Routes.sosConfirmation: (context) => ConfirmationScreen(
                    onBack: () => Navigator.of(context).pop(),
                    onFinished: () => Navigator.of(context).pop(),
                  ),
                  Routes.childSafety: (context) => ChildConsentGate(
                    childBuilder: (context) => ChildSafetyPage(
                      onClose: () => Navigator.of(context).pop(),
                      onEmergencyAlert: () => Navigator.of(context).pushNamed(Routes.childAlert),
                    ),
                  ),
                  Routes.childAlert: (context) => ChildConsentGate(
                    childBuilder: (context) {
                      final cs = Theme.of(context).colorScheme;
                      return Scaffold(
                        backgroundColor: cs.surface,
                        appBar: AppBar(
                          backgroundColor: cs.surface,
                          surfaceTintColor: Colors.transparent,
                          leading: IconButton(
                            onPressed: () => Navigator.of(context).maybePop(),
                            icon: const Icon(Icons.arrow_back_rounded),
                          ),
                        ),
                        body: SafeArea(
                          top: false,
                          child: ChildAlertPage(
                            initialStatus: ChildAlertStatus.active,
                            onNavigateAway: (_) => Navigator.of(context).maybePop(),
                          ),
                        ),
                      );
                    },
                  ),
                  Routes.familyConsent: (_) => const FamilyAccountConsentPage(),
                  Routes.createGroupFlow: (context) {
                    final groups = GroupsScope.of(context);
                    return CreateGroupFlowScreen(groups: groups);
                  },
                  Routes.tripScreen: (_) => const EveningPlanScreen(),
                  Routes.rewards: (_) => const rewards.RewardsPage(),
                  Routes.aiPlanner: (_) => const ai_planner.AIPlannerScreen(),
                  Routes.findMyCar: (_) => const FindMyCarScreen(),
                  Routes.activeRoute: (_) => const ActiveRouteScreen(),
                  Routes.profile: (context) {
                    final groups = GroupsScope.of(context);
                    final args = ModalRoute.of(context)?.settings.arguments;
                    final highlightCreateGroup = args is Map && args['highlightCreateGroup'] == true;
                    final scrollToMyGroups = args is Map && args['scrollToMyGroups'] == true;
                    return AnimatedBuilder(
                      animation: groups,
                      builder: (context, _) => ProfileScreen(
                        groups: groups.groups,
                        onBack: () => Navigator.of(context).maybePop(),
                        onOpenSettings: () => Navigator.of(context).pushNamed(Routes.settings),
                        onCreateGroup: () => Navigator.of(context).pushNamed(Routes.createGroupFlow),
                        onLogout: () async {
                          await FirebaseAuth.instance.signOut();
                          if (context.mounted) {
                            Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (_) => false);
                          }
                        },
                        highlightCreateGroup: highlightCreateGroup,
                        scrollToMyGroups: scrollToMyGroups,
                      ),
                    );
                  },
                  Routes.settings: (context) => SettingsScreen(
                    onBack: () => Navigator.of(context).maybePop(),
                  ),
                };
                final builder = builders[settings.name] ?? builders[Routes.splash]!;
                return AxnPageRoute(builder: builder, settings: settings);
              },
            );
          },
        ),
      ),
    );
  }
}

/// Mirrors `.screen{ opacity:0; transform:translateX(24px); transition:
/// opacity .38s ease, transform .38s ease } .screen.active{ opacity:1;
/// transform:translateX(0) }` — incoming screen fades in while sliding
/// in from the trailing edge.
class AxnPageRoute extends PageRouteBuilder {
  AxnPageRoute({required WidgetBuilder builder, required super.settings})
      : super(
          transitionDuration: const Duration(milliseconds: 380),
          reverseTransitionDuration: const Duration(milliseconds: 380),
          pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0.03, 0), end: Offset.zero).animate(curved),
                child: child,
              ),
            );
          },
        );
}
