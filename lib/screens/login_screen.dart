import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/app_scope.dart';
import '../models/i18n.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
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

  // NEW: per-field empty-on-submit flags, drive the red border on AppField.
  bool _emailHasError = false;
  bool _passwordHasError = false;

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

    // NEW: flag each empty required field independently so both can turn
    // red together (not just whichever the message text talks about).
    final emailEmpty = email.isEmpty;
    final passwordEmpty = password.isEmpty;
    setState(() {
      _emailHasError = emailEmpty;
      _passwordHasError = passwordEmpty;
    });

    if (emailEmpty || passwordEmpty) {
      return _msg(scope,
        en: 'Please enter your email and password.',
        ar: 'الرجاء إدخال البريد الإلكتروني وكلمة المرور.',
      );
    }
    if (!_isValidEmail(email)) {
      // NEW: invalid (but non-empty) email also gets flagged red.
      setState(() { _emailHasError = true; });
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
      HapticFeedback.mediumImpact();
      return;
    }

    setState(() { _isLoading = true; });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      );

      HapticFeedback.lightImpact();

      if (mounted) {
        Navigator.of(context).pushReplacementNamed(Routes.homeDashboard);
      }
    } catch (e) {
      if (mounted) {
        setState(() { _errorMessage = _mapError(scope, e); });
        HapticFeedback.mediumImpact();
      }
    } finally {
      if (mounted) {
        setState(() { _isLoading = false; });
      }
    }
  }

  void _openForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (_) => _ForgotPasswordDialog(initialEmail: _emailCtrl.text.trim()),
    );
  }

  // NEW: same unified error banner style as create_account_screen.
  Widget _buildErrorBanner(BuildContext context) {
    if (_errorMessage == null) return const SizedBox.shrink();
    final errorColor = Theme.of(context).colorScheme.error;
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: errorColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          border: Border.all(color: errorColor.withValues(alpha: 0.3), width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.error_outline_rounded, size: 18, color: errorColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _errorMessage!,
                style: AppTextStyles.fieldHint.copyWith(color: errorColor),
              ),
            ),
          ],
        ),
      ),
    );
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
                  AppField(
                    label: scope.t('lblEmail'),
                    required: true,
                    // NEW: gray placeholder shown when empty, disappears on typing.
                    placeholder: 'user@gmail.com',
                    hasError: _emailHasError,
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    // NEW: clear the red border as soon as the user starts fixing it.
                    onChanged: (_) {
                      if (_emailHasError) setState(() { _emailHasError = false; });
                    },
                  ),
                  AppField(
                    label: scope.t('lblPassword'),
                    required: true,
                    obscure: true,
                    hasError: _passwordHasError,
                    controller: _passwordCtrl,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.password],
                    onSubmitted: (_) => _isLoading ? null : _submit(),
                    // NEW: clear the red border as soon as the user starts fixing it.
                    onChanged: (_) {
                      if (_passwordHasError) setState(() { _passwordHasError = false; });
                    },
                  ),
                  _buildErrorBanner(context),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: GhostButton(
                      label: scope.t('forgotPassword'),
                      fontSize: 13,
                      onTap: _openForgotPasswordDialog,
                    ),
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
                  icon: _isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : null,
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

class _ForgotPasswordDialog extends StatefulWidget {
  const _ForgotPasswordDialog({required this.initialEmail});
  final String initialEmail;

  @override
  State<_ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<_ForgotPasswordDialog> {
  late final TextEditingController _emailCtrl = TextEditingController(text: widget.initialEmail);

  bool _isLoading = false;
  String? _errorMessage;
  bool _sent = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  String _msg(LocaleController scope, {required String en, required String ar}) {
    return scope.isArabic ? ar : en;
  }

  bool _isValidEmail(String email) {
    final re = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    return re.hasMatch(email.trim());
  }

  String _mapError(LocaleController scope, Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'invalid-email':
          return _msg(scope,
            en: 'Please enter a valid email address.',
            ar: 'الرجاء إدخال بريد إلكتروني صالح.',
          );
        case 'user-not-found':
          return _msg(scope,
            en: 'No account found with this email.',
            ar: 'لا يوجد حساب مسجل بهذا البريد.',
          );
        case 'too-many-requests':
          return _msg(scope,
            en: 'Too many attempts. Please try again later.',
            ar: 'عدد محاولات كبير جداً. حاول مرة أخرى لاحقاً.',
          );
        case 'network-request-failed':
          return _msg(scope,
            en: 'Network error. Please check your connection and try again.',
            ar: 'خطأ في الشبكة. تحقق من الاتصال وحاول مرة أخرى.',
          );
        default:
          return _msg(scope,
            en: 'Something went wrong: ${e.message ?? e.code}',
            ar: 'حدث خطأ ما: ${e.message ?? e.code}',
          );
      }
    }
    return _msg(scope, en: 'Something went wrong. Please try again.', ar: 'حدث خطأ ما. حاول مرة أخرى.');
  }

  Future<void> _sendResetLink(LocaleController scope) async {
    final email = _emailCtrl.text.trim();
    setState(() { _errorMessage = null; });

    if (email.isEmpty || !_isValidEmail(email)) {
      setState(() {
        _errorMessage = _msg(scope,
          en: 'Please enter a valid email address.',
          ar: 'الرجاء إدخال بريد إلكتروني صالح.',
        );
      });
      HapticFeedback.mediumImpact();
      return;
    }

    setState(() { _isLoading = true; });
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (mounted) {
        HapticFeedback.lightImpact();
        setState(() {
          _sent = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = _mapError(scope, e);
          _isLoading = false;
        });
        HapticFeedback.mediumImpact();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);

    return Dialog(
      backgroundColor: AppColors.pageBgOf(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusMd)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _msg(scope, en: 'Reset Password', ar: 'إعادة تعيين كلمة المرور'),
              style: AppTextStyles.hTitle(color: AppColors.voidOf(context)).copyWith(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              _sent
                  ? _msg(scope,
                      en: 'Check your inbox — a password reset link has been sent to your email.',
                      ar: 'تحقق من بريدك — تم إرسال رابط إعادة تعيين كلمة المرور إلى إيميلك.',
                    )
                  : _msg(scope,
                      en: 'Enter your account email and we\'ll send you a reset link.',
                      ar: 'أدخل بريد حسابك وسنرسل لك رابط إعادة التعيين.',
                    ),
              style: AppTextStyles.hSub.copyWith(color: AppColors.inkSoftOf(context)),
            ),
            const SizedBox(height: 16),
            if (!_sent) ...[
              AppField(
                label: scope.t('lblEmail'),
                placeholder: 'user@gmail.com',
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _isLoading ? null : _sendResetLink(scope),
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    _errorMessage!,
                    style: AppTextStyles.fieldHint.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              PrimaryButton(
                label: _isLoading
                    ? _msg(scope, en: 'Sending…', ar: 'جارٍ الإرسال…')
                    : _msg(scope, en: 'Send Reset Link', ar: 'إرسال رابط إعادة التعيين'),
                icon: _isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : null,
                onTap: _isLoading ? null : () => _sendResetLink(scope),
                enabled: !_isLoading,
              ),
              const SizedBox(height: 8),
              GhostButtonBlock(
                label: _msg(scope, en: 'Cancel', ar: 'إلغاء'),
                onTap: () => Navigator.of(context).pop(),
              ),
            ] else ...[
              PrimaryButton(
                label: _msg(scope, en: 'Done', ar: 'تم'),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}