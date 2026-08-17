import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';

class _TapScale extends StatefulWidget {
  const _TapScale({required this.onTap, required this.child, this.enabled = true});
  final VoidCallback? onTap;
  final Widget child;
  final bool enabled;

  @override
  State<_TapScale> createState() => _TapScaleState();
}

class _TapScaleState extends State<_TapScale> {
  double _scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.enabled ? (_) => setState(() => _scale = 0.97) : null,
      onTapUp: widget.enabled ? (_) => setState(() => _scale = 1) : null,
      onTapCancel: widget.enabled ? () => setState(() => _scale = 1) : null,
      onTap: widget.enabled ? widget.onTap : null,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, this.onTap, this.enabled = true, this.icon});
  final String label;
  final VoidCallback? onTap;
  final bool enabled;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;
    return _TapScale(
      enabled: enabled,
      onTap: onTap,
      child: Opacity(
        opacity: enabled ? 1 : AppColors.disabledPrimaryOpacity,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: cs.primary,
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            boxShadow: enabled && isLight ? AppDimens.shadowBtnPrimary : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 8)],
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.btn(color: cs.onPrimary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OutlineButton extends StatefulWidget {
  const OutlineButton({super.key, required this.label, this.onTap, this.nudgeTrigger = 0});
  final String label;
  final VoidCallback? onTap;
  final int nudgeTrigger;

  @override
  State<OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<OutlineButton> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100));
    _pulse = TweenSequence<double>([
      TweenSequenceItem<double>(tween: Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: Curves.easeInOut)), weight: 50),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 1, end: 0).chain(CurveTween(curve: Curves.easeInOut)), weight: 50),
    ]).animate(_ctrl);
  }

  @override
  void didUpdateWidget(covariant OutlineButton old) {
    super.didUpdateWidget(old);
    if (widget.nudgeTrigger != old.nudgeTrigger) {
      _ctrl.forward(from: 0).then((_) => _ctrl.forward(from: 0));
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _TapScale(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (context, child) {
          final glow = _pulse.value;
          return Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              border: Border.all(
                color: Color.lerp(cs.outline, cs.primary, glow)!,
                width: 1.6,
              ),
              boxShadow: glow > 0
                  ? [BoxShadow(color: AppColors.emberTintOf(context).withValues(alpha: glow), blurRadius: 0, spreadRadius: 6 * glow)]
                  : null,
            ),
            child: Text(
              widget.label,
              textAlign: TextAlign.center,
              style: AppTextStyles.btn(color: cs.primary),
            ),
          );
        },
      ),
    );
  }
}

class TealButton extends StatelessWidget {
  const TealButton({super.key, required this.label, this.onTap});
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;
    return _TapScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: cs.secondary,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          boxShadow: isLight ? AppDimens.shadowBtnTeal : null,
        ),
        child: Text(label, textAlign: TextAlign.center, style: AppTextStyles.btn(color: cs.onSecondary)),
      ),
    );
  }
}

class GhostButton extends StatelessWidget {
  const GhostButton({super.key, required this.label, this.onTap, this.fontSize = 13, this.centered = false});
  final String label;
  final VoidCallback? onTap;
  final double fontSize;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          label,
          textAlign: centered ? TextAlign.center : null,
          style: AppTextStyles.btnGhost(fontSize: fontSize).copyWith(color: cs.primary),
        ),
      ),
    );
  }
}

class GhostButtonBlock extends StatelessWidget {
  const GhostButtonBlock({super.key, required this.label, this.onTap, this.topMargin = 8});
  final String label;
  final VoidCallback? onTap;
  final double topMargin;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsetsDirectional.only(top: topMargin),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Text(label, textAlign: TextAlign.center, style: AppTextStyles.btnGhost(fontSize: 13).copyWith(color: cs.primary)),
      ),
    );
  }
}
