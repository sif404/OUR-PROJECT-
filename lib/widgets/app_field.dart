import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// .field { margin-bottom:16px } containing a mono uppercase label,
/// a paper-bg bordered input (ember border + white bg on focus), and an
/// optional .hint line below.
class AppField extends StatefulWidget {
  const AppField({
    super.key,
    required this.label,
    this.placeholder,
    this.hint,
    this.mono = false,
    this.obscure = false,
    this.controller,
    this.initialValue,
    this.readOnlyValueColor,
    this.readOnly = false,
    this.onTap,
  });

  final String label;
  final String? placeholder;
  final String? hint;
  final bool mono;
  final bool obscure;
  final TextEditingController? controller;
  final String? initialValue;
  /// If set, renders a static (non-editable-looking) value in this color,
  /// matching the pre-filled email field: `color:var(--ink-soft)`.
  final Color? readOnlyValueColor;
  /// When true, disables manual keyboard input — used for fields whose
  /// value is set programmatically (e.g. a date picked from a calendar).
  final bool readOnly;
  /// Called when the field is tapped. Combined with [readOnly] to open a
  /// picker (date, etc.) instead of the keyboard, without changing the
  /// field's visual style.
  final VoidCallback? onTap;

  @override
  State<AppField> createState() => _AppFieldState();
}

class _AppFieldState extends State<AppField> {
  final FocusNode _focus = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() => _focused = _focus.hasFocus));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textStyle = (widget.mono ? AppTextStyles.fieldInputMono : AppTextStyles.fieldInput)
        .copyWith(color: widget.readOnlyValueColor ?? AppColors.voidOf(context));

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label.toUpperCase(), style: AppTextStyles.fieldLabel.copyWith(color: AppColors.inkSoftOf(context))),
          const SizedBox(height: 7),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: _focused ? AppColors.surf(context) : AppColors.paperOf(context),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _focused ? cs.primary : AppColors.stoneLineOf(context),
                width: 1.6,
              ),
            ),
            child: TextField(
              controller: widget.controller,
              focusNode: _focus,
              obscureText: widget.obscure,
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              style: textStyle,
              cursorColor: cs.primary,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 14),
                hintText: widget.placeholder,
                hintStyle: textStyle.copyWith(color: AppColors.inkSoftOf(context).withValues(alpha: 0.6)),
              ),
            ),
          ),
          if (widget.hint != null) ...[
            const SizedBox(height: 6),
            Text(widget.hint!, style: AppTextStyles.fieldHint.copyWith(color: AppColors.inkSoftOf(context))),
          ],
        ],
      ),
    );
  }
}

/// A field pre-filled with a static, non-interactive value (used for the
/// email field on Create Account, which is filled in automatically).
class AppFieldStatic extends StatelessWidget {
  const AppFieldStatic({super.key, required this.label, required this.value, this.hint});
  final String label;
  final String value;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: AppTextStyles.fieldLabel.copyWith(color: AppColors.inkSoftOf(context))),
          const SizedBox(height: 7),
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.paperOf(context),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.stoneLineOf(context), width: 1.6),
            ),
            child: Text(value, style: AppTextStyles.fieldInput.copyWith(color: AppColors.inkSoftOf(context))),
          ),
          if (hint != null) ...[
            const SizedBox(height: 6),
            Text(hint!, style: AppTextStyles.fieldHint.copyWith(color: AppColors.inkSoftOf(context))),
          ],
        ],
      ),
    );
  }
}