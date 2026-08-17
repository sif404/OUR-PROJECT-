import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_scope.dart';

/// ============================================================
/// AXN Safety — Emergency Confirmation Screen (single-file version)
/// ------------------------------------------------------------
/// Part of the SOS flow: shown after the user holds the SOS button
/// on the main SOS screen. Everything (colors, countdown ring, type
/// banner, location card, responding-service card, actions, and the
/// sending/success/failed panels) lives in this one file.
///
/// Brand:
///   Font          : Playfair Display
///   Main red      : #CE1126
///   Background    : #FFFFFF (pure white)
/// ============================================================

class ConfirmationScreen extends StatefulWidget {
  /// Called when the back button is tapped. If null, does nothing.
  final VoidCallback? onBack;

  /// Called once the success panel's "Done" button is tapped, or the
  /// failed panel's "Call operations center" action is tapped.
  final VoidCallback? onFinished;

  /// When true, the next send attempt will resolve to the failed panel
  /// instead of success — mirrors the original prototype's demo hook.
  final bool simulateFailureOnNextSend;

  const ConfirmationScreen({
    super.key,
    this.onBack,
    this.onFinished,
    this.simulateFailureOnNextSend = false,
  });

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

enum _Panel { confirm, sending, success, failed }

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  // ---------------------------------------------------------
  // Brand tokens
  // ---------------------------------------------------------
  static const Color red = Color(0xFFCE1126); // main red
  static const Color redGlow = Color(0x38CE1126); // rgba(206,17,38,.22)
  static const Color background = Color(0xFFFFFFFF); // pure white

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surface2 = Color(0xFFF2F2F3);
  static const Color surfaceChip = Color(0xFFF4F4F5);

  static const Color border = Color(0xFFEAEAEC);
  static const Color borderStrong = Color(0xFFDCDCDF);

  static const Color ink = Color(0xFF222226);
  static const Color inkSoft = Color(0xFF3A3A3F);
  static const Color muted = Color(0xFF6B7280);
  static const Color muted2 = Color(0xFF8A8F98);

  static const Color safe = Color(0xFF4CAF6D);

  static const double radiusLg = 20;
  static const double radiusMd = 14;

  static TextStyle font({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  // ---------------------------------------------------------
  // Static content (mirrors the SOS screen's selected request)
  // ---------------------------------------------------------
  static const int countdownSeconds = 6;

  // ---------------------------------------------------------
  // State
  // ---------------------------------------------------------
  _Panel _panel = _Panel.confirm;

  Timer? _countdownTimer;
  int _secondsRemaining = countdownSeconds;
  bool _countdownCancelled = false;
  bool _confirmEnabled = true;

  int _doneSteps = 0;
  int _activeStep = -1;

  late bool _willFail = widget.simulateFailureOnNextSend;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  double get _countdownProgress => 1 - (_secondsRemaining / countdownSeconds);

  void _startCountdown() {
    _countdownCancelled = false;
    setState(() => _secondsRemaining = countdownSeconds);

    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() => _secondsRemaining = 0);
        if (!_countdownCancelled) _sendNow();
        return;
      }
      setState(() => _secondsRemaining -= 1);
    });
  }

  void _cancelRequest() {
    final scope = AppScope.of(context);
    _countdownCancelled = true;
    _countdownTimer?.cancel();
    setState(() => _confirmEnabled = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(scope.t('sos_cancelledToast'), style: font(fontSize: 13)),
        backgroundColor: inkSoft,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1600),
      ),
    );

    Future.delayed(const Duration(milliseconds: 1600), () {
      if (!mounted) return;
      setState(() => _confirmEnabled = true);
      _startCountdown();
    });
  }

  void _sendNow() {
    _countdownCancelled = true;
    _countdownTimer?.cancel();
    setState(() {
      _panel = _Panel.sending;
      _doneSteps = 0;
      _activeStep = -1;
    });
    _runSendSteps();
  }

  Future<void> _runSendSteps() async {
    setState(() => _activeStep = 0);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() {
      _doneSteps = 1;
      _activeStep = 1;
    });

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() {
      _doneSteps = 2;
      _activeStep = 2;
    });

    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() {
      _doneSteps = 3;
      _activeStep = -1;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    if (_willFail) {
      setState(() {
        _willFail = false;
        _panel = _Panel.failed;
      });
    } else {
      setState(() => _panel = _Panel.success);
    }
  }

  void _retrySend() {
    setState(() {
      _panel = _Panel.sending;
      _doneSteps = 0;
      _activeStep = -1;
    });
    _runSendSteps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: switch (_panel) {
          _Panel.confirm => _buildConfirmPanel(),
          _Panel.sending => _buildSendingPanel(),
          _Panel.success => _buildSuccessPanel(),
          _Panel.failed => _buildFailedPanel(),
        },
      ),
    );
  }

  // ===========================================================
  // Panel 1 — Confirm
  // ===========================================================
  Widget _buildConfirmPanel() {
    final scope = AppScope.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTopBar(),
          _buildTypeBanner(),
          _buildCountdownRing(),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 8),
            child: _sectionLabel(scope.t('sos_locationSectionLabel')),
          ),
          _buildLocationCard(),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 8),
            child: _sectionLabel(scope.t('sos_serviceSectionLabel')),
          ),
          _buildServiceCard(),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    final scope = AppScope.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 18, 20, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            color: surfaceChip,
            shape: const CircleBorder(side: BorderSide(color: border)),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: widget.onBack,
              child: const SizedBox(
                width: 38,
                height: 38,
                child: Icon(Icons.arrow_back, size: 20, color: inkSoft),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scope.t('sos_topbarTitle'),
                  style: font(
                      fontSize: 15, fontWeight: FontWeight.w700, color: ink),
                ),
                const SizedBox(height: 1),
                Text(
                  scope.t('sos_topbarSubtitle'),
                  style: font(fontSize: 11, color: muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeBanner() {
    final scope = AppScope.of(context);
    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(20, 14, 20, 0),
      padding: const EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(
        color: red.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: red.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.medical_services_outlined, size: 24, color: red),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scope.t('sos_typeName'),
                  style: font(
                      fontSize: 16, fontWeight: FontWeight.w700, color: ink),
                ),
                const SizedBox(height: 2),
                Text(
                  scope.t('sos_typeDescription'),
                  style: font(fontSize: 11.5, color: muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownRing() {
    final scope = AppScope.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 26, 20, 8),
      child: Column(
        children: [
          SizedBox(
            width: 168,
            height: 168,
            child: Stack(
              alignment: Alignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: _countdownProgress),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                  builder: (context, value, _) {
                    return CustomPaint(
                      size: const Size(168, 168),
                      painter: _CountdownPainter(progress: value, red: red, track: surface2),
                    );
                  },
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _countdownCancelled && _secondsRemaining == 0
                          ? '—'
                          : '$_secondsRemaining',
                      style: font(
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        color: ink,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      scope.t('sos_countdownLabel'),
                      style: font(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: muted,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Text.rich(
              TextSpan(
                style: font(fontSize: 11.5, color: muted, height: 1.6),
                children: [
                  TextSpan(
                    text: scope.t('sos_countdownAutoPrefix'),
                    style: font(fontWeight: FontWeight.w600, color: inkSoft),
                  ),
                  TextSpan(text: scope.t('sos_countdownHint')),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
    final scope = AppScope.of(context);
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D14141E),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: surface2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(double.infinity, 100),
                  painter: _DiamondGridPainter(),
                ),
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: red.withValues(alpha: 0.12),
                  ),
                ),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: red,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scope.t('sos_locationLabel').toUpperCase(),
                      style: font(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: muted,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      scope.t('sos_locationValue'),
                      style: font(
                          fontSize: 13, fontWeight: FontWeight.w600, color: ink),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: safe.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: safe.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.gps_fixed, size: 16, color: safe),
                      const SizedBox(width: 5),
                      Text(
                        scope.t('sos_gpsAccuracy'),
                        style: font(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: safe,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard() {
    final scope = AppScope.of(context);
    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D14141E),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.local_hospital_outlined, size: 20, color: red),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scope.t('sos_serviceName'),
                  style: font(
                      fontSize: 13, fontWeight: FontWeight.w600, color: inkSoft),
                ),
                const SizedBox(height: 2),
                Text(
                  scope.t('sos_serviceMeta'),
                  style: font(fontSize: 11, color: muted),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: surfaceChip,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  scope.t('sos_serviceEta'),
                  style: font(
                      fontSize: 14, fontWeight: FontWeight.w700, color: ink),
                ),
                Text(scope.t('sos_eta'), style: font(fontSize: 9, color: muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    final scope = AppScope.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 18, 20, 0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: _confirmEnabled ? 1 : 0.5,
                  child: Material(
                    color: red,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: _confirmEnabled ? _sendNow : null,
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: redGlow,
                              blurRadius: 16,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check, size: 20, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              scope.t('sos_confirmButtonLabel'),
                              style: font(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Material(
                  color: surfaceChip,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: _cancelRequest,
                    child: Container(
                      height: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderStrong),
                      ),
                      child: Text(
                        scope.t('sos_cancelButtonLabel'),
                        style: font(
                            fontSize: 14, fontWeight: FontWeight.w600, color: inkSoft),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(28, 12, 28, 20),
          child: Text(
            scope.t('sos_safetyNote'),
            textAlign: TextAlign.center,
            style: font(fontSize: 10.5, color: muted2, height: 1.6),
          ),
        ),
      ],
    );
  }

  // ===========================================================
  // Panel 2 — Sending
  // ===========================================================
  Widget _buildSendingPanel() {
    final scope = AppScope.of(context);
    final sendSteps = [
      scope.t('sos_sendStep1'),
      scope.t('sos_sendStep2'),
      scope.t('sos_sendStep3'),
    ];
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 28, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 64,
              height: 64,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: red,
                backgroundColor: Color(0x26CE1126),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              scope.t('sos_sendingTitle'),
              style: font(fontSize: 18, fontWeight: FontWeight.w700, color: ink),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: Text(
                scope.t('sos_sendingSubtitle'),
                textAlign: TextAlign.center,
                style: font(fontSize: 12.5, color: muted, height: 1.6),
              ),
            ),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < sendSteps.length; i++) ...[
                    _sendStepRow(
                      label: sendSteps[i],
                      done: i < _doneSteps,
                      active: i == _activeStep,
                    ),
                    if (i != sendSteps.length - 1) const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sendStepRow({required String label, required bool done, required bool active}) {
    final color = done ? inkSoft : muted2;
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 18,
          height: 18,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: done ? safe : Colors.transparent,
            border: Border.all(
              color: done ? safe : (active ? red : muted2),
              width: 1.5,
            ),
          ),
          child: done ? const Icon(Icons.check, size: 10, color: Colors.white) : null,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(label, style: font(fontSize: 12.5, color: color)),
        ),
      ],
    );
  }

  // ===========================================================
  // Panel 3 — Success
  // ===========================================================
  Widget _buildSuccessPanel() {
    final scope = AppScope.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 28, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              margin: const EdgeInsetsDirectional.only(bottom: 20),
              decoration: BoxDecoration(
                color: safe.withValues(alpha: 0.12),
                shape: BoxShape.circle,
                border: Border.all(color: safe.withValues(alpha: 0.35)),
              ),
              child: const Icon(Icons.check, size: 30, color: safe),
            ),
            Text(
              scope.t('sos_successTitle'),
              style: font(fontSize: 18, fontWeight: FontWeight.w700, color: ink),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: Text(
                scope.t('sos_successSubtitle'),
                textAlign: TextAlign.center,
                style: font(fontSize: 12.5, color: muted, height: 1.6),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 22),
                child: Row(
                  children: [
                    Expanded(child: _etaBox(scope.t('sos_successEtaValue'), scope.t('sos_successEtaLabel'))),
                    const SizedBox(width: 10),
                    Expanded(child: _etaBox(scope.t('sos_successNearestValue'), scope.t('sos_successNearestLabel'))),
                  ],
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 28),
                child: SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: surfaceChip,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => widget.onFinished?.call(),
                      child: Container(
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: borderStrong),
                        ),
                        child: Text(
                          scope.t('sos_successDoneLabel'),
                          style: font(
                              fontSize: 14, fontWeight: FontWeight.w600, color: inkSoft),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _etaBox(String value, String label) {
    return Container(
      padding: const EdgeInsetsDirectional.all(14),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: border),
      ),
      child: Column(
        children: [
          Text(value,
              style: font(fontSize: 18, fontWeight: FontWeight.w700, color: ink)),
          const SizedBox(height: 3),
          Text(label, style: font(fontSize: 10, color: muted)),
        ],
      ),
    );
  }

  // ===========================================================
  // Panel 4 — Failed
  // ===========================================================
  Widget _buildFailedPanel() {
    final scope = AppScope.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 28, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              margin: const EdgeInsetsDirectional.only(bottom: 20),
              decoration: BoxDecoration(
                color: red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: red.withValues(alpha: 0.3)),
              ),
              child: const Icon(Icons.error_outline, size: 30, color: red),
            ),
            Text(
              scope.t('sos_failedTitle'),
              style: font(fontSize: 18, fontWeight: FontWeight.w700, color: ink),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: Text(
                scope.t('sos_failedSubtitle'),
                textAlign: TextAlign.center,
                style: font(fontSize: 12.5, color: muted, height: 1.6),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 28),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Material(
                        color: red,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: _retrySend,
                          child: Container(
                            height: 56,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.refresh, size: 20, color: Colors.white),
                                const SizedBox(width: 8),
                                Text(
                                  scope.t('sos_failedRetryLabel'),
                                  style: font(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Material(
                        color: surfaceChip,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => widget.onFinished?.call(),
                          child: Container(
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: borderStrong),
                            ),
                            child: Text(
                              scope.t('sos_failedCallLabel'),
                              style: font(
                                  fontSize: 14, fontWeight: FontWeight.w600, color: inkSoft),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: font(
        fontSize: 11.5,
        color: muted,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }
}

// ================================================================
// Painters
// ================================================================

class _CountdownPainter extends CustomPainter {
  final double progress; // 0 = full ring, 1 = fully depleted
  final Color red;
  final Color track;
  const _CountdownPainter({required this.progress, required this.red, required this.track});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 8.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = track
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    final fgPaint = Paint()
      ..color = red
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * (1 - progress);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CountdownPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _DiamondGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x0D000000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const step = 24.0;
    for (double x = -step; x < size.width + step; x += step) {
      for (double y = -step; y < size.height + step; y += step) {
        final path = Path()
          ..moveTo(x + step / 2, y)
          ..lineTo(x + step, y + step / 2)
          ..lineTo(x + step / 2, y + step)
          ..lineTo(x, y + step / 2)
          ..close();
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
