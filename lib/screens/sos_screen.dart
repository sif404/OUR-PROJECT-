import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_scope.dart';
import '../models/groups_scope.dart';
import '../routes.dart';
import 'evacuation_screen.dart';
import 'safty_dev_screen.dart';
import 'family_account_consent_screen.dart';

/// ============================================================
/// AXN Safety — SOS Screen (single-file version)
/// ------------------------------------------------------------
/// Everything the SOS screen needs (colors, hold button, service
/// grid, location card, contacts list, confirm sheet, dispatch/
/// success sheet) lives in this one file so it can be dropped
/// into a project as-is.
///
/// Brand:
///   Font          : Playfair Display
///   Main red      : #CE1126
///   Background    : #FFFFFF (pure white)
/// ============================================================

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  // ---------------------------------------------------------
  // Brand tokens
  // ---------------------------------------------------------
  static const Color red = Color(0xFFCE1126); // main red
  static const Color redDeep = Color(0xFF8E0C1D);
  static const Color redGlow = Color(0x33CE1126); // rgba(206,17,38,.20)
  static const Color background = Color(0xFFFFFFFF); // pure white

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surface2 = Color(0xFFF4F4F5);
  static const Color surfaceChip = Color(0xFFF0F0F1);

  static const Color border = Color(0x17141416);
  static const Color borderStrong = Color(0x29141416);

  static const Color ink = Color(0xFF1E1F22);
  static const Color inkSoft = Color(0xFF33353A);
  static const Color muted = Color(0xFF6B6E76);
  static const Color muted2 = Color(0xFF9297A0);

  static const Color safe = Color(0xFF3F9D6E);

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
  // Content
  // ---------------------------------------------------------
  static const Duration holdDuration = Duration(seconds: 6);

  static const List<_Service> _services = [
    _Service(id: 'police', name: 'sosHome_serviceNamePolice', icon: Icons.shield_outlined),
    _Service(
        id: 'ambulance',
        name: 'sosHome_serviceNameAmbulance',
        icon: Icons.local_hospital_outlined),
    _Service(
        id: 'civil-defense',
        name: 'sosHome_serviceNameCivilDefense',
        icon: Icons.shield_moon_outlined),
    _Service(
        id: 'medical',
        name: 'sosHome_serviceNameMedical',
        icon: Icons.medical_services_outlined),
    _Service(
        id: 'child-safety',
        name: 'sosHome_serviceNameChildSafety',
        icon: Icons.escalator_warning),
    _Service(id: 'lost-person', name: 'sosHome_serviceNameLostPerson', icon: Icons.search),
  ];

  static const List<_Contact> _contacts = [
    _Contact(
      id: 'c1',
      name: 'sosHome_contact1Name',
      role: 'sosHome_contact1Role',
      initials: 'SO',
    ),
    _Contact(
      id: 'c2',
      name: 'sosHome_contact2Name',
      role: 'sosHome_contact2Role',
      initials: 'MR',
    ),
    _Contact(
      id: 'c3',
      name: 'sosHome_contact3Name',
      role: 'sosHome_contact3Role',
      initials: 'EC',
    ),
  ];

  String? _selectedServiceId;
  bool _shareLocation = true;

  void _onHoldComplete() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EvacuationScreen(
          onExitEvacuation: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  void _showSettingsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0xB3050408),
      builder: (sheetContext) => _SosSettingsSheet(
        shareEnabled: _shareLocation,
        onShareChanged: (v) => setState(() => _shareLocation = v),
        onClose: () => Navigator.of(sheetContext).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 140),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: Column(
                  children: [
                    Center(
                      child: _HoldButton(
                        holdDuration: holdDuration,
                        onHoldComplete: _onHoldComplete,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 40),
                      child: Text.rich(
                        TextSpan(
                          style: font(fontSize: 11.5, color: muted),
                          children: [
                            TextSpan(
                              text: AppScope.of(context).t('sosHome_holdPrefix'),
                              style: font(
                                fontWeight: FontWeight.w600,
                                color: inkSoft,
                              ),
                            ),
                            TextSpan(
                              text: AppScope.of(context).t(
                                'sosHome_holdInstructions',
                                {'seconds': '${holdDuration.inSeconds}'},
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                child: _sectionLabel(AppScope.of(context).t('sosHome_servicesLabel')),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2.4,
                  children: _services.map((service) {
                    return _ServiceCard(
                      service: service,
                      selected: _selectedServiceId == service.id,
                      onTap: () async {
                        if (service.id == 'child-safety') {
                          final groups = GroupsScope.of(context);
                          final rootNav = Navigator.of(context, rootNavigator: true);
                          if (groups.hasFamilyConsent) {
                            rootNav.push(
                              MaterialPageRoute(
                                builder: (_) => ChildSafetyPage(
                                  onClose: () => rootNav.maybePop(),
                                  onEmergencyAlert: () => rootNav.pushNamed(Routes.childAlert),
                                ),
                              ),
                            );
                            return;
                          }
                          final accepted = await rootNav.push<bool>(
                            MaterialPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (_) => const FamilyAccountConsentPage(),
                            ),
                          );
                          if (accepted != true) return;
                          groups.grantFamilyConsent();
                          rootNav.push(
                            MaterialPageRoute(
                              builder: (_) => ChildSafetyPage(
                                onClose: () => rootNav.maybePop(),
                                onEmergencyAlert: () => rootNav.pushNamed(Routes.childAlert),
                              ),
                            ),
                          );
                          return;
                        }
                        setState(() => _selectedServiceId = service.id);
                      },
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 22, 20, 10),
                child: _sectionLabel(AppScope.of(context).t('sosHome_locationLabel')),
              ),
              _LocationCard(
                label: AppScope.of(context).t('sosHome_detectedLocationLabel'),
                value: AppScope.of(context).t('sosHome_locationValue'),
                gpsAccuracy: AppScope.of(context).t('sosHome_gpsAccuracy'),
                shareTitle: AppScope.of(context).t('sosHome_shareLiveLocation'),
                shareSubtitle: AppScope.of(context).t('sosHome_shareSubtitle'),
                shareEnabled: _shareLocation,
                onShareChanged: (v) => setState(() => _shareLocation = v),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 22, 20, 10),
                child: _sectionLabel(AppScope.of(context).t('sosHome_contactsLabel')),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    for (int i = 0; i < _contacts.length; i++) ...[
                      _ContactRow(contact: _contacts[i], onCall: () {}),
                      if (i != _contacts.length - 1) const SizedBox(height: 8),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                color: surfaceChip,
                shape: const CircleBorder(side: BorderSide(color: border)),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => Navigator.of(context).maybePop(),
                  child: const SizedBox(
                    width: 38,
                    height: 38,
                    child: Icon(Icons.arrow_back_rounded, size: 20, color: muted),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: safe.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: safe.withValues(alpha: 0.35)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: safe,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          AppScope.of(context).t('sosHome_allSystemsNormal'),
                          style: font(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: safe,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                color: surfaceChip,
                shape: const CircleBorder(side: BorderSide(color: border)),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _showSettingsSheet,
                  child: const SizedBox(
                    width: 38,
                    height: 38,
                    child: Icon(Icons.settings_outlined, size: 20, color: muted),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            AppScope.of(context).t('sosHome_title'),
            style: font(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
              color: ink,
            ),
          ),
          const SizedBox(height: 4),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Text(
              AppScope.of(context).t('sosHome_subtitle'),
              style: font(fontSize: 13, color: muted, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: font(
        fontSize: 12,
        color: muted,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
      ),
    );
  }
}

// ================================================================
// Models
// ================================================================

class _Service {
  final String id;
  /// ARB translation key (not literal text) — resolved via `scope.t()`
  /// at render time in [_ServiceCard].
  final String name;
  final IconData icon;
  const _Service({required this.id, required this.name, required this.icon});
}

class _Contact {
  final String id;
  /// ARB translation keys (not literal text) — resolved via `scope.t()`
  /// at render time in [_ContactRow].
  final String name;
  final String role;
  final String initials;
  const _Contact({
    required this.id,
    required this.name,
    required this.role,
    required this.initials,
  });
}

// ================================================================
// Service card
// ================================================================

class _ServiceCard extends StatelessWidget {
  final _Service service;
  final bool selected;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.service,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const red = _SosScreenState.red;
    const ink = _SosScreenState.inkSoft;
    const border = _SosScreenState.border;
    const surface = _SosScreenState.surface;

    return Material(
      color: selected ? red.withValues(alpha: 0.06) : surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 56),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? red.withValues(alpha: 0.45) : border,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: red.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(service.icon, size: 18, color: red),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  AppScope.of(context).t(service.name),
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: ink,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
// Location card
// ================================================================

class _LocationCard extends StatelessWidget {
  final String label;
  final String value;
  final String gpsAccuracy;
  final String shareTitle;
  final String shareSubtitle;
  final bool shareEnabled;
  final ValueChanged<bool> onShareChanged;

  const _LocationCard({
    required this.label,
    required this.value,
    required this.gpsAccuracy,
    required this.shareTitle,
    required this.shareSubtitle,
    required this.shareEnabled,
    required this.onShareChanged,
  });

  @override
  Widget build(BuildContext context) {
    const red = _SosScreenState.red;
    const surface = _SosScreenState.surface;
    const surface2 = _SosScreenState.surface2;
    const surfaceChip = _SosScreenState.surfaceChip;
    const border = _SosScreenState.border;
    const ink = _SosScreenState.ink;
    const inkSoft = _SosScreenState.inkSoft;
    const muted = _SosScreenState.muted;
    const safe = _SosScreenState.safe;

    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(20, 18, 20, 0),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: ink.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            color: surface2,
            child: CustomPaint(
              painter: _MapGridPainter(),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label.toUpperCase(),
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: muted,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: ink,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: safe.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: safe.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.gps_fixed, size: 16, color: safe),
                      const SizedBox(width: 5),
                      Text(
                        gpsAccuracy,
                        style: GoogleFonts.playfairDisplay(
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
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 16),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: border))),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shareTitle,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: inkSoft,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        shareSubtitle,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 10.5,
                          color: muted,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: shareEnabled,
                  onChanged: onShareChanged,
                  activeThumbColor: const Color(0xFFF8F7F6),
                  activeTrackColor: red,
                  inactiveThumbColor: const Color(0xFFF8F7F6),
                  inactiveTrackColor: surfaceChip,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _SosScreenState.ink.withValues(alpha: 0.05)
      ..strokeWidth = 1;
    const step = 24.0;
    for (double x = 0; x < size.width + step; x += step) {
      canvas.drawLine(
          Offset(x, 0), Offset(x - size.height, size.height), paint);
      canvas.drawLine(
          Offset(x, 0), Offset(x + size.height, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ================================================================
// Contact row
// ================================================================

class _ContactRow extends StatelessWidget {
  final _Contact contact;
  final VoidCallback onCall;

  const _ContactRow({required this.contact, required this.onCall});

  @override
  Widget build(BuildContext context) {
    const surface = _SosScreenState.surface;
    const border = _SosScreenState.border;
    const ink = _SosScreenState.ink;
    const inkSoft = _SosScreenState.inkSoft;
    const muted = _SosScreenState.muted;
    const surfaceChip = _SosScreenState.surfaceChip;
    const irisLight = Color(0xFF4B4F57);
    const safe = _SosScreenState.safe;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: ink.withValues(alpha: 0.05),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: surfaceChip,
              shape: BoxShape.circle,
            ),
            child: Text(
              contact.initials,
              style: GoogleFonts.playfairDisplay(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: irisLight,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppScope.of(context).t(contact.name),
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: inkSoft,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  AppScope.of(context).t(contact.role),
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 10.5,
                    color: muted,
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: safe.withValues(alpha: 0.14),
            shape: CircleBorder(side: BorderSide(color: safe.withValues(alpha: 0.35))),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onCall,
              child: const SizedBox(
                width: 38,
                height: 38,
                child: Icon(Icons.call_outlined, size: 16, color: safe),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// Hold button (press-and-hold SOS)
// ================================================================

class _HoldButton extends StatefulWidget {
  final Duration holdDuration;
  final VoidCallback onHoldComplete;

  const _HoldButton({required this.holdDuration, required this.onHoldComplete});

  @override
  State<_HoldButton> createState() => _HoldButtonState();
}

class _HoldButtonState extends State<_HoldButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _pressed = false;
  Timer? _holdDeadlineTimer;
  Timer? _progressTickTimer;
  double _manualProgress = 0.0;
  bool _holdCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.holdDuration);
  }

  @override
  void dispose() {
    _holdDeadlineTimer?.cancel();
    _progressTickTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _start() {
    if (_pressed || _holdCompleted) return;
    setState(() {
      _pressed = true;
      _manualProgress = 0.0;
    });
    _holdCompleted = false;

    final tickMs = 50;
    final totalMs = widget.holdDuration.inMilliseconds;
    int elapsed = 0;
    _progressTickTimer?.cancel();
    _progressTickTimer = Timer.periodic(Duration(milliseconds: tickMs), (t) {
      elapsed += tickMs;
      final p = (elapsed / totalMs).clamp(0.0, 1.0);
      if (mounted) {
        setState(() => _manualProgress = p);
        _controller.value = p;
      }
    });

    _holdDeadlineTimer?.cancel();
    _holdDeadlineTimer = Timer(widget.holdDuration, () {
      _progressTickTimer?.cancel();
      _holdDeadlineTimer?.cancel();
      _holdCompleted = true;
      if (mounted) {
        setState(() {
          _pressed = false;
          _manualProgress = 1.0;
        });
      }
      widget.onHoldComplete();
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 350), () {
          if (!mounted) return;
          setState(() {
            _manualProgress = 0.0;
            _controller.reset();
            _holdCompleted = false;
          });
        });
      }
    });
  }

  void _cancel() {
    if (_holdCompleted) return;
    _holdDeadlineTimer?.cancel();
    _progressTickTimer?.cancel();
    if (!_pressed) return;
    setState(() {
      _pressed = false;
      _manualProgress = 0.0;
    });
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    const red = _SosScreenState.red;
    const redDeep = _SosScreenState.redDeep;
    const redGlow = _SosScreenState.redGlow;

    return Listener(
      onPointerDown: (_) => _start(),
      onPointerUp: (_) => _cancel(),
      onPointerCancel: (_) => _cancel(),
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: red.withValues(alpha: 0.14)),
              ),
            ),
            Container(
              width: 172,
              height: 172,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: red.withValues(alpha: 0.25)),
              ),
            ),
            const _RingPulse(),
            Opacity(
              opacity: _pressed ? 1 : 0,
              child: CustomPaint(
                size: const Size(200, 200),
                painter: _HoldProgressPainter(progress: _manualProgress),
              ),
            ),
            AnimatedScale(
              scale: _pressed ? 0.94 : 1.0,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              child: Container(
                width: 172,
                height: 172,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: Alignment(-0.36, -0.4),
                    colors: [Color(0xFFE14B5F), red, redDeep],
                    stops: [0.0, 0.46, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: redGlow,
                      blurRadius: 40,
                      offset: Offset(0, 16),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.warning_amber_rounded,
                        size: 28, color: Colors.white),
                    const SizedBox(height: 8),
                    Text(
                      'SOS',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      AppScope.of(context).t('sosHome_holdLabel', {'seconds': '${widget.holdDuration.inSeconds}'}),
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                        color: Colors.white.withValues(alpha: 0.9),
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
}

class _RingPulse extends StatefulWidget {
  const _RingPulse();

  @override
  State<_RingPulse> createState() => _RingPulseState();
}

class _RingPulseState extends State<_RingPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 2200))
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const redGlow = _SosScreenState.redGlow;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        final scale = 0.9 + (0.45 * t);
        final opacity = (0.5 * (1 - t)).clamp(0.0, 1.0);
        return Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: 172,
              height: 172,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: redGlow,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HoldProgressPainter extends CustomPainter {
  final double progress;
  const _HoldProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 5.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = _SosScreenState.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _HoldProgressPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _SosSettingsSheet extends StatelessWidget {
  final bool shareEnabled;
  final ValueChanged<bool> onShareChanged;
  final VoidCallback onClose;

  const _SosSettingsSheet({
    required this.shareEnabled,
    required this.onShareChanged,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    const red = _SosScreenState.red;
    const surface = _SosScreenState.surface;
    const ink = _SosScreenState.ink;
    const muted = _SosScreenState.muted;
    const borderStrong = _SosScreenState.borderStrong;

    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
        ),
        padding: const EdgeInsetsDirectional.fromSTEB(22, 20, 22, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppScope.of(context).t('sosHome_settingsTitle'),
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ink,
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onClose,
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(Icons.close_rounded, color: muted),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: borderStrong),
              ),
              padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 16, 14),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: red.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.my_location_rounded, color: red),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppScope.of(context).t('sosHome_shareLiveLocation'),
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: ink,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          AppScope.of(context).t('sosHome_shareSubtitle'),
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 12,
                            color: muted,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: shareEnabled,
                    activeThumbColor: red,
                    activeTrackColor: red.withValues(alpha: 0.35),
                    onChanged: onShareChanged,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: onClose,
                  child: Container(
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderStrong),
                    ),
                    child: Text(
                      AppScope.of(context).t('rewards_doneButton'),
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: ink,
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
}
