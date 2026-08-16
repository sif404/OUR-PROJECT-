import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/app_scope.dart';
import '../models/i18n.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_field.dart';
import '../widgets/buttons.dart';
import '../widgets/screen_chrome.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  String _msg(LocaleController scope, {required String en, required String ar}) {
    return scope.isArabic ? ar : en;
  }

  bool _isValidEmail(String email) {
    final re = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    return re.hasMatch(email.trim());
  }

  String? _validate(LocaleController scope) {
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;

    if (email.isEmpty || password.isEmpty) {
      return _msg(scope,
        en: 'Please enter your email and password.',
        ar: 'الرجاء إدخال البريد الإلكتروني وكلمة المرور.',
      );
    }
    if (!_isValidEmail(email)) {
      return _msg(scope,
        en: 'Please enter a valid email address.',
        ar: 'الرجاء إدخال بريد إلكتروني صالح.',
      );
    }
    return null;
  }

  String _mapError(LocaleController scope, Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'invalid-email':
          return _msg(scope,
            en: 'Please enter a valid email address.',
            ar: 'الرجاء إدخال بريد إلكتروني صالح.',
          );
        case 'user-disabled':
          return _msg(scope,
            en: 'This account has been disabled. Please contact support.',
            ar: 'هذا الحساب معطل. يرجى الاتصال بالدعم.',
          );
        case 'user-not-found':
          return _msg(scope,
            en: 'No account found with this email. Try creating an account instead.',
            ar: 'لا يوجد حساب مسجل بهذا البريد. حاول إنشاء حساب جديد.',
          );
        case 'wrong-password':
          return _msg(scope,
            en: 'Incorrect password. Please try again.',
            ar: 'كلمة المرور غير صحيحة. حاول مرة أخرى.',
          );
        case 'invalid-credential':
          return _msg(scope,
            en: 'Invalid email or password. Please check and try again.',
            ar: 'البريد أو كلمة المرور غير صحيحة. تحقق وحاول مرة أخرى.',
          );
        case 'network-request-failed':
          return _msg(scope,
            en: 'Network error. Please check your connection and try again.',
            ar: 'خطأ في الشبكة. تحقق من الاتصال وحاول مرة أخرى.',
          );
        case 'too-many-requests':
          return _msg(scope,
            en: 'Too many attempts. Please try again later.',
            ar: 'عدد محاولات كبير جداً. حاول مرة أخرى لاحقاً.',
          );
        default:
          return _msg(scope,
            en: 'Login failed: ${e.message ?? e.code}',
            ar: 'فشل تسجيل الدخول: ${e.message ?? e.code}',
          );
      }
    }
    return _msg(scope,
      en: 'Something went wrong. Please try again.',
      ar: 'حدث خطأ ما. حاول مرة أخرى.',
    );
  }

  Future<void> _submit() async {
    final scope = AppScope.of(context);
    setState(() { _errorMessage = null; });

    final validationError = _validate(scope);
    if (validationError != null) {
      setState(() { _errorMessage = validationError; });
      return;
    }

    setState(() { _isLoading = true; });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      );

      if (mounted) {
        Navigator.of(context).pushReplacementNamed(Routes.homeDashboard);
      }
    } catch (e) {
      if (mounted) {
        setState(() { _errorMessage = _mapError(scope, e); });
      }
    } finally {
      if (mounted) {
        setState(() { _isLoading = false; });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final isLight = Theme.of(context).brightness == Brightness.light;
    void goTo(String route) => Navigator.of(context).pushReplacementNamed(route);

    return Scaffold(
      backgroundColor: AppColors.pageBgOf(context),
      body: Column(
        children: [
          // .topbar with back-btn + two 38px spacers (no step dots)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 56, 24, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton38(onTap: () => goTo(Routes.welcome)),
                const SizedBox(width: 38, height: 38),
                const SizedBox(width: 38, height: 38),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 30, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // gold-crest badge on a dark gradient rounded square
                  Container(
                    width: 52,
                    height: 52,
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.gold),
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: isLight
                            ? const [AppColors.void_, Color(0xFF2A2116)]
                            : const [Color(0xFF2A2A2A), Color(0xFF1A1A1A)],
                      ),
                    ),
                    child: const Icon(Icons.star_rounded, size: 26, color: AppColors.gold),
                  ),
                  Text(scope.t('loginTitle'), style: AppTextStyles.hTitle(color: AppColors.voidOf(context))),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 22),
                    child: Text(scope.t('loginSub'), style: AppTextStyles.hSub.copyWith(color: AppColors.inkSoftOf(context))),
                  ),
                  AppField(label: scope.t('lblEmail'), controller: _emailCtrl),
                  AppField(label: scope.t('lblPassword'), obscure: true, controller: _passwordCtrl),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 12),
                      child: Text(
                        _errorMessage!,
                        style: AppTextStyles.fieldHint.copyWith(color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: GhostButton(label: scope.t('forgotPassword'), fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 24, 0),
            child: Column(
              children: [
                PrimaryButton(
                  label: _isLoading
                      ? _msg(scope, en: 'Signing in…', ar: 'جارٍ تسجيل الدخول…')
                      : scope.t('loginBtn'),
                  onTap: _isLoading ? null : _submit,
                  enabled: !_isLoading,
                ),
                GhostButtonBlock(label: scope.t('noAccountBtn'), onTap: () => goTo(Routes.welcome), topMargin: 10),
              ],
            ),
          ),
          const SkylineBackdrop(),
        ],
      ),
    );
  }
}
