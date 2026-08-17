import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/app_scope.dart';
import '../models/i18n.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_field.dart';
import '../widgets/buttons.dart';
import '../widgets/misc_widgets.dart';
import '../widgets/screen_chrome.dart';

// NEW: which kind of ID document the user is registering with.
enum _IdType { national, passport }

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

  // NEW: defaults to national ID; user can switch to passport via the toggle.
  _IdType _idType = _IdType.national;

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
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

    if (fullName.isEmpty || idNumber.isEmpty || dob.isEmpty || mobile.isEmpty ||
        email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return _msg(scope,
        en: 'Please fill in all fields.',
        ar: 'الرجاء تعبئة جميع الحقول.',
      );
    }

    // NEW: validation branches by the selected ID type.
    if (_idType == _IdType.national) {
      if (!RegExp(r'^\d{10}$').hasMatch(idNumber)) {
        return _msg(scope,
          en: 'National ID must be exactly 10 digits.',
          ar: 'رقم الهوية الوطنية يجب أن يتكون من 10 أرقام بالضبط.',
        );
      }
    } else {
      if (!RegExp(r'^[A-Za-z0-9]{6,9}$').hasMatch(idNumber)) {
        return _msg(scope,
          en: 'Passport number must be 6-9 letters/digits.',
          ar: 'رقم جواز السفر يجب أن يتكون من 6 إلى 9 أحرف أو أرقام.',
        );
      }
    }

    if (!_isValidEmail(email)) {
      return _msg(scope,
        en: 'Please enter a valid email address.',
        ar: 'الرجاء إدخال بريد إلكتروني صالح.',
      );
    }
    if (password.length < 8 ||
        !RegExp(r'[A-Z]').hasMatch(password) ||
        !RegExp(r'[0-9]').hasMatch(password)) {
      return _msg(scope,
        en: 'Password must be at least 8 characters and include an uppercase letter and a number.',
        ar: 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل، وتحتوي على حرف كبير ورقم.',
      );
    }
    if (password != confirmPassword) {
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
        // NEW: idType records which document the number belongs to.
        'idType': _idType == _IdType.national ? 'national' : 'passport',
        'nationalId': _nationalIdCtrl.text.trim(),
        'dateOfBirth': _dobCtrl.text.trim(),
        'mobile': _mobileCtrl.text.trim(),
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        Navigator.of(context).pushReplacementNamed(Routes.binding);
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

  // NEW: small segmented toggle (National ID / Passport), styled with the
  // same tokens AppField already uses (paper background, stone-line border,
  // primary color for the active segment) so it matches the existing look.
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
        Padding(padding: const EdgeInsets.only(top: 6, bottom: 22), child: Text(scope.t('caSub'), style: AppTextStyles.hSub.copyWith(color: AppColors.inkSoftOf(context)))),
        AppField(label: scope.t('lblFullName'), controller: _fullNameCtrl),
        _buildIdTypeToggle(scope),
        AppField(label: idLabel, mono: true, controller: _nationalIdCtrl),
        AppField(
          label: scope.t('lblDob'),
          placeholder: scope.t('phDob'),
          controller: _dobCtrl,
          readOnly: true,
          onTap: _pickDob,
        ),
        AppField(label: scope.t('lblMobile'), mono: true, controller: _mobileCtrl),
        AppField(label: scope.t('lblEmail'), controller: _emailCtrl, hint: scope.t('hintEmail')),
        AppField(label: scope.t('lblPassword'), obscure: true, controller: _passwordCtrl),
        AppField(label: scope.t('lblConfirmPassword'), obscure: true, controller: _confirmPasswordCtrl),
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 12),
            child: Text(
              _errorMessage!,
              style: AppTextStyles.fieldHint.copyWith(color: Theme.of(context).colorScheme.error),
            ),
          ),
      ],
      bottomChildren: [
        PrimaryButton(
          label: _isLoading
              ? _msg(scope, en: 'Creating account…', ar: 'جارٍ إنشاء الحساب…')
              : scope.t('caCreateBtn'),
          onTap: _isLoading ? null : _submit,
          enabled: !_isLoading,
        ),
      ],
    );
  }
}