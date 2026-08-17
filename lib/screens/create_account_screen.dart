import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/app_scope.dart';
import '../models/i18n.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_field.dart';
import '../widgets/buttons.dart';
import '../widgets/misc_widgets.dart';
import '../widgets/screen_chrome.dart';

enum _IdType { national, passport }
enum _PasswordStrength { empty, weak, medium, strong }

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _fullNameCtrl = TextEditingController();
  final _nationalIdCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  _IdType _idType = _IdType.national;

  bool _isLoading = false;
  String? _errorMessage;

  // NEW: per-field empty/invalid-on-submit flags, drive the red border
  // on each AppField.
  bool _fullNameHasError = false;
  bool _idNumberHasError = false;
  bool _dobHasError = false;
  bool _mobileHasError = false;
  bool _emailHasError = false;
  bool _passwordHasError = false;
  bool _confirmPasswordHasError = false;

  @override
  void initState() {
    super.initState();
    _passwordCtrl.addListener(_onPasswordChanged);
  }

  void _onPasswordChanged() => setState(() {});

  @override
  void dispose() {
    _passwordCtrl.removeListener(_onPasswordChanged);
    _fullNameCtrl.dispose();
    _nationalIdCtrl.dispose();
    _dobCtrl.dispose();
    _mobileCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  String _msg(LocaleController scope, {required String en, required String ar}) {
    return scope.isArabic ? ar : en;
  }

  bool _isValidEmail(String email) {
    final re = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    return re.hasMatch(email.trim());
  }

  _PasswordStrength _passwordStrength(String password) {
    if (password.isEmpty) return _PasswordStrength.empty;
    int score = 0;
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]').hasMatch(password)) score++;
    if (score <= 2) return _PasswordStrength.weak;
    if (score <= 3) return _PasswordStrength.medium;
    return _PasswordStrength.strong;
  }

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _dobCtrl.text = DateFormat('dd/MM/yyyy').format(picked);
        // NEW: clear the red border once a date is actually picked.
        _dobHasError = false;
      });
    }
  }

  String? _validate(LocaleController scope) {
    final fullName = _fullNameCtrl.text.trim();
    final idNumber = _nationalIdCtrl.text.trim();
    final dob = _dobCtrl.text.trim();
    final mobile = _mobileCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;
    final confirmPassword = _confirmPasswordCtrl.text;

    // NEW: flag every empty required field independently so they all turn
    // red together, not just whichever one the message text mentions.
    setState(() {
      _fullNameHasError = fullName.isEmpty;
      _idNumberHasError = idNumber.isEmpty;
      _dobHasError = dob.isEmpty;
      _mobileHasError = mobile.isEmpty;
      _emailHasError = email.isEmpty;
      _passwordHasError = password.isEmpty;
      _confirmPasswordHasError = confirmPassword.isEmpty;
    });

    if (fullName.isEmpty || idNumber.isEmpty || dob.isEmpty || mobile.isEmpty ||
        email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return _msg(scope,
        en: 'Please fill in all fields.',
        ar: 'الرجاء تعبئة جميع الحقول.',
      );
    }

    if (_idType == _IdType.national) {
      if (!RegExp(r'^\d{10}$').hasMatch(idNumber)) {
        // NEW: invalid (but non-empty) ID also gets flagged red.
        setState(() { _idNumberHasError = true; });
        return _msg(scope,
          en: 'National ID must be exactly 10 digits.',
          ar: 'رقم الهوية الوطنية يجب أن يتكون من 10 أرقام بالضبط.',
        );
      }
    } else {
      if (!RegExp(r'^[A-Za-z0-9]{6,9}$').hasMatch(idNumber)) {
        setState(() { _idNumberHasError = true; });
        return _msg(scope,
          en: 'Passport number must be 6-9 letters/digits.',
          ar: 'رقم جواز السفر يجب أن يتكون من 6 إلى 9 أحرف أو أرقام.',
        );
      }
    }

    if (!_isValidEmail(email)) {
      setState(() { _emailHasError = true; });
      return _msg(scope,
        en: 'Please enter a valid email address.',
        ar: 'الرجاء إدخال بريد إلكتروني صالح.',
      );
    }
    if (password.length < 8 ||
        !RegExp(r'[A-Z]').hasMatch(password) ||
        !RegExp(r'[0-9]').hasMatch(password)) {
      setState(() { _passwordHasError = true; });
      return _msg(scope,
        en: 'Password must be at least 8 characters and include an uppercase letter and a number.',
        ar: 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل، وتحتوي على حرف كبير ورقم.',
      );
    }
    if (password != confirmPassword) {
      setState(() { _confirmPasswordHasError = true; });
      return _msg(scope,
        en: 'Passwords do not match.',
        ar: 'كلمتا المرور غير متطابقتين.',
      );
    }
    return null;
  }

  String _mapError(LocaleController scope, Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'email-already-in-use':
          return _msg(scope,
            en: 'This email is already registered. Try logging in instead.',
            ar: 'هذا البريد مسجل بالفعل. حاول تسجيل الدخول بدلاً من ذلك.',
          );
        case 'invalid-email':
          return _msg(scope,
            en: 'Please enter a valid email address.',
            ar: 'الرجاء إدخال بريد إلكتروني صالح.',
          );
        case 'operation-not-allowed':
          return _msg(scope,
            en: 'Email/password sign-in is not enabled.',
            ar: 'تسجيل الدخول بالبريد وكلمة المرور غير مفعل.',
          );
        case 'weak-password':
          return _msg(scope,
            en: 'Password is too weak. Please use a stronger password.',
            ar: 'كلمة المرور ضعيفة جداً. يرجى استخدام كلمة أقوى.',
          );
        case 'network-request-failed':
          return _msg(scope,
            en: 'Network error. Please check your connection and try again.',
            ar: 'خطأ في الشبكة. تحقق من الاتصال وحاول مرة أخرى.',
          );
        default:
          return _msg(scope,
            en: 'Sign up failed: ${e.message ?? e.code}',
            ar: 'فشل إنشاء الحساب: ${e.message ?? e.code}',
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
      // NEW: two short buzzes on validation failure.
      HapticFeedback.mediumImpact();
      return;
    }

    setState(() { _isLoading = true; });
    try {
      final email = _emailCtrl.text.trim();
      final password = _passwordCtrl.text;
      final userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password,
      );
      final uid = userCred.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'fullName': _fullNameCtrl.text.trim(),
        'idType': _idType == _IdType.national ? 'national' : 'passport',
        'nationalId': _nationalIdCtrl.text.trim(),
        'dateOfBirth': _dobCtrl.text.trim(),
        'mobile': _mobileCtrl.text.trim(),
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // NEW: light success buzz right before navigating away.
      HapticFeedback.lightImpact();

      if (mounted) {
        Navigator.of(context).pushReplacementNamed(Routes.binding);
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

  Widget _buildIdTypeToggle(LocaleController scope) {
    final cs = Theme.of(context).colorScheme;

    Widget segment(String label, _IdType type) {
      final selected = _idType == type;
      return Expanded(
        child: GestureDetector(
          onTap: () {
            if (_idType != type) {
              setState(() {
                _idType = type;
                _nationalIdCtrl.clear();
              });
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: selected ? cs.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(11),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: AppTextStyles.fieldLabel.copyWith(
                color: selected ? cs.onPrimary : AppColors.inkSoftOf(context),
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: AppColors.paperOf(context),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.stoneLineOf(context), width: 1.6),
        ),
        child: Row(
          children: [
            segment(_msg(scope, en: 'National ID', ar: 'هوية وطنية'), _IdType.national),
            segment(_msg(scope, en: 'Passport', ar: 'جواز سفر'), _IdType.passport),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordStrengthMeter(LocaleController scope) {
    final strength = _passwordStrength(_passwordCtrl.text);
    if (strength == _PasswordStrength.empty) return const SizedBox.shrink();

    final int filledSegments = switch (strength) {
      _PasswordStrength.empty => 0,
      _PasswordStrength.weak => 1,
      _PasswordStrength.medium => 2,
      _PasswordStrength.strong => 4,
    };
    final Color activeColor = switch (strength) {
      _PasswordStrength.weak => const Color(0xFFE5484D),
      _PasswordStrength.medium => const Color(0xFFE8A33D),
      _PasswordStrength.strong => const Color(0xFF3CB56B),
      _PasswordStrength.empty => Colors.transparent,
    };
    final String label = switch (strength) {
      _PasswordStrength.weak => _msg(scope, en: 'Weak', ar: 'ضعيفة'),
      _PasswordStrength.medium => _msg(scope, en: 'Medium', ar: 'متوسطة'),
      _PasswordStrength.strong => _msg(scope, en: 'Strong', ar: 'قوية'),
      _PasswordStrength.empty => '',
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(4, (i) {
              final filled = i < filledSegments;
              return Expanded(
                child: Container(
                  margin: EdgeInsetsDirectional.only(end: i == 3 ? 0 : 4),
                  height: 4,
                  decoration: BoxDecoration(
                    color: filled ? activeColor : AppColors.stoneLineOf(context),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.fieldHint.copyWith(color: activeColor)),
        ],
      ),
    );
  }

  // NEW: unified error banner — small warning icon + tinted red background,
  // instead of a plain line of red text easy to miss.
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
    void goTo(String route) => Navigator.of(context).pushReplacementNamed(route);

    final idLabel = _idType == _IdType.national
        ? scope.t('lblNationalId')
        : _msg(scope, en: 'Passport Number', ar: 'رقم جواز السفر');

    return StandardScreenScaffold(
      onBack: () => goTo(Routes.otp),
      activeStep: 3,
      bodyChildren: [
        Eyebrow(text: scope.t('caEyebrow')),
        Text(scope.t('caTitle'), style: AppTextStyles.hTitle(color: AppColors.voidOf(context))),
        Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 22),
          child: Text(scope.t('caSub'), style: AppTextStyles.hSub.copyWith(color: AppColors.inkSoftOf(context))),
        ),
        AppField(
          label: scope.t('lblFullName'),
          required: true,
          hasError: _fullNameHasError,
          controller: _fullNameCtrl,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.name],
          onChanged: (_) {
            if (_fullNameHasError) setState(() { _fullNameHasError = false; });
          },
        ),
        _buildIdTypeToggle(scope),
        AppField(
          label: idLabel,
          required: true,
          mono: true,
          hasError: _idNumberHasError,
          controller: _nationalIdCtrl,
          keyboardType: _idType == _IdType.national ? TextInputType.number : TextInputType.text,
          textInputAction: TextInputAction.next,
          onChanged: (_) {
            if (_idNumberHasError) setState(() { _idNumberHasError = false; });
          },
        ),
        AppField(
          label: scope.t('lblDob'),
          required: true,
          placeholder: scope.t('phDob'),
          hasError: _dobHasError,
          controller: _dobCtrl,
          readOnly: true,
          onTap: _pickDob,
        ),
        AppField(
          label: scope.t('lblMobile'),
          required: true,
          mono: true,
          hasError: _mobileHasError,
          controller: _mobileCtrl,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.telephoneNumber],
          onChanged: (_) {
            if (_mobileHasError) setState(() { _mobileHasError = false; });
          },
        ),
        AppField(
          label: scope.t('lblEmail'),
          required: true,
          hasError: _emailHasError,
          controller: _emailCtrl,
          // NEW: gray placeholder shown when empty, disappears on typing.
          placeholder: 'user@gmail.com',
          hint: scope.t('hintEmail'),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
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
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.newPassword],
          onChanged: (_) {
            if (_passwordHasError) setState(() { _passwordHasError = false; });
          },
        ),
        _buildPasswordStrengthMeter(scope),
        AppField(
          label: scope.t('lblConfirmPassword'),
          required: true,
          obscure: true,
          hasError: _confirmPasswordHasError,
          controller: _confirmPasswordCtrl,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.newPassword],
          onChanged: (_) {
            if (_confirmPasswordHasError) setState(() { _confirmPasswordHasError = false; });
          },
        ),
        _buildErrorBanner(context),
      ],
      bottomChildren: [
        PrimaryButton(
          // NEW: small spinner alongside the label while loading.
          label: _isLoading
              ? _msg(scope, en: 'Creating account…', ar: 'جارٍ إنشاء الحساب…')
              : scope.t('caCreateBtn'),
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
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _msg(scope, en: 'Already have an account? ', ar: 'لديك حساب بالفعل؟ '),
              style: AppTextStyles.fieldLabel.copyWith(
                color: AppColors.inkSoftOf(context),
              ),
            ),
            GestureDetector(
              onTap: () => goTo(Routes.login),
              child: Text(
                _msg(scope, en: 'Log in', ar: 'تسجيل الدخول'),
                style: AppTextStyles.fieldLabel.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}