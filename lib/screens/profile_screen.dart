import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_scope.dart';
import '../models/groups.dart';
import '../models/groups_scope.dart';
import '../models/i18n.dart';
import '../providers/home_providers.dart';
import '../routes.dart';
import 'family_account_consent_screen.dart';

// ============================================================================
// This file (profile_screen.dart) intentionally contains everything the
// Profile area needs in one place: theme helpers, icons, demo data models,
// and all screens (Profile, My Visits, Legacy Capsule, Privacy & Data,
// Edit Profile, Personal Information, Invite & Earn, Create Group Flow,
// and Group Details with Map, Members, and Settings tabs).
// ============================================================================

// ============================================================================
// COLORS — mapped 1:1 from the :root CSS custom properties in the redesigned
// profile.html. Dynamic versions: pass isLight to get Dark/Light variants.
// ============================================================================
class AxnColors {
  AxnColors._();

  static Color bg(bool isLight) => isLight ? const Color(0xFFFFFFFF) : const Color(0xFF121212);
  static Color ink(bool isLight) => isLight ? const Color(0xFF1B1D22) : Colors.white;
  static Color muted(bool isLight) => isLight ? const Color(0xFF9A9FA6) : Colors.white60;
  static Color line(bool isLight) => isLight ? const Color(0xFFF1EFEB) : Colors.white12;
  static Color rowBg(bool isLight) => isLight ? const Color(0xFFF6F5F2) : const Color(0xFF1E2430);
  static Color rowBgPressed(bool isLight) => isLight ? const Color(0xFFEFEDE8) : const Color(0xFF283040);
  static Color navy(bool isLight) => const Color(0xFF8B1E2E);
  static Color tealDeep(bool isLight) => const Color(0xFF8B1E2E);

  static Color blueBg(bool isLight) => isLight ? const Color(0xFFFBEDEE) : const Color(0xFF2A1A1C);
  static Color blueTx(bool isLight) => isLight ? const Color(0xFF8B1E2E) : const Color(0xFFE63946);
  static Color greenBg(bool isLight) => isLight ? const Color(0xFFE1F3E2) : const Color(0xFF1A2E1C);
  static Color greenTx(bool isLight) => isLight ? const Color(0xFF4C9A5A) : const Color(0xFF66BB6A);
  static Color orangeBg(bool isLight) => isLight ? const Color(0xFFE7E5E0) : const Color(0xFF2A2820);
  static Color orangeTx(bool isLight) => isLight ? const Color(0xFF6B6255) : const Color(0xFFB5AA90);
  static Color pointsBg(bool isLight) => isLight ? const Color(0xFFFBEDEE) : const Color(0xFF2A1A1C);
  static Color pointsTx(bool isLight) => isLight ? const Color(0xFF8B1E2E) : const Color(0xFFE63946);

  static Color familyBg(bool isLight) => isLight ? const Color(0xFFFBE3E8) : const Color(0xFF301C22);
  static Color familyTx(bool isLight) => isLight ? const Color(0xFFA02C48) : const Color(0xFFD66A80);
  static Color groupBg(bool isLight) => isLight ? const Color(0xFFF7E1E4) : const Color(0xFF301C22);
  static Color groupTx(bool isLight) => isLight ? const Color(0xFF9C2E42) : const Color(0xFFD66A80);
  static Color verifiedBg(bool isLight) => isLight ? const Color(0xFFDFF3E4) : const Color(0xFF1A2E1C);
  static Color verifiedTx(bool isLight) => isLight ? const Color(0xFF3C9A5C) : const Color(0xFF66BB6A);
  static Color phoneVerifBg(bool isLight) => isLight ? const Color(0xFFF7E4E6) : const Color(0xFF2A1A1C);
  static Color phoneVerifTx(bool isLight) => isLight ? const Color(0xFF8B1E2E) : const Color(0xFFE63946);
  static Color unverifiedBg(bool isLight) => isLight ? const Color(0xFFF3F1EC) : const Color(0xFF2A2820);
  static Color unverifiedTx(bool isLight) => isLight ? const Color(0xFF9A9481) : const Color(0xFFB5AA90);

  static Color dangerBg(bool isLight) => isLight ? const Color(0xFFFBE4E6) : const Color(0xFF2D1A1C);
  static Color dangerTx(bool isLight) => isLight ? const Color(0xFFD65D6B) : const Color(0xFFE63946);

  static Color icMint(bool isLight) => isLight ? const Color(0xFFDCEFE7) : const Color(0xFF1E3A2B);
  static Color icGray(bool isLight) => isLight ? const Color(0xFFE7E5E0) : const Color(0xFF2A2820);
  static Color dotLive(bool isLight) => const Color(0xFF3FB56B);
  static Color dotAway(bool isLight) => isLight ? const Color(0xFFC9C4B8) : const Color(0xFF5A5548);
  static Color avMoreBg(bool isLight) => isLight ? const Color(0xFFE4E1D9) : const Color(0xFF2A2820);
  static Color avMoreTx(bool isLight) => isLight ? const Color(0xFF8A8574) : const Color(0xFFB5AA90);
  static Color avatarBadgeGold(bool isLight) => const Color(0xFFF3C570);
  static Color capsuleBoxBg(bool isLight) => isLight ? const Color(0xFF6B1420) : const Color(0xFF4A0E18);
  static Color dashedBorder(bool isLight) => isLight ? const Color(0xFFCFCABF) : const Color(0xFF4A4840);
  static Color createGroupText(bool isLight) => isLight ? const Color(0xFF57534A) : const Color(0xFFB5AA90);
}

// ============================================================================
// TYPOGRAPHY
// ============================================================================
class AxnText {
  AxnText._();

  static TextStyle get _arabicFallback => GoogleFonts.ibmPlexSansArabic().copyWith();

  static TextStyle playfair({
    required double size,
    required FontWeight weight,
    required Color color,
    double? height,
    double? letterSpacing,
    bool isArabic = false,
  }) {
    if (isArabic) {
      return GoogleFonts.elMessiri(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );
    }
    return GoogleFonts.playfairDisplay(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    ).copyWith(fontFamilyFallback: [_arabicFallback.fontFamily!]);
  }
}

// ============================================================================
// INLINE SVG ICONS
// ============================================================================
class AxnSvgIcons {
  AxnSvgIcons._();

  static String _stroke(String d, {String color = '#000000', double width = 2}) {
    return '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="$color" stroke-width="$width" stroke-linecap="round" stroke-linejoin="round">$d</svg>';
  }

  static Widget pencil({required Color color, double size = 13}) {
    final svg = _stroke(
      '<path d="M12 20h9"/><path d="M16.5 3.5a2.12 2.12 0 013 3L7 19l-4 1 1-4 12.5-12.5z"/>',
      color: '#${color.value.toRadixString(16).substring(2)}',
      width: 2.4,
    );
    return SvgPicture.string(svg, width: size, height: size);
  }

  static Widget eye({required Color color, double size = 13}) {
    final svg = _stroke(
      '<path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7z"/><circle cx="12" cy="12" r="3"/>',
      color: '#${color.value.toRadixString(16).substring(2)}',
      width: 2,
    );
    return SvgPicture.string(svg, width: size, height: size);
  }

  static Widget chevron({required Color color, double size = 14}) {
    final svg = _stroke(
      '<path d="M9 18l6-6-6-6"/>',
      color: '#${color.value.toRadixString(16).substring(2)}',
      width: 2.4,
    );
    return SvgPicture.string(svg, width: size, height: size);
  }

  static Widget backArrow({required Color color, double size = 16}) {
    final svg = _stroke(
      '<path d="M15 18l-6-6 6-6"/>',
      color: '#${color.value.toRadixString(16).substring(2)}',
      width: 2.4,
    );
    return SvgPicture.string(svg, width: size, height: size);
  }

  static Widget pin({required Color color, double size = 15}) {
    final svg = _stroke(
      '<path d="M12 21s-7-6.1-7-11a7 7 0 1114 0c0 4.9-7 11-7 11z"/><circle cx="12" cy="10" r="2.4"/>',
      color: '#${color.value.toRadixString(16).substring(2)}',
      width: 2.2,
    );
    return SvgPicture.string(svg, width: size, height: size);
  }

  static Widget shield({required Color color, double size = 15}) {
    final svg = _stroke(
      '<rect x="4" y="10" width="16" height="10" rx="2.4"/><path d="M8 10V7a4 4 0 018 0v3"/>',
      color: '#${color.value.toRadixString(16).substring(2)}',
      width: 2.2,
    );
    return SvgPicture.string(svg, width: size, height: size);
  }

  static Widget personOutline({required Color color, double size = 15, double width = 2.2}) {
    final svg = _stroke(
      '<circle cx="12" cy="8" r="4"/><path d="M4 20.5c0-4.4 3.8-7 8-7s8 2.6 8 7"/>',
      color: '#${color.value.toRadixString(16).substring(2)}',
      width: width,
    );
    return SvgPicture.string(svg, width: size, height: size);
  }

  static Widget sosAlert({Color color = Colors.white, double size = 13}) {
    final svg = _stroke(
      '<path d="M12 8.5v4.2"/><circle cx="12" cy="15.8" r="0.5" fill="#fff"/><path d="M10.3 3.9L2.9 17a2 2 0 001.7 3h14.8a2 2 0 001.7-3L13.7 3.9a2 2 0 00-3.4 0z"/>',
      color: '#${color.value.toRadixString(16).substring(2)}',
      width: 2.6,
    );
    return SvgPicture.string(svg, width: size, height: size);
  }

  static Widget smartExit({Color color = Colors.white, double size = 13}) {
    final svg = _stroke(
      '<path d="M15 3h4a2 2 0 012 2v14a2 2 0 01-2 2h-4"/><path d="M10 17l5-5-5-5"/><path d="M15 12H3"/>',
      color: '#${color.value.toRadixString(16).substring(2)}',
      width: 2.4,
    );
    return SvgPicture.string(svg, width: size, height: size);
  }

  static Widget shareSquare({required Color color, double size = 14}) {
    final svg = _stroke(
      '<rect x="3" y="3" width="18" height="18" rx="5"/><circle cx="12" cy="12" r="4"/>',
      color: '#${color.value.toRadixString(16).substring(2)}',
      width: 2,
    );
    return SvgPicture.string(svg, width: size, height: size);
  }

  static Widget settings({required Color color, double size = 16}) {
    final svg = _stroke(
      '<circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 11-2.83 2.83l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 11-4 0v-.09a1.65 1.65 0 00-1-1.51 1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 11-2.83-2.83l.06-.06a1.65 1.65 0 00.33-1.82 1.65 1.65 0 00-1.51-1H3a2 2 0 110-4h.09a1.65 1.65 0 001.51-1 1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 112.83-2.83l.06.06a1.65 1.65 0 001.82.33H9a1.65 1.65 0 001-1.51V3a2 2 0 114 0v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 112.83 2.83l-.06.06a1.65 1.65 0 00-.33 1.82V9a1.65 1.65 0 001.51 1H21a2 2 0 110 4h-.09a1.65 1.65 0 00-1.51 1z"/>',
      color: '#${color.value.toRadixString(16).substring(2)}',
      width: 2.2,
    );
    return SvgPicture.string(svg, width: size, height: size);
  }
}

// ============================================================================
// PROFILE SCREEN
// ============================================================================
class ProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String phoneNumber;
  final int points;
  final int trips;
  final String tier;
  final List<GroupData> groups;
  final String visitsSubtitle;
  final String capsuleSubtitle;
  final bool highlightCreateGroup;
  final bool scrollToMyGroups;

  final int inviteFriendsCount;
  final int invitePointsEarned;

  final VoidCallback? onBack;
  final VoidCallback? onEditPhoto;
  final VoidCallback? onEditHandle;
  final VoidCallback? onOpenPersonalInfo;
  final VoidCallback? onOpenNationalId;
  final VoidCallback? onOpenInviteFriends;
  final void Function(GroupData group)? onOpenGroup;
  final VoidCallback? onCreateGroup;
  final VoidCallback? onOpenVisits;
  final VoidCallback? onOpenCapsuleHub;
  final VoidCallback? onOpenPrivacyData;
  final VoidCallback? onOpenSettings;
  final VoidCallback? onLogout;

  const ProfileScreen({
    super.key,
    this.username = 'username',
    this.phoneNumber = '+962 7 xxx xxxx',
    this.points = 680,
    this.trips = 12,
    this.tier = 'Silver',
    this.groups = demoGroups,
    this.visitsSubtitle = '3 visits',
    this.capsuleSubtitle = '1 memory saved on your device',
    this.highlightCreateGroup = false,
    this.scrollToMyGroups = false,
    this.inviteFriendsCount = 5,
    this.invitePointsEarned = 250,
    this.onBack,
    this.onEditPhoto,
    this.onEditHandle,
    this.onOpenPersonalInfo,
    this.onOpenNationalId,
    this.onOpenInviteFriends,
    this.onOpenGroup,
    this.onCreateGroup,
    this.onOpenVisits,
    this.onOpenCapsuleHub,
    this.onOpenPrivacyData,
    this.onOpenSettings,
    this.onLogout,
  });

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _emptyPreview = false;
  late List<GroupData> _currentGroups;

  final ScrollController _scroll = ScrollController();
  final GlobalKey _myGroupsKey = GlobalKey();
  final GlobalKey<TooltipState> _createGroupTooltipKey = GlobalKey<TooltipState>();
  late bool _showCreateGroupHint;

  @override
  void initState() {
    super.initState();
    _currentGroups = List.of(widget.groups);
    _showCreateGroupHint = widget.highlightCreateGroup;
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeScrollAndHint());
  }

  @override
  void didUpdateWidget(covariant ProfileScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.groups != oldWidget.groups) {
      _currentGroups = List.of(widget.groups);
    }
    if (widget.highlightCreateGroup && !oldWidget.highlightCreateGroup) {
      _showCreateGroupHint = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _maybeScrollAndHint());
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _maybeScrollAndHint() async {
    if (!mounted) return;

    if (widget.scrollToMyGroups) {
      final ctx = _myGroupsKey.currentContext;
      if (ctx != null) {
        await Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 520),
          curve: Curves.easeOut,
          alignment: 0.12,
        );
      }
    }

    if (!_showCreateGroupHint) return;
    await Future.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;
    _createGroupTooltipKey.currentState?.ensureTooltipVisible();
  }

  void _handleCreateGroupTap() {
    if (_showCreateGroupHint) setState(() => _showCreateGroupHint = false);
    if (widget.onCreateGroup != null) {
      widget.onCreateGroup!();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => CreateGroupTypeScreen(
          onGroupCreated: (newGroup) {
            setState(() {
              _currentGroups = [newGroup, ..._currentGroups];
            });
          },
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final onBack = widget.onBack ?? () => Navigator.of(context).maybePop();
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final scope = AppScope.of(context);

    final user = ref.watch(currentUserProvider).value;
    final effectiveName = user?.name ?? widget.username;
    final effectivePhone = user?.phoneNumber ?? widget.phoneNumber;

    final onOpenVisits = widget.onOpenVisits ??
        () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const VisitsScreen()));
    final onOpenCapsuleHub = widget.onOpenCapsuleHub ??
        () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LegacyCapsuleScreen()));
    final onOpenPrivacyData = widget.onOpenPrivacyData ??
        () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PrivacyDataScreen(groupsCount: _currentGroups.length),
            ));

    return Scaffold(
      backgroundColor: AxnColors.bg(isLight),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scroll,
          padding: const EdgeInsetsDirectional.fromSTEB(22, 6, 22, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Material(
                  color: AxnColors.rowBg(isLight),
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onBack,
                    child: SizedBox(
                      width: 34,
                      height: 34,
                      child: Center(
                        child: AxnSvgIcons.backArrow(color: AxnColors.ink(isLight), size: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 8, bottom: 18),
                child: Text(
                  scope.t('profile_title'),
                  style: AxnText.playfair(size: 30, weight: FontWeight.w500, color: AxnColors.ink(isLight), isArabic: scope.isArabic),
                ),
              ),

              _AvatarHeader(
                onEditPhoto: widget.onEditPhoto ?? () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditProfileScreen(
                    initialName: effectiveName,
                    initialUsername: effectiveName,
                    phoneNumber: effectivePhone,
                    onNameChanged: (n) => updateCurrentUserName(n),
                    onUsernameChanged: (h) => updateCurrentUserHandle(h),
                  )));
                },
                isLight: isLight,
              ),

              _HandleRow(
                username: effectiveName,
                phoneNumber: effectivePhone,
                onEditHandle: widget.onEditHandle ?? () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditProfileScreen(
                    initialName: effectiveName,
                    initialUsername: effectiveName,
                    phoneNumber: effectivePhone,
                    onNameChanged: (n) => updateCurrentUserName(n),
                    onUsernameChanged: (h) => updateCurrentUserHandle(h),
                  )));
                },
                isLight: isLight,
                scope: scope,
              ),
              const SizedBox(height: 22),

              _StatsRow(points: widget.points, trips: widget.trips, tier: widget.tier, isLight: isLight, scope: scope),
              const SizedBox(height: 26),

              _SectionLabel(title: scope.t('profile_account'), isLight: isLight, isArabic: scope.isArabic),
              const SizedBox(height: 10),
              _InfoRow(
                iconBg: AxnColors.blueBg(isLight),
                icon: AxnSvgIcons.personOutline(color: AxnColors.blueTx(isLight), size: 15, width: 2.2),
                title: scope.t('profile_personalInfo'),
                subtitle: scope.t('profile_personalInfoSub'),
                showChevron: true,
                onTap: widget.onOpenPersonalInfo ?? () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => PersonalInfoScreen(
                    name: effectiveName,
                    username: effectiveName,
                    phoneNumber: effectivePhone,
                    tier: widget.tier,
                  )));
                },
                isLight: isLight,
                scope: scope,
              ),
              const SizedBox(height: 10),
              _InviteCard(
                friendsInvited: widget.inviteFriendsCount,
                pointsEarned: widget.invitePointsEarned,
                onTap: widget.onOpenInviteFriends ?? () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => InviteFriendsScreen(username: effectiveName)));
                },
                isLight: isLight,
                scope: scope,
              ),
              const SizedBox(height: 26),

              Container(
                key: _myGroupsKey,
                child: _SectionLabel(
                  title: scope.t('profile_myGroups'),
                  trailing: _MyGroupsTrailing(
                    label: scope.t('profile_groupsCount', {'count': '${_currentGroups.length}'}),
                    onTogglePreview: () => setState(() => _emptyPreview = !_emptyPreview),
                    isLight: isLight,
                    scope: scope,
                  ),
                  isLight: isLight,
                  isArabic: scope.isArabic,
                ),
              ),
              const SizedBox(height: 10),

              if (_emptyPreview || _currentGroups.isEmpty)
                _EmptyGroupsState(isLight: isLight, scope: scope)
              else
                ..._currentGroups.map(
                  (g) => Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 12),
                    child: _GroupCard(group: g, onTap: () {
                      if (widget.onOpenGroup != null) {
                        widget.onOpenGroup!(g);
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => GroupDetailsScreen(group: g)));
                      }
                    }, isLight: isLight, scope: scope),
                  ),
                ),

              Builder(
                builder: (context) {
                  Widget btn = _CreateGroupButton(onTap: _handleCreateGroupTap, isLight: isLight, scope: scope);
                  if (!_showCreateGroupHint) return btn;
                  return Tooltip(
                    key: _createGroupTooltipKey,
                    message: scope.t('profile_groupsHint'),
                    triggerMode: TooltipTriggerMode.manual,
                    showDuration: const Duration(minutes: 30),
                    preferBelow: false,
                    child: _Shimmer(child: btn, isLight: isLight),
                  );
                },
              ),
              const SizedBox(height: 22),

              _SectionLabel(title: scope.t('profile_myVisits'), isLight: isLight, isArabic: scope.isArabic),
              const SizedBox(height: 10),
              _InfoRow(
                iconBg: AxnColors.blueBg(isLight),
                icon: AxnSvgIcons.pin(color: AxnColors.blueTx(isLight)),
                title: scope.t('profile_visitHistory'),
                subtitle: widget.visitsSubtitle,
                showChevron: true,
                onTap: onOpenVisits,
                isLight: isLight,
                scope: scope,
              ),
              const SizedBox(height: 26),

              _SectionLabel(title: scope.t('profile_legacyCapsule'), isLight: isLight, isArabic: scope.isArabic),
              const SizedBox(height: 10),
              _InfoRow(
                iconBg: AxnColors.capsuleBoxBg(isLight),
                icon: const Text('📦', style: TextStyle(fontSize: 16)),
                title: scope.t('profile_savedMemories'),
                subtitle: widget.capsuleSubtitle,
                showChevron: true,
                onTap: onOpenCapsuleHub,
                isLight: isLight,
                scope: scope,
              ),
              const SizedBox(height: 26),

              _SectionLabel(title: scope.t('profile_more'), isLight: isLight, isArabic: scope.isArabic),
              const SizedBox(height: 10),
              _InfoRow(
                iconBg: AxnColors.blueBg(isLight),
                icon: AxnSvgIcons.shield(color: AxnColors.blueTx(isLight)),
                title: scope.t('profile_privacyData'),
                subtitle: scope.t('profile_everythingStored'),
                showChevron: true,
                onTap: onOpenPrivacyData,
                isLight: isLight,
                scope: scope,
              ),
              const SizedBox(height: 10),
              _InfoRow(
                iconBg: AxnColors.familyBg(isLight),
                icon: const Icon(Icons.family_restroom, size: 16, color: Color(0xFFA02C48)),
                title: scope.isArabic ? 'موافقة مشاركة العائلة' : 'Family Sharing Consent',
                subtitle: scope.isArabic ? 'إدارة موافقة مشاركة الموقع مع المجموعة العائلية' : 'Manage location sharing consent with your family group',
                showChevron: true,
                onTap: () async {
                  final groups = GroupsScope.of(context);
                  final rootNav = Navigator.of(context, rootNavigator: true);
                  final accepted = await rootNav.push<bool>(
                    MaterialPageRoute<bool>(
                      fullscreenDialog: true,
                      builder: (_) => const FamilyAccountConsentPage(),
                    ),
                  );
                  if (accepted == true) {
                    groups.grantFamilyConsent();
                  }
                },
                isLight: isLight,
                scope: scope,
              ),
              const SizedBox(height: 10),
              _InfoRow(
                iconBg: AxnColors.icGray(isLight),
                icon: AxnSvgIcons.settings(color: AxnColors.orangeTx(isLight), size: 16),
                title: scope.t('profile_settings'),
                showChevron: true,
                onTap: widget.onOpenSettings,
                isLight: isLight,
                scope: scope,
              ),
              const SizedBox(height: 26),

              _LogoutButton(onTap: widget.onLogout, isLight: isLight, scope: scope),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// AVATAR HEADER
// ============================================================================
class _AvatarHeader extends StatelessWidget {
  final VoidCallback? onEditPhoto;
  final bool isLight;
  const _AvatarHeader({this.onEditPhoto, required this.isLight});

  static const _ringSize = 126.0;
  static const _avatarBigSize = 110.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 6, bottom: 18),
      child: Center(
        child: SizedBox(
          width: _ringSize + 20,
          height: _ringSize + 20,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: _ringSize,
                height: _ringSize,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: const Alignment(-0.7, -1),
                    end: const Alignment(0.7, 1),
                    colors: [AxnColors.tealDeep(isLight), const Color(0xFFD98A94)],
                  ),
                ),
                child: Center(
                  child: Container(
                    width: _avatarBigSize,
                    height: _avatarBigSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AxnColors.bg(isLight), width: 3),
                      gradient: const LinearGradient(
                        begin: Alignment(-0.8, -0.6),
                        end: Alignment(0.8, 0.6),
                        colors: [Color(0xFFF3E9EA), Color(0xFFE9DEDB)],
                      ),
                    ),
                    child: Center(
                      child: Opacity(
                        opacity: 0.4,
                        child: AxnSvgIcons.personOutline(
                          color: AxnColors.tealDeep(isLight),
                          size: 46,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 4,
                child: _Badge(
                  size: 26,
                  color: AxnColors.avatarBadgeGold(isLight),
                  borderColor: AxnColors.bg(isLight),
                  borderWidth: 3,
                ),
              ),
              Positioned(
                bottom: 2,
                left: 4,
                child: GestureDetector(
                  onTap: onEditPhoto,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AxnColors.ink(isLight),
                      border: Border.all(color: AxnColors.bg(isLight), width: 3),
                    ),
                    child: Center(child: AxnSvgIcons.pencil(color: Colors.white, size: 13)),
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

class _Badge extends StatelessWidget {
  final double size;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  const _Badge({required this.size, required this.color, required this.borderColor, required this.borderWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }
}

// ============================================================================
// HANDLE ROW
// ============================================================================
class _HandleRow extends StatelessWidget {
  final String username;
  final String phoneNumber;
  final VoidCallback? onEditHandle;
  final bool isLight;
  final LocaleController scope;

  const _HandleRow({
    required this.username,
    required this.phoneNumber,
    this.onEditHandle,
    required this.isLight,
    required this.scope,
  });

  @override
  Widget build(BuildContext context) {
    final handleTextColor = isLight ? const Color(0xFF6B6255) : const Color(0xFFB5AA90);
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AxnColors.rowBg(isLight),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '@$username',
              style: AxnText.playfair(size: 13, weight: FontWeight.w600, color: handleTextColor),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            phoneNumber,
            textDirection: TextDirection.ltr,
            style: AxnText.playfair(size: 13, weight: FontWeight.w400, color: AxnColors.muted(isLight)),
          ),
          const SizedBox(height: 6),
          Material(
            color: AxnColors.rowBg(isLight),
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onEditHandle,
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 9),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AxnSvgIcons.pencil(color: AxnColors.ink(isLight), size: 12),
                    const SizedBox(width: 6),
                    Text(
                      scope.t('profile_editProfile'),
                      style: AxnText.playfair(
                        size: 12.5,
                        weight: FontWeight.w700,
                        color: AxnColors.ink(isLight),
                        isArabic: scope.isArabic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// STATS ROW
// ============================================================================
class _StatsRow extends StatelessWidget {
  final int points;
  final int trips;
  final String tier;
  final bool isLight;
  final LocaleController scope;
  const _StatsRow({required this.points, required this.trips, required this.tier, required this.isLight, required this.scope});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StatTile(value: '$points', label: scope.t('profile_points'), bg: AxnColors.pointsBg(isLight), tx: AxnColors.pointsTx(isLight), isArabic: scope.isArabic)),
        const SizedBox(width: 10),
        Expanded(child: _StatTile(value: '$trips', label: scope.t('profile_trips'), bg: AxnColors.greenBg(isLight), tx: AxnColors.greenTx(isLight), isArabic: scope.isArabic)),
        const SizedBox(width: 10),
        Expanded(child: _StatTile(value: scope.t('rewards_${tier.toLowerCase()}'), label: scope.t('profile_tier'), bg: AxnColors.orangeBg(isLight), tx: AxnColors.orangeTx(isLight), isArabic: scope.isArabic)),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final String value;
  final String label;
  final Color bg;
  final Color tx;
  final bool isArabic;
  const _StatTile({required this.value, required this.label, required this.bg, required this.tx, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 14, horizontal: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(18)),
      child: Column(
        children: [
          Text(value, style: AxnText.playfair(size: 20, weight: FontWeight.w700, color: tx, isArabic: isArabic)),
          const SizedBox(height: 2),
          Opacity(
            opacity: 0.85,
            child: Text(label, style: AxnText.playfair(size: 11, weight: FontWeight.w600, color: tx, isArabic: isArabic)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// INVITE CARD
// ============================================================================
class _InviteCard extends StatelessWidget {
  final int friendsInvited;
  final int pointsEarned;
  final VoidCallback? onTap;
  final bool isLight;
  final LocaleController scope;
  const _InviteCard({
    required this.friendsInvited,
    required this.pointsEarned,
    this.onTap,
    required this.isLight,
    required this.scope,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              begin: const Alignment(-1, -1),
              end: const Alignment(1, 1),
              colors: [const Color(0xFF3B0A12), AxnColors.tealDeep(isLight)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.14), shape: BoxShape.circle),
                    child: const Center(child: Text('🎁', style: TextStyle(fontSize: 19))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          scope.t('profile_inviteEarn'),
                          style: AxnText.playfair(size: 14.5, weight: FontWeight.w700, color: Colors.white, isArabic: scope.isArabic),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          scope.t('profile_inviteEarnSub'),
                          style: AxnText.playfair(size: 11.5, weight: FontWeight.w400, color: Colors.white.withValues(alpha: 0.65), isArabic: scope.isArabic),
                        ),
                      ],
                    ),
                  ),
                  Opacity(opacity: 0.5, child: AxnSvgIcons.chevron(color: Colors.white, size: 14)),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _InviteStat(value: '$friendsInvited', label: scope.t('profile_friendsInvited'), isArabic: scope.isArabic),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _InviteStat(value: '$pointsEarned', label: scope.t('profile_pointsEarned'), isArabic: scope.isArabic),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InviteStat extends StatelessWidget {
  final String value;
  final String label;
  final bool isArabic;
  const _InviteStat({required this.value, required this.label, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 9, horizontal: 6),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Text(value, style: AxnText.playfair(size: 16, weight: FontWeight.w700, color: Colors.white, isArabic: isArabic)),
          const SizedBox(height: 1),
          Text(label, style: AxnText.playfair(size: 10, weight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.62), isArabic: isArabic)),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION LABEL
// ============================================================================
class _SectionLabel extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final bool isLight;
  final bool isArabic;
  const _SectionLabel({required this.title, this.trailing, required this.isLight, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final labelStyle = AxnText.playfair(
      size: 12,
      weight: FontWeight.w600,
      color: AxnColors.muted(isLight),
      letterSpacing: isArabic ? 0 : 0.02 * 12,
      isArabic: isArabic,
    );
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 2, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: labelStyle),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _MyGroupsTrailing extends StatelessWidget {
  final String label;
  final VoidCallback onTogglePreview;
  final bool isLight;
  final LocaleController scope;
  const _MyGroupsTrailing({required this.label, required this.onTogglePreview, required this.isLight, required this.scope});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AxnText.playfair(size: 12, weight: FontWeight.w600, color: AxnColors.muted(isLight), isArabic: scope.isArabic)),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onTogglePreview,
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(color: AxnColors.rowBg(isLight), shape: BoxShape.circle),
            child: Center(child: Opacity(opacity: 0.7, child: AxnSvgIcons.eye(color: AxnColors.ink(isLight), size: 13))),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// INFO ROW
// ============================================================================
class _InfoRow extends StatelessWidget {
  final Color iconBg;
  final Widget? icon;
  final String title;
  final String? subtitle;
  final bool showChevron;
  final VoidCallback? onTap;
  final bool isLight;
  final LocaleController scope;

  const _InfoRow({
    required this.iconBg,
    this.icon,
    required this.title,
    this.subtitle,
    this.showChevron = false,
    this.onTap,
    required this.isLight,
    required this.scope,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AxnColors.rowBg(isLight),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        splashColor: AxnColors.rowBgPressed(isLight),
        highlightColor: AxnColors.rowBgPressed(isLight),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                child: icon != null ? Center(child: icon) : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AxnText.playfair(size: 14.5, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: scope.isArabic),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 1),
                      Text(
                        subtitle!,
                        style: AxnText.playfair(size: 12, weight: FontWeight.w400, color: AxnColors.muted(isLight), isArabic: scope.isArabic),
                      ),
                    ],
                  ],
                ),
              ),
              if (showChevron)
                Opacity(opacity: 0.35, child: AxnSvgIcons.chevron(color: AxnColors.ink(isLight), size: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// GROUP CARD
// ============================================================================
class _GroupCard extends StatelessWidget {
  final GroupData group;
  final VoidCallback? onTap;
  final bool isLight;
  final LocaleController scope;
  const _GroupCard({required this.group, this.onTap, required this.isLight, required this.scope});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AxnColors.rowBg(isLight),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        splashColor: AxnColors.rowBgPressed(isLight),
        highlightColor: AxnColors.rowBgPressed(isLight),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _AvatarStack(members: group.members, isLight: isLight),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          group.name,
                          style: AxnText.playfair(size: 15, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: scope.isArabic),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          scope.t('profile_members', {'count': '${group.members.length}'}),
                          style: AxnText.playfair(size: 12, weight: FontWeight.w400, color: AxnColors.muted(isLight), isArabic: scope.isArabic),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 11),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: group.type == GroupType.family
                    ? [
                        _Pill(text: scope.t('profile_family'), bg: AxnColors.familyBg(isLight), tx: AxnColors.familyTx(isLight), isArabic: scope.isArabic),
                        _Pill(text: scope.t('profile_nationalVerified'), bg: AxnColors.verifiedBg(isLight), tx: AxnColors.verifiedTx(isLight), isArabic: scope.isArabic),
                      ]
                    : [
                        _Pill(text: scope.t('profile_group'), bg: AxnColors.groupBg(isLight), tx: AxnColors.groupTx(isLight), isArabic: scope.isArabic),
                        _Pill(text: scope.t('profile_phoneVerified'), bg: AxnColors.phoneVerifBg(isLight), tx: AxnColors.phoneVerifTx(isLight), isArabic: scope.isArabic),
                      ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  final List<GroupMember> members;
  final bool isLight;
  final double size;
  const _AvatarStack({required this.members, required this.isLight, this.size = 34.0});

  @override
  Widget build(BuildContext context) {
    final shown = members.take(3).toList();
    final rest = members.length - shown.length;
    final overlap = size * 0.3;

    final bubbles = <Widget>[
      for (final m in shown)
        _MemberBubble(initials: m.initials, color: m.color, live: m.live, size: size, isLight: isLight),
      if (rest > 0) _OverflowBubble(count: rest, size: size, isLight: isLight),
    ];

    return SizedBox(
      width: size + (bubbles.length - 1) * (size - overlap),
      height: size,
      child: Stack(
        children: [
          for (int i = 0; i < bubbles.length; i++)
            PositionedDirectional(end: i * (size - overlap), child: bubbles[i]),
        ],
      ),
    );
  }
}

class _MemberBubble extends StatelessWidget {
  final String initials;
  final Color color;
  final bool live;
  final double size;
  final bool isLight;
  const _MemberBubble({required this.initials, required this.color, required this.live, required this.size, required this.isLight});

  @override
  Widget build(BuildContext context) {
    final initialsColor = isLight ? const Color(0xFF4A4436) : const Color(0xFF2A2518);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: AxnColors.rowBg(isLight), width: 2.5),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Text(
              initials,
              style: AxnText.playfair(size: size * 0.33, weight: FontWeight.w700, color: initialsColor),
            ),
          ),
          Positioned(
            bottom: -1,
            left: -1,
            child: Container(
              width: size * 0.28,
              height: size * 0.28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: live ? AxnColors.dotLive(isLight) : AxnColors.dotAway(isLight),
                border: Border.all(color: AxnColors.rowBg(isLight), width: 1.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverflowBubble extends StatelessWidget {
  final int count;
  final double size;
  final bool isLight;
  const _OverflowBubble({required this.count, required this.size, required this.isLight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AxnColors.avMoreBg(isLight),
        border: Border.all(color: AxnColors.rowBg(isLight), width: 2.5),
      ),
      child: Center(
        child: Text(
          '+$count',
          style: AxnText.playfair(size: size * 0.33, weight: FontWeight.w700, color: AxnColors.avMoreTx(isLight)),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color bg;
  final Color tx;
  final bool isArabic;
  const _Pill({required this.text, required this.bg, required this.tx, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: AxnText.playfair(size: 11, weight: FontWeight.w600, color: tx, isArabic: isArabic)),
    );
  }
}

class _EmptyGroupsState extends StatelessWidget {
  final bool isLight;
  final LocaleController scope;
  const _EmptyGroupsState({required this.isLight, required this.scope});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.fromSTEB(10, 26, 10, 30),
      decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment(-0.8, -0.6),
                end: Alignment(0.8, 0.6),
                colors: [Color(0xFFCFEFE6), Color(0xFFE4EFFC)],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            scope.t('profile_noGroups'),
            style: AxnText.playfair(size: 15, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: scope.isArabic),
          ),
          const SizedBox(height: 6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 230),
            child: Text(
              scope.t('profile_noGroupsSub'),
              textAlign: TextAlign.center,
              style: AxnText.playfair(size: 12.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.6, isArabic: scope.isArabic),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateGroupButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isLight;
  final LocaleController scope;
  const _CreateGroupButton({this.onTap, required this.isLight, required this.scope});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        highlightColor: AxnColors.rowBg(isLight),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AxnColors.dashedBorder(isLight), width: 1.6),
          ),
          child: Center(
            child: Text(
              scope.t('profile_createGroup'),
              style: AxnText.playfair(size: 14, weight: FontWeight.w700, color: AxnColors.createGroupText(isLight), isArabic: scope.isArabic),
            ),
          ),
        ),
      ),
    );
  }
}

class _Shimmer extends StatefulWidget {
  const _Shimmer({required this.child, required this.isLight});

  final Widget child;
  final bool isLight;

  @override
  State<_Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<_Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: IgnorePointer(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AnimatedBuilder(
                animation: _ctrl,
                builder: (context, _) {
                  final t = _ctrl.value;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1.6 + (t * 3.2), 0),
                        end: Alignment(-0.6 + (t * 3.2), 0),
                        colors: [
                          Colors.transparent,
                          AxnColors.navy(widget.isLight).withValues(alpha: 0.16),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isLight;
  final LocaleController scope;
  const _LogoutButton({this.onTap, required this.isLight, required this.scope});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AxnColors.dangerBg(isLight),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Text(
            scope.t('profile_logout'),
            style: AxnText.playfair(size: 15, weight: FontWeight.w700, color: AxnColors.dangerTx(isLight), isArabic: scope.isArabic),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// DEMO DATA MODELS — My Visits & Legacy Capsule
// ============================================================================
enum SafetyEvent { none, sos, smartExit }

@immutable
class CapsuleMemory {
  final String id;
  final String location;
  final String date;
  final String caption;
  final List<Color> photoGradient;

  const CapsuleMemory({
    required this.id,
    required this.location,
    required this.date,
    required this.caption,
    required this.photoGradient,
  });
}

@immutable
class VisitItem {
  final String id;
  final String location;
  final String date;
  final String? groupName;
  final String? capsuleId;
  final SafetyEvent safety;

  const VisitItem({
    required this.id,
    required this.location,
    required this.date,
    this.groupName,
    this.capsuleId,
    this.safety = SafetyEvent.none,
  });
}

const List<CapsuleMemory> demoCapsules = [
  CapsuleMemory(
    id: 'cap-1',
    location: 'Hussain Stadium, Amra City',
    date: '14 March 2026',
    caption:
        'أول مرة أزور هالمكان مع صحابي — طاقة رهيبة بالمدرجات وقت المباراة، لازم نرجع نفس المكان بالموسم الجاي.',
    photoGradient: [Color(0xFFF3C570), Color(0xFFC97B4A)],
  ),
];

const List<VisitItem> demoVisits = [
  VisitItem(
    id: 'v1',
    location: 'Hussain Stadium, Amra City',
    date: '14 March 2026',
    groupName: 'Petra weekend',
    capsuleId: 'cap-1',
    safety: SafetyEvent.smartExit,
  ),
  VisitItem(
    id: 'v2',
    location: 'Wadi Rum Desert Camp',
    date: '2 February 2026',
  ),
  VisitItem(
    id: 'v3',
    location: 'Petra — Treasury',
    date: '18 January 2026',
    groupName: 'Petra weekend',
    safety: SafetyEvent.sos,
  ),
];

// ============================================================================
// MY VISITS SCREEN
// ============================================================================
class VisitsScreen extends StatelessWidget {
  final List<VisitItem> visits;
  final List<CapsuleMemory> capsules;

  const VisitsScreen({
    super.key,
    this.visits = demoVisits,
    this.capsules = demoCapsules,
  });

  CapsuleMemory? _capsuleFor(String? id) {
    if (id == null) return null;
    for (final c in capsules) {
      if (c.id == id) return c;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final scope = AppScope.of(context);
    final title = scope.isArabic ? 'زياراتي' : 'My Visits';
    final desc = scope.isArabic
        ? 'كل مكان سجّلت زيارته عبر AXN — مع صورة ذكرى محفوظة أو خط المسار يلي مشيته، بالإضافة لشارة إذا استخدمت SOS أو Smart Exit. محفوظ محليًا على جهازك فقط.'
        : "Every place you've checked into with AXN — with a saved memory photo or your walked route, plus a badge if SOS or Smart Exit was used. Stored locally on your device.";

    return Scaffold(
      backgroundColor: AxnColors.bg(isLight),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(22, 6, 22, 0),
              child: Row(
                children: [
                  Material(
                    color: AxnColors.rowBg(isLight),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(child: AxnSvgIcons.backArrow(color: AxnColors.ink(isLight), size: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    title,
                    style: AxnText.playfair(size: 21, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: scope.isArabic),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 18, 22, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      desc,
                      style: AxnText.playfair(size: 12.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.7, isArabic: scope.isArabic),
                    ),
                    const SizedBox(height: 18),
                    if (visits.isEmpty)
                      _VisitsEmptyState(isLight: isLight, scope: scope)
                    else
                      for (int i = 0; i < visits.length; i++)
                        _TimelineItem(
                          visit: visits[i],
                          capsule: _capsuleFor(visits[i].capsuleId),
                          isLast: i == visits.length - 1,
                          isLight: isLight,
                          scope: scope,
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

class _VisitsEmptyState extends StatelessWidget {
  final bool isLight;
  final LocaleController scope;
  const _VisitsEmptyState({required this.isLight, required this.scope});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.fromSTEB(10, 26, 10, 30),
      decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [Color(0xFFCFEFE6), Color(0xFFE4EFFC)]),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            scope.isArabic ? 'ما في زيارات بعد' : 'No visits yet',
            style: AxnText.playfair(size: 15, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: scope.isArabic),
          ),
          const SizedBox(height: 6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 230),
            child: Text(
              scope.isArabic
                  ? 'الأماكن يلي بتسجل دخولك فيها بتظهر هون كتايم لاين، سواء لحالك أو مع قروب.'
                  : "Places you check into will show up here as a timeline, whether you're solo or in a group.",
              textAlign: TextAlign.center,
              style: AxnText.playfair(size: 12.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.6, isArabic: scope.isArabic),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final VisitItem visit;
  final CapsuleMemory? capsule;
  final bool isLast;
  final bool isLight;
  final LocaleController scope;

  const _TimelineItem({
    required this.visit,
    required this.capsule,
    required this.isLast,
    required this.isLight,
    required this.scope,
  });

  void _openMemory(BuildContext context) {
    if (capsule == null) return;
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => CapsuleFoundScreen(capsule: capsule!)));
  }

  @override
  Widget build(BuildContext context) {
    final dotColor = AxnColors.tealDeep(isLight);
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: isLast ? 0 : 20),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 22,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: dotColor,
                      boxShadow: [const BoxShadow(color: Color(0xFFFBE3E5), blurRadius: 0, spreadRadius: 3)],
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 1.6,
                        color: AxnColors.line(isLight),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    visit.date,
                    style: AxnText.playfair(size: 11, weight: FontWeight.w600, color: AxnColors.muted(isLight)),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: capsule != null ? () => _openMemory(context) : null,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: SizedBox(
                              height: 118,
                              width: double.infinity,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  if (capsule != null)
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: capsule!.photoGradient,
                                        ),
                                      ),
                                    )
                                  else
                                    _RouteSketch(seed: visit.id),
                                  if (visit.safety != SafetyEvent.none)
                                    PositionedDirectional(
                                      top: 9,
                                      start: 9,
                                      child: Container(
                                        width: 26,
                                        height: 26,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: visit.safety == SafetyEvent.sos ? const Color(0xFFD65D6B) : const Color(0xFF149C87),
                                          border: Border.all(color: Colors.white.withValues(alpha: 0.85), width: 2),
                                        ),
                                        child: Center(
                                          child: visit.safety == SafetyEvent.sos
                                              ? AxnSvgIcons.sosAlert(size: 13)
                                              : AxnSvgIcons.smartExit(size: 13),
                                        ),
                                      ),
                                    ),
                                  PositionedDirectional(
                                    bottom: 0,
                                    start: 0,
                                    end: 0,
                                    child: Container(
                                      padding: const EdgeInsetsDirectional.fromSTEB(12, 24, 12, 9),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [Colors.black.withValues(alpha: 0.62), Colors.transparent],
                                        ),
                                      ),
                                      child: Text(
                                        visit.location,
                                        style: AxnText.playfair(size: 14, weight: FontWeight.w700, color: Colors.white, isArabic: scope.isArabic),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 2),
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              if (visit.groupName != null)
                                _VisitPill(
                                  text: visit.groupName!,
                                  bg: AxnColors.groupBg(isLight),
                                  tx: AxnColors.groupTx(isLight),
                                  isArabic: scope.isArabic,
                                )
                              else
                                _VisitPill(
                                  text: scope.isArabic ? 'زيارة فردية' : 'Solo visit',
                                  bg: AxnColors.icGray(isLight),
                                  tx: AxnColors.createGroupText(isLight),
                                  isArabic: scope.isArabic,
                                ),
                              if (capsule != null)
                                _VisitPill(
                                  text: scope.isArabic ? '📦 ذكرى محفوظة' : '📦 Memory saved',
                                  bg: const Color(0xFFDEF6F0),
                                  tx: const Color(0xFF149C87),
                                  isArabic: scope.isArabic,
                                ),
                              if (capsule != null)
                                GestureDetector(
                                  onTap: () => _openMemory(context),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AxnSvgIcons.shareSquare(color: AxnColors.tealDeep(isLight), size: 13),
                                      const SizedBox(width: 5),
                                      Text(
                                        scope.isArabic ? 'شارك هالذكرى' : 'Share this memory',
                                        style: AxnText.playfair(size: 11, weight: FontWeight.w700, color: AxnColors.tealDeep(isLight), isArabic: scope.isArabic),
                                      ),
                                    ],
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
            ),
          ],
        ),
      ),
    );
  }
}

class _RouteSketch extends StatelessWidget {
  final String seed;
  const _RouteSketch({required this.seed});

  @override
  Widget build(BuildContext context) {
    final s = seed.codeUnitAt(seed.length - 1) + seed.length;
    final x1 = 24.0 + (s % 18), y1 = 78.0 - (s % 26);
    final x2 = 176.0 - (s % 22), y2 = 26.0 + (s % 20);
    final midY = (y1 < y2 ? y1 : y2) - 22 < 10 ? 10.0 : (y1 < y2 ? y1 : y2) - 22;

    return CustomPaint(
      painter: _RoutePainter(x1: x1, y1: y1, x2: x2, y2: y2, midY: midY),
      child: Container(color: const Color(0xFFEFEDE6)),
    );
  }
}

class _RoutePainter extends CustomPainter {
  final double x1, y1, x2, y2, midY;
  _RoutePainter({required this.x1, required this.y1, required this.x2, required this.y2, required this.midY});

  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 200;
    final sy = size.height / 118;
    Offset p(double x, double y) => Offset(x * sx, y * sy);

    final gridPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.05)
      ..strokeWidth = 1;
    for (final y in [30.0, 60.0, 90.0]) {
      canvas.drawLine(p(0, y), p(200, y), gridPaint);
    }
    for (final x in [40.0, 90.0, 140.0]) {
      canvas.drawLine(p(x, 0), p(x, 118), gridPaint);
    }

    final path = Path()
      ..moveTo(p(x1, y1).dx, p(x1, y1).dy)
      ..quadraticBezierTo(p((x1 + x2) / 2, midY).dx, p((x1 + x2) / 2, midY).dy, p(x2, y2).dx, p(x2, y2).dy);
    final routePaint = Paint()
      ..color = const Color(0xFF8B1E2E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(_dashPath(path, dashLength: 1, gapLength: 7), routePaint);

    canvas.drawCircle(p(x1, y1), 5, Paint()..color = const Color(0xFF8B1E2E));
    canvas.drawCircle(p(x2, y2), 5, Paint()..color = const Color(0xFF149C87));
  }

  Path _dashPath(Path source, {required double dashLength, required double gapLength}) {
    final dest = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      bool draw = true;
      while (distance < metric.length) {
        final len = draw ? dashLength : gapLength;
        final next = (distance + len).clamp(0, metric.length).toDouble();
        if (draw) dest.addPath(metric.extractPath(distance, next), Offset.zero);
        distance = next;
        draw = !draw;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) => false;
}

class _VisitPill extends StatelessWidget {
  final String text;
  final Color bg;
  final Color tx;
  final bool isArabic;
  const _VisitPill({required this.text, required this.bg, required this.tx, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: AxnText.playfair(size: 11, weight: FontWeight.w600, color: tx, isArabic: isArabic)),
    );
  }
}

// ============================================================================
// LEGACY CAPSULE SCREEN (HUB)
// ============================================================================
class LegacyCapsuleScreen extends StatefulWidget {
  final List<CapsuleMemory> capsules;
  const LegacyCapsuleScreen({super.key, this.capsules = demoCapsules});

  @override
  State<LegacyCapsuleScreen> createState() => _LegacyCapsuleScreenState();
}

class _LegacyCapsuleScreenState extends State<LegacyCapsuleScreen> {
  late List<CapsuleMemory> _capsules = List.of(widget.capsules);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final scope = AppScope.of(context);
    final title = scope.isArabic ? 'كبسولة الذكريات' : 'Legacy Capsule';
    final desc = scope.isArabic
        ? 'احفظ صورة وكم كلمة بأي مكان تزوره. كل شي بضل على جهازك — ما في شي بيترفع. ارجع لنفس المكان، حتى بعد سنين، وبتلاقيه بانتظارك.'
        : "Save a photo and a few words at any place you visit. Everything stays on your device — nothing is uploaded. Come back to the same spot, even years later, and it's waiting for you.";

    return Scaffold(
      backgroundColor: AxnColors.bg(isLight),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(22, 6, 22, 0),
              child: Row(
                children: [
                  Material(
                    color: AxnColors.rowBg(isLight),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(child: AxnSvgIcons.backArrow(color: AxnColors.ink(isLight), size: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    title,
                    style: AxnText.playfair(size: 21, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: scope.isArabic),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 18, 22, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      desc,
                      style: AxnText.playfair(size: 12.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.7, isArabic: scope.isArabic),
                    ),
                    const SizedBox(height: 18),
                    if (_capsules.isNotEmpty) _NotifyBanner(capsule: _capsules.first, isLight: isLight, scope: scope),
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 2, vertical: 6),
                      child: Text(
                        scope.isArabic ? 'محفوظة على هالجهاز' : 'Saved on this device',
                        style: AxnText.playfair(size: 12, weight: FontWeight.w600, color: AxnColors.muted(isLight), isArabic: scope.isArabic),
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (_capsules.isEmpty)
                      _CapsuleEmptyState(isLight: isLight, scope: scope)
                    else
                      for (final c in _capsules)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(bottom: 12),
                          child: _CapsuleCard(capsule: c, isLight: isLight, scope: scope),
                        ),
                    const SizedBox(height: 8),
                    _CreateMemoryButton(
                      isLight: isLight,
                      scope: scope,
                      onCreated: (memory) => setState(() => _capsules = [memory, ..._capsules]),
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

class _NotifyBanner extends StatelessWidget {
  final CapsuleMemory capsule;
  final bool isLight;
  final LocaleController scope;
  const _NotifyBanner({required this.capsule, required this.isLight, required this.scope});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CapsuleFoundScreen(capsule: capsule))),
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(colors: [Color(0xFF3B0A12), Color(0xFF6B1420)]),
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.14), shape: BoxShape.circle),
                  child: const Center(child: Text('📍', style: TextStyle(fontSize: 16))),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        scope.isArabic ? 'لقينا ذكرى هون — ${capsule.date}' : 'Found a memory here — ${capsule.date}',
                        style: AxnText.playfair(size: 13.5, weight: FontWeight.w700, color: Colors.white, isArabic: scope.isArabic),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        scope.isArabic ? 'محاكاة للعرض · اضغط لمعاينة شكل الذكرى الحقيقية' : 'Simulated for demo · tap to preview what a real revisit would show',
                        style: AxnText.playfair(size: 11.5, weight: FontWeight.w400, color: Colors.white.withValues(alpha: 0.6), isArabic: scope.isArabic),
                      ),
                    ],
                  ),
                ),
                Opacity(opacity: 0.5, child: AxnSvgIcons.chevron(color: Colors.white, size: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CapsuleCard extends StatelessWidget {
  final CapsuleMemory capsule;
  final bool isLight;
  final LocaleController scope;
  const _CapsuleCard({required this.capsule, required this.isLight, required this.scope});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AxnColors.rowBg(isLight),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CapsuleFoundScreen(capsule: capsule))),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: capsule.photoGradient),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        capsule.location,
                        style: AxnText.playfair(size: 13.5, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: scope.isArabic),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        capsule.date,
                        style: AxnText.playfair(size: 11, weight: FontWeight.w400, color: AxnColors.muted(isLight)),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        capsule.caption,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AxnText.playfair(size: 12, weight: FontWeight.w400, color: const Color(0xFF6B6255), height: 1.5, isArabic: true),
                      ),
                    ],
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

class _CapsuleEmptyState extends StatelessWidget {
  final bool isLight;
  final LocaleController scope;
  const _CapsuleEmptyState({required this.isLight, required this.scope});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.fromSTEB(10, 26, 10, 30),
      decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [Color(0xFFCFEFE6), Color(0xFFE4EFFC)]),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            scope.isArabic ? 'ما في ذكريات بعد' : 'No memories yet',
            style: AxnText.playfair(size: 15, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: scope.isArabic),
          ),
          const SizedBox(height: 6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 230),
            child: Text(
              scope.isArabic
                  ? 'احفظ صورة وتعليق بآخر أي زيارة — بتضل هون بانتظارك المرة الجاية يلي بترجع فيها.'
                  : "Save a photo and a caption at the end of a visit — it'll be waiting here next time you're back.",
              textAlign: TextAlign.center,
              style: AxnText.playfair(size: 12.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.6, isArabic: scope.isArabic),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateMemoryButton extends StatelessWidget {
  final bool isLight;
  final LocaleController scope;
  final ValueChanged<CapsuleMemory> onCreated;
  const _CreateMemoryButton({required this.isLight, required this.scope, required this.onCreated});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          final created = await Navigator.of(context).push<CapsuleMemory>(
            MaterialPageRoute(builder: (_) => const _CapsuleCreateScreen()),
          );
          if (created != null) onCreated(created);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AxnColors.dashedBorder(isLight), width: 1.6),
          ),
          child: Center(
            child: Text(
              scope.isArabic ? '＋  احفظ ذكرى هون' : '＋  Save a memory here',
              style: AxnText.playfair(size: 14, weight: FontWeight.w700, color: AxnColors.createGroupText(isLight), isArabic: scope.isArabic),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// CAPSULE CREATE SCREEN
// ============================================================================
class _CapsuleCreateScreen extends StatefulWidget {
  const _CapsuleCreateScreen();

  @override
  State<_CapsuleCreateScreen> createState() => _CapsuleCreateScreenState();
}

class _CapsuleCreateScreenState extends State<_CapsuleCreateScreen> {
  static const _gradients = [
    [Color(0xFFCFEFE6), Color(0xFF7FC9B8)],
    [Color(0xFFE4EFFC), Color(0xFF8FADE0)],
    [Color(0xFFFCE3E9), Color(0xFFE093A8)],
    [Color(0xFFF7E3C4), Color(0xFFD9A85C)],
  ];

  List<Color>? _photo;
  final _captionCtrl = TextEditingController();

  @override
  void dispose() {
    _captionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final scope = AppScope.of(context);
    const locationName = 'Hussain Stadium, Amra City';

    return Scaffold(
      backgroundColor: AxnColors.bg(isLight),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(22, 6, 22, 0),
              child: Row(
                children: [
                  Material(
                    color: AxnColors.rowBg(isLight),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(child: AxnSvgIcons.backArrow(color: AxnColors.ink(isLight), size: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    scope.isArabic ? 'احفظ ذكرى' : 'Save a memory',
                    style: AxnText.playfair(size: 21, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: scope.isArabic),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 18, 22, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _photo = _gradients[(_captionCtrl.text.length + 1) % _gradients.length]),
                      child: Container(
                        width: double.infinity,
                        height: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AxnColors.rowBg(isLight),
                          border: _photo == null ? Border.all(color: const Color(0xFFD8D4CB), width: 1.6) : null,
                          gradient: _photo != null
                              ? LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: _photo!)
                              : null,
                        ),
                        child: _photo == null
                            ? Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('📷', style: TextStyle(fontSize: 26)),
                                    const SizedBox(height: 8),
                                    Text(
                                      scope.isArabic ? 'ضيف صورة — كاميرا أو معرض' : 'Add a photo — camera or gallery',
                                      style: AxnText.playfair(size: 12.5, weight: FontWeight.w600, color: AxnColors.muted(isLight), isArabic: scope.isArabic),
                                    ),
                                  ],
                                ),
                              )
                            : Align(
                                alignment: AlignmentDirectional.bottomStart,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.55),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      scope.isArabic ? 'تمت إضافة الصورة' : 'Photo added',
                                      style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      scope.isArabic ? 'التعليق' : 'Your caption',
                      style: AxnText.playfair(size: 12.5, weight: FontWeight.w600, color: AxnColors.muted(isLight), isArabic: scope.isArabic),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(16)),
                      child: TextField(
                        controller: _captionCtrl,
                        maxLines: 4,
                        minLines: 3,
                        textDirection: scope.isArabic ? TextDirection.rtl : TextDirection.ltr,
                        decoration: InputDecoration(
                          hintText: scope.isArabic ? 'مثلاً: أول مرة أزور هالمكان مع صحابي...' : 'e.g. First time visiting this spot with friends...',
                          hintStyle: AxnText.playfair(size: 13, weight: FontWeight.w400, color: AxnColors.muted(isLight), isArabic: scope.isArabic),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                        style: AxnText.playfair(size: 14, weight: FontWeight.w400, color: AxnColors.ink(isLight), isArabic: scope.isArabic),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(color: AxnColors.groupBg(isLight), borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('📍', style: TextStyle(fontSize: 13)),
                          const SizedBox(width: 6),
                          Text(
                            locationName,
                            style: AxnText.playfair(size: 12, weight: FontWeight.w700, color: AxnColors.groupTx(isLight)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                      decoration: BoxDecoration(color: const Color(0xFFFBEDEE), borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('🔒', style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              scope.isArabic
                                  ? 'محفوظة محليًا على تلفونك بس، مربوطة بهالمكان بالتحديد. ما في سيرفر، ما في كلاود، ما حدا ثاني بيقدر يشوفها.'
                                  : 'Saved locally on your phone only, tied to this exact spot. No server, no cloud, no one else can see it.',
                              style: AxnText.playfair(size: 11.5, weight: FontWeight.w400, color: const Color(0xFF7A2130), height: 1.6, isArabic: scope.isArabic),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
              child: SizedBox(
                width: double.infinity,
                child: Material(
                  color: AxnColors.tealDeep(isLight),
                  borderRadius: BorderRadius.circular(18),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      final memory = CapsuleMemory(
                        id: 'cap-${DateTime.now().millisecondsSinceEpoch}',
                        location: locationName,
                        date: scope.isArabic ? 'اليوم' : 'Today',
                        caption: _captionCtrl.text.trim().isEmpty
                            ? (scope.isArabic ? 'ذكرى بدون تعليق' : 'A memory with no caption')
                            : _captionCtrl.text.trim(),
                        photoGradient: _photo ?? _gradients.first,
                      );
                      Navigator.of(context).pop(memory);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          scope.isArabic ? 'احفظ الذكرى' : 'Save memory',
                          style: AxnText.playfair(size: 14.5, weight: FontWeight.w700, color: Colors.white, isArabic: scope.isArabic),
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
}

// ============================================================================
// CAPSULE FOUND SCREEN
// ============================================================================
class CapsuleFoundScreen extends StatelessWidget {
  final CapsuleMemory capsule;
  const CapsuleFoundScreen({super.key, required this.capsule});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final scope = AppScope.of(context);

    return Scaffold(
      backgroundColor: AxnColors.bg(isLight),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(22, 6, 22, 0),
              child: Row(
                children: [
                  Material(
                    color: AxnColors.rowBg(isLight),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(child: AxnSvgIcons.backArrow(color: AxnColors.ink(isLight), size: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    scope.isArabic ? 'ذكرى من هون' : 'A memory from here',
                    style: AxnText.playfair(size: 19, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: scope.isArabic),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 18, 22, 24),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        children: [
                          Container(
                            height: 260,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: capsule.photoGradient),
                            ),
                          ),
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [Colors.black.withValues(alpha: 0.55), Colors.transparent],
                                  stops: const [0, 0.45],
                                ),
                              ),
                            ),
                          ),
                          PositionedDirectional(
                            top: 14,
                            start: 14,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.92), borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                scope.isArabic ? '📍 وصلت هون كمان مرة' : "📍 You're here again",
                                style: AxnText.playfair(size: 11, weight: FontWeight.w700, color: AxnColors.ink(isLight)),
                              ),
                            ),
                          ),
                          PositionedDirectional(
                            bottom: 14,
                            end: 14,
                            child: Text(
                              capsule.date,
                              textAlign: TextAlign.end,
                              style: AxnText.playfair(size: 13, weight: FontWeight.w700, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        capsule.location,
                        style: AxnText.playfair(size: 21, weight: FontWeight.w500, color: AxnColors.ink(isLight), isArabic: scope.isArabic),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(18)),
                      child: Text(
                        capsule.caption,
                        textAlign: TextAlign.start,
                        style: AxnText.playfair(size: 13.5, weight: FontWeight.w400, color: const Color(0xFF4A4436), height: 1.75, isArabic: true),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
              child: SizedBox(
                width: double.infinity,
                child: Material(
                  color: AxnColors.rowBg(isLight),
                  borderRadius: BorderRadius.circular(18),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          scope.isArabic ? 'إغلاق' : 'Close',
                          style: AxnText.playfair(size: 14.5, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: scope.isArabic),
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
}

// ============================================================================
// PRIVACY & DATA SCREEN
// ============================================================================
class PrivacyDataScreen extends StatefulWidget {
  final int groupsCount;
  final int groupsMemberCount;
  final List<CapsuleMemory> capsules;
  final List<VisitItem> visits;
  final VoidCallback? onDeleteAllData;

  const PrivacyDataScreen({
    super.key,
    this.groupsCount = 2,
    this.groupsMemberCount = 7,
    this.capsules = demoCapsules,
    this.visits = demoVisits,
    this.onDeleteAllData,
  });

  @override
  State<PrivacyDataScreen> createState() => _PrivacyDataScreenState();
}

class _PrivacyDataScreenState extends State<PrivacyDataScreen> {
  late List<CapsuleMemory> _capsules = List.of(widget.capsules);
  late List<VisitItem> _visits = List.of(widget.visits);
  late int _groupsCount = widget.groupsCount;

  String _capsuleSub(bool ar) => _capsules.isEmpty
      ? (ar ? 'ما في ذكريات محفوظة بعد' : 'No memories saved yet')
      : ar
          ? '${_capsules.length} ذكريات · صور وتعليقات'
          : '${_capsules.length} ${_capsules.length == 1 ? 'memory' : 'memories'} · photos & captions';

  String _visitSub(bool ar) => _visits.isEmpty
      ? (ar ? 'ما في زيارات مسجّلة بعد' : 'No visits logged yet')
      : ar
          ? '${_visits.length} زيارات مسجّلة'
          : '${_visits.length} ${_visits.length == 1 ? 'visit' : 'visits'} logged';

  String _groupsSub(bool ar) => ar
      ? '$_groupsCount قروبات · ${widget.groupsMemberCount} بروفايل عضو'
      : '$_groupsCount groups · ${widget.groupsMemberCount} member profiles';

  Future<void> _confirmDelete(bool isLight, bool ar) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ar ? 'حذف كل البيانات المحلية؟' : 'Delete all local data?'),
        content: Text(
          ar
              ? "بيشيل ذكرياتك المحفوظة، سجل الزيارات، وبيانات القروبات المخزّنة من هالجهاز. ما بينرجع، وما بيأثر على أجهزة الأعضاء الثانيين."
              : "This removes your saved memories, visit history and cached group data from this device. This can't be undone.",
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text(ar ? 'إلغاء' : 'Cancel')),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(ar ? 'حذف' : 'Delete', style: const TextStyle(color: Color(0xFFD65D6B))),
          ),
        ],
      ),
    );
    if (ok != true) return;

    setState(() {
      _capsules = [];
      _visits = [];
    });
    widget.onDeleteAllData?.call();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ar ? 'تم حذف كل البيانات المحلية من هالجهاز.' : 'All local data has been deleted from this device.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final scope = AppScope.of(context);
    final ar = scope.isArabic;

    return Scaffold(
      backgroundColor: AxnColors.bg(isLight),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(22, 6, 22, 0),
              child: Row(
                children: [
                  Material(
                    color: AxnColors.rowBg(isLight),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(child: AxnSvgIcons.backArrow(color: AxnColors.ink(isLight), size: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    ar ? 'الخصوصية والبيانات' : 'Privacy & Data',
                    style: AxnText.playfair(size: 20, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: ar),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 18, 22, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                      decoration: BoxDecoration(color: const Color(0xFFFBEDEE), borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('🔒', style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              ar
                                  ? 'AXN بتحتفظ بهالمعلومات على تلفونك بس. ما في شي هون بيترفع لسيرفر أو يظهر لحدا ثاني — إلا إذا اخترت تشاركه جوا قروب.'
                                  : "AXN keeps this information on your phone only. Nothing here is uploaded to a server or visible to anyone else — unless you choose to share it inside a group.",
                              style: AxnText.playfair(size: 11.5, weight: FontWeight.w400, color: const Color(0xFF7A2130), height: 1.6, isArabic: ar),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 2, vertical: 6),
                      child: Text(
                        ar ? 'محفوظ على هالجهاز' : 'Stored on this device',
                        style: AxnText.playfair(size: 12, weight: FontWeight.w600, color: AxnColors.muted(isLight), isArabic: ar),
                      ),
                    ),
                    const SizedBox(height: 4),
                    _Row(
                      iconBg: AxnColors.capsuleBoxBg(isLight),
                      icon: const Text('📦', style: TextStyle(fontSize: 16)),
                      title: ar ? 'ذكريات Legacy Capsule' : 'Legacy Capsule memories',
                      subtitle: _capsuleSub(ar),
                      isLight: isLight,
                      ar: ar,
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LegacyCapsuleScreen(capsules: _capsules))),
                    ),
                    const SizedBox(height: 10),
                    _Row(
                      iconBg: AxnColors.blueBg(isLight),
                      icon: AxnSvgIcons.pin(color: AxnColors.blueTx(isLight)),
                      title: ar ? 'سجل الزيارات' : 'Visit history',
                      subtitle: _visitSub(ar),
                      isLight: isLight,
                      ar: ar,
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => VisitsScreen(visits: _visits, capsules: _capsules))),
                    ),
                    const SizedBox(height: 10),
                    _Row(
                      iconBg: AxnColors.icGray(isLight),
                      icon: const Icon(Icons.people_outline, size: 18, color: Color(0xFF6B6255)),
                      title: ar ? 'القروبات وبيانات الأعضاء' : 'Groups & member details',
                      subtitle: _groupsSub(ar),
                      isLight: isLight,
                      ar: ar,
                      onTap: null,
                    ),
                    const SizedBox(height: 26),
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 2, vertical: 6),
                      child: Text(
                        ar ? 'منطقة الخطر' : 'Danger zone',
                        style: AxnText.playfair(size: 12, weight: FontWeight.w600, color: AxnColors.muted(isLight), isArabic: ar),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Material(
                      color: AxnColors.dangerBg(isLight),
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => _confirmDelete(isLight, ar),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Center(
                            child: Text(
                              ar ? 'حذف كل البيانات المحلية' : 'Delete all local data',
                              style: AxnText.playfair(size: 13.5, weight: FontWeight.w700, color: AxnColors.dangerTx(isLight), isArabic: ar),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      ar
                          ? 'بيحذف نهائيًا ذكرياتك المحفوظة، سجل الزيارات، وبيانات القروبات المخزّنة من هالجهاز. ما بينرجع، وما بيأثر على أجهزة الأعضاء الثانيين.'
                          : "Permanently deletes your saved memories, visit history and cached group data from this device. This can't be undone and doesn't affect other members' devices.",
                      style: AxnText.playfair(size: 11.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.7, isArabic: ar),
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

class _Row extends StatelessWidget {
  final Color iconBg;
  final Widget? icon;
  final String title;
  final String subtitle;
  final bool isLight;
  final bool ar;
  final VoidCallback? onTap;

  const _Row({
    required this.iconBg,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isLight,
    required this.ar,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AxnColors.rowBg(isLight),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                child: icon != null ? Center(child: icon) : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: AxnText.playfair(size: 14.5, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: ar)),
                    const SizedBox(height: 1),
                    Text(subtitle, style: AxnText.playfair(size: 12, weight: FontWeight.w400, color: AxnColors.muted(isLight), isArabic: ar)),
                  ],
                ),
              ),
              if (onTap != null) Opacity(opacity: 0.35, child: AxnSvgIcons.chevron(color: AxnColors.ink(isLight), size: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// EDIT PROFILE SCREEN
// ============================================================================
class EditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialUsername;
  final String phoneNumber;
  final ValueChanged<String>? onNameChanged;
  final ValueChanged<String>? onUsernameChanged;

  const EditProfileScreen({
    super.key,
    required this.initialName,
    required this.initialUsername,
    required this.phoneNumber,
    this.onNameChanged,
    this.onUsernameChanged,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _usernameCtrl;
  List<Color>? _selectedPhotoGradient;

  static const _gradients = [
    [Color(0xFFCFEFE6), Color(0xFF7FC9B8)],
    [Color(0xFFE4EFFC), Color(0xFF8FADE0)],
    [Color(0xFFFCE3E9), Color(0xFFE093A8)],
    [Color(0xFFF7E3C4), Color(0xFFD9A85C)],
  ];

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialName);
    _usernameCtrl = TextEditingController(text: '@${widget.initialUsername}');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _usernameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final scope = AppScope.of(context);
    final ar = scope.isArabic;

    return Scaffold(
      backgroundColor: AxnColors.bg(isLight),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(22, 6, 22, 0),
              child: Row(
                children: [
                  Material(
                    color: AxnColors.rowBg(isLight),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(child: AxnSvgIcons.backArrow(color: AxnColors.ink(isLight), size: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    ar ? 'تعديل الملف الشخصي' : 'Edit profile',
                    style: AxnText.playfair(size: 20, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: ar),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 18, 22, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPhotoGradient = _gradients[DateTime.now().millisecondsSinceEpoch % _gradients.length];
                        });
                      },
                      child: Container(
                        width: 96,
                        height: 96,
                        margin: const EdgeInsets.only(top: 10, bottom: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AxnColors.rowBg(isLight),
                          border: _selectedPhotoGradient == null ? Border.all(color: const Color(0xFFD8D4CB), width: 1.6) : null,
                          gradient: _selectedPhotoGradient != null
                              ? LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: _selectedPhotoGradient!)
                              : null,
                        ),
                        child: _selectedPhotoGradient == null
                            ? Center(child: Text('📷', style: TextStyle(fontSize: 24, color: AxnColors.muted(isLight))))
                            : null,
                      ),
                    ),
                    Text(
                      ar ? 'اضغط لتغيير الصورة' : 'Tap to change photo — camera or gallery',
                      style: AxnText.playfair(size: 12, weight: FontWeight.w400, color: AxnColors.muted(isLight), isArabic: ar),
                    ),
                    const SizedBox(height: 24),
                    _buildField(ar ? 'الاسم الكامل' : 'Full name', _nameCtrl, false, isLight, ar),
                    _buildField(ar ? 'اسم المستخدم' : 'Username', _usernameCtrl, false, isLight, ar, isLtr: true),
                    _buildField(ar ? 'رقم الهاتف' : 'Phone number', TextEditingController(text: widget.phoneNumber), true, isLight, ar, isLtr: true),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        ar ? 'رقم هاتفك موثّق ولا يمكن تغييره من هنا. تواصل مع الدعم إذا كان هناك خطأ.' : 'Your phone number is verified and can\'t be changed here. Contact support if it\'s incorrect.',
                        style: AxnText.playfair(size: 11.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.6, isArabic: ar),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
              child: SizedBox(
                width: double.infinity,
                child: Material(
                  color: AxnColors.tealDeep(isLight),
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      if (widget.onNameChanged != null) widget.onNameChanged!(_nameCtrl.text);
                      if (widget.onUsernameChanged != null) widget.onUsernameChanged!(_usernameCtrl.text.replaceAll('@', ''));
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          ar ? 'حفظ التغييرات' : 'Save changes',
                          style: AxnText.playfair(size: 15, weight: FontWeight.w700, color: Colors.white, isArabic: ar),
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

  Widget _buildField(String label, TextEditingController ctrl, bool disabled, bool isLight, bool ar, {bool isLtr = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AxnText.playfair(size: 12.5, weight: FontWeight.w600, color: const Color(0xFF6B6255), isArabic: ar),
        ),
        const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(16)),
          child: TextField(
            controller: ctrl,
            enabled: !disabled,
            textDirection: isLtr ? TextDirection.ltr : (ar ? TextDirection.rtl : TextDirection.ltr),
            textAlign: isLtr ? (ar ? TextAlign.right : TextAlign.left) : TextAlign.start,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            style: AxnText.playfair(size: 14.5, weight: FontWeight.w500, color: disabled ? AxnColors.muted(isLight) : AxnColors.ink(isLight), isArabic: ar),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// PERSONAL INFORMATION SCREEN
// ============================================================================
class PersonalInfoScreen extends StatelessWidget {
  final String name;
  final String username;
  final String phoneNumber;
  final String tier;

  const PersonalInfoScreen({
    super.key,
    required this.name,
    required this.username,
    required this.phoneNumber,
    required this.tier,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final scope = AppScope.of(context);
    final ar = scope.isArabic;

    return Scaffold(
      backgroundColor: AxnColors.bg(isLight),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(22, 6, 22, 0),
              child: Row(
                children: [
                  Material(
                    color: AxnColors.rowBg(isLight),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(child: AxnSvgIcons.backArrow(color: AxnColors.ink(isLight), size: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    ar ? 'المعلومات الشخصية' : 'Personal information',
                    style: AxnText.playfair(size: 20, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: ar),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 18, 22, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 6),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AxnColors.rowBg(isLight), width: 2.5),
                              gradient: const LinearGradient(begin: Alignment(-0.8, -0.6), end: Alignment(0.8, 0.6), colors: [Color(0xFFF3E9EA), Color(0xFFE9DEDB)]),
                            ),
                            child: Center(child: AxnSvgIcons.personOutline(color: AxnColors.tealDeep(isLight), size: 24, width: 1.5)),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name, style: AxnText.playfair(size: 15.5, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: ar)),
                                const SizedBox(height: 2),
                                Text('@$username · ${scope.t('rewards_${tier.toLowerCase()}')}', style: AxnText.playfair(size: 12, weight: FontWeight.w400, color: AxnColors.muted(isLight), isArabic: ar)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6, left: 2, right: 2),
                      child: Text(ar ? 'التفاصيل الأساسية' : 'Basic details', style: AxnText.playfair(size: 12, weight: FontWeight.w600, color: AxnColors.muted(isLight), isArabic: ar)),
                    ),
                    _FieldRow(label: ar ? 'الاسم الكامل' : 'Full name', value: name, isLight: isLight, ar: ar),
                    _FieldRow(label: ar ? 'اسم المستخدم' : 'Username', value: '@$username', isLtr: true, isLight: isLight, ar: ar),
                    _FieldRow(label: ar ? 'رقم الهاتف' : 'Phone number', value: phoneNumber, isLtr: true, badgeText: ar ? 'موثق' : 'Verified', badgeColor: AxnColors.phoneVerifBg(isLight), badgeTextColor: AxnColors.phoneVerifTx(isLight), isLight: isLight, ar: ar),
                    _FieldRow(label: ar ? 'البريد الإلكتروني' : 'Email', value: '$username@email.com', isLtr: true, isLight: isLight, ar: ar),
                    
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6, top: 6, left: 2, right: 2),
                      child: Text(ar ? 'الرقم الوطني والتوثيق' : 'National ID & verification', style: AxnText.playfair(size: 12, weight: FontWeight.w600, color: AxnColors.muted(isLight), isArabic: ar)),
                    ),
                    _FieldRow(label: ar ? 'رقم الهوية الوطنية' : 'National ID number', value: '9•• ••• ••••1', isLtr: true, badgeText: ar ? 'موثق' : 'Verified', badgeColor: AxnColors.verifiedBg(isLight), badgeTextColor: AxnColors.verifiedTx(isLight), isLight: isLight, ar: ar),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                      decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(ar ? 'حالة التوثيق' : 'Verification status', style: AxnText.playfair(size: 11.5, weight: FontWeight.w600, color: AxnColors.muted(isLight), isArabic: ar)),
                                const SizedBox(height: 3),
                                Text(ar ? 'موثق بالكامل — هوية + هاتف' : 'Fully verified — ID + phone', style: AxnText.playfair(size: 14, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: ar)),
                              ],
                            ),
                          ),
                          const Icon(Icons.check_circle_outline_rounded, color: Color(0xFF3FA35B), size: 22),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                      child: Text(
                        ar ? 'توثيق الهوية الوطنية يفتح ميزات المجموعات العائلية مثل المناطق الآمنة وتتبع الأطفال. هويتك تُحفظ بشكل آمن ولا تُشارك أبدًا مع الأعضاء الآخرين.' : 'National ID verification unlocks family group features like Safe zones and child tracking. Your ID is stored securely and never shared with other members.',
                        style: AxnText.playfair(size: 11.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.7, isArabic: ar),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
              child: SizedBox(
                width: double.infinity,
                child: Material(
                  color: AxnColors.tealDeep(isLight),
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => EditProfileScreen(initialName: name, initialUsername: username, phoneNumber: phoneNumber))),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          ar ? 'تعديل الملف الشخصي' : 'Edit profile',
                          style: AxnText.playfair(size: 15, weight: FontWeight.w700, color: Colors.white, isArabic: ar),
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
}

class _FieldRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLtr;
  final String? badgeText;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final bool isLight;
  final bool ar;

  const _FieldRow({required this.label, required this.value, this.isLtr = false, this.badgeText, this.badgeColor, this.badgeTextColor, required this.isLight, required this.ar});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AxnText.playfair(size: 11.5, weight: FontWeight.w600, color: AxnColors.muted(isLight), isArabic: ar)),
                const SizedBox(height: 3),
                Text(
                  value,
                  textDirection: isLtr ? TextDirection.ltr : null,
                  style: AxnText.playfair(size: 14, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: ar),
                ),
              ],
            ),
          ),
          if (badgeText != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
              decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(20)),
              child: Text(badgeText!, style: AxnText.playfair(size: 11, weight: FontWeight.w600, color: badgeTextColor!, isArabic: ar)),
            ),
        ],
      ),
    );
  }
}

// ============================================================================
// INVITE & EARN SCREEN
// ============================================================================
class InviteFriendsScreen extends StatefulWidget {
  final String username;
  const InviteFriendsScreen({super.key, required this.username});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  bool _copied = false;
  bool _showQr = false;

  void _copyLink() {
    setState(() => _copied = true);
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final scope = AppScope.of(context);
    final ar = scope.isArabic;
    final inviteLink = 'axn.app/i/${widget.username}';

    final referrals = [
      {'name': 'Huda Kamal', 'date': ar ? 'منذ يومين' : '2 days ago', 'points': 50},
      {'name': 'Omar Tal', 'date': ar ? 'منذ أسبوع' : '1 week ago', 'points': 50},
      {'name': 'Nour Saadi', 'date': ar ? 'منذ أسبوعين' : '2 weeks ago', 'points': 50},
      {'name': 'Rami Amin', 'date': ar ? 'منذ 3 أسابيع' : '3 weeks ago', 'points': 50},
      {'name': 'Lina Amin', 'date': ar ? 'منذ شهر' : '1 month ago', 'points': 50},
    ];

    return Scaffold(
      backgroundColor: AxnColors.bg(isLight),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(22, 6, 22, 0),
              child: Row(
                children: [
                  Material(
                    color: AxnColors.rowBg(isLight),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(child: AxnSvgIcons.backArrow(color: AxnColors.ink(isLight), size: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    ar ? 'دعوة وكسب' : 'Invite & Earn',
                    style: AxnText.playfair(size: 20, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: ar),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 18, 22, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ar ? 'ادعُ أصدقاءك إلى AXN باستخدام رابطك الشخصي أو رمز QR. عندما ينضمون، سيكسب كل منكما نقاطًا — لا يوجد حد لعدد الأصدقاء.' : 'Invite friends to AXN with your personal link or QR Pass. When they join, you both earn points — no limit on how many friends you invite.',
                      style: AxnText.playfair(size: 12.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.7, isArabic: ar),
                    ),
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6, left: 2, right: 2),
                      child: Text(ar ? 'رابط الدعوة الخاص بك' : 'Your invite link', style: AxnText.playfair(size: 12, weight: FontWeight.w600, color: AxnColors.muted(isLight), isArabic: ar)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                      decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              inviteLink,
                              textDirection: TextDirection.ltr,
                              style: AxnText.playfair(size: 12.5, weight: FontWeight.w500, color: const Color(0xFF6B6255)),
                            ),
                          ),
                          GestureDetector(
                            onTap: _copyLink,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: _copied ? const Color(0xFF3FA35B) : AxnColors.ink(isLight),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _copied ? (ar ? 'تم النسخ' : 'Copied') : (ar ? 'نسخ' : 'Copy'),
                                style: AxnText.playfair(size: 12, weight: FontWeight.w700, color: Colors.white, isArabic: ar),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(child: _ShareOpt(icon: '💬', label: 'WhatsApp', bg: const Color(0xFFDDF3E1), isLight: isLight, ar: ar)),
                        const SizedBox(width: 10),
                        Expanded(child: _ShareOpt(icon: '📷', label: 'Instagram', bg: const Color(0xFFFBEDEE), isLight: isLight, ar: ar)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _showQr = !_showQr),
                            child: _ShareOpt(icon: '▦', label: 'QR Pass', bg: AxnColors.groupBg(isLight), isLight: isLight, ar: ar),
                          ),
                        ),
                      ],
                    ),
                    if (_showQr) ...[
                      const SizedBox(height: 16),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                                child: Center(child: Text('▦', style: TextStyle(fontSize: 68, color: AxnColors.ink(true)))),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                ar ? 'هذا هو رمز QR الخاص بك. عندما يمسحه صديقك، يحصل كل منكما على 50 نقطة فورًا.' : 'This is your personal QR Pass. When a friend scans it to join, you both get 50 points instantly.',
                                textAlign: TextAlign.center,
                                style: AxnText.playfair(size: 12, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.5, isArabic: ar),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6, left: 2, right: 2),
                      child: Text(ar ? 'كيف تعمل' : 'How it works', style: AxnText.playfair(size: 12, weight: FontWeight.w600, color: AxnColors.muted(isLight), isArabic: ar)),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        children: [
                          _StepRow(num: '1', text: ar ? 'شارك رابطك أو رمز QR مع صديق، على واتساب، إنستغرام، أو شخصيًا.' : 'Share your link or QR Pass with a friend, on WhatsApp, Instagram, or in person.', isLight: isLight, ar: ar),
                          const SizedBox(height: 12),
                          _StepRow(num: '2', text: ar ? 'يقومون بتثبيت AXN والانضمام باستخدام رابطك أو مسح رمز QR الخاص بك.' : 'They install AXN and join using your link or by scanning your QR Pass.', isLight: isLight, ar: ar),
                          const SizedBox(height: 12),
                          _StepRow(num: '3', text: ar ? 'يحصل كل منكما فورًا على **50 نقطة** — اجمعها، لا يوجد حد.' : 'You both instantly earn **50 points** — stack it up, no limit on invites.', isLight: isLight, ar: ar),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(ar ? 'دعواتك' : 'Your invites', style: AxnText.playfair(size: 12, weight: FontWeight.w600, color: AxnColors.muted(isLight), isArabic: ar)),
                          Text(ar ? '${referrals.length} انضموا' : '${referrals.length} joined', style: AxnText.playfair(size: 12, weight: FontWeight.w600, color: AxnColors.muted(isLight), isArabic: ar)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        children: referrals.map((r) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AxnColors.line(isLight)))),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(r['name'] as String, style: AxnText.playfair(size: 13.5, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: ar)),
                                    const SizedBox(height: 1),
                                    Text(r['date'] as String, style: AxnText.playfair(size: 11, weight: FontWeight.w400, color: AxnColors.muted(isLight), isArabic: ar)),
                                  ],
                                ),
                              ),
                              Text('+${r['points']} pts', style: AxnText.playfair(size: 12.5, weight: FontWeight.w700, color: const Color(0xFF3FA35B), isArabic: ar)),
                            ],
                          ),
                        )).toList(),
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

class _ShareOpt extends StatelessWidget {
  final String icon;
  final String label;
  final Color bg;
  final bool isLight;
  final bool ar;

  const _ShareOpt({required this.icon, required this.label, required this.bg, required this.isLight, required this.ar});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
      decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
            child: Center(child: Text(icon, style: const TextStyle(fontSize: 17))),
          ),
          Text(label, style: AxnText.playfair(size: 11.5, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: ar)),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final String num;
  final String text;
  final bool isLight;
  final bool ar;

  const _StepRow({required this.num, required this.text, required this.isLight, required this.ar});

  @override
  Widget build(BuildContext context) {
    final parts = text.split('**');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(shape: BoxShape.circle, color: AxnColors.pointsBg(isLight)),
          child: Center(child: Text(num, style: AxnText.playfair(size: 11.5, weight: FontWeight.w700, color: AxnColors.pointsTx(isLight)))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: RichText(
              text: TextSpan(
                style: AxnText.playfair(size: 12.5, weight: FontWeight.w400, color: const Color(0xFF4A4436), height: 1.6, isArabic: ar),
                children: parts.asMap().entries.map((e) {
                  return TextSpan(
                    text: e.value,
                    style: e.key % 2 == 1 ? const TextStyle(fontWeight: FontWeight.w700) : null,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// CREATE GROUP FLOW
// ============================================================================
class CreateGroupTypeScreen extends StatefulWidget {
  final ValueChanged<GroupData>? onGroupCreated;
  const CreateGroupTypeScreen({super.key, this.onGroupCreated});

  @override
  State<CreateGroupTypeScreen> createState() => _CreateGroupTypeScreenState();
}

class _CreateGroupTypeScreenState extends State<CreateGroupTypeScreen> {
  bool? _isFamily;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final scope = AppScope.of(context);
    final ar = scope.isArabic;

    return Scaffold(
      backgroundColor: AxnColors.bg(isLight),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(22, 6, 22, 0),
              child: Row(
                children: [
                  Material(
                    color: AxnColors.rowBg(isLight),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(child: AxnSvgIcons.backArrow(color: AxnColors.ink(isLight), size: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    ar ? 'إنشاء مجموعة جديدة' : 'Create group',
                    style: AxnText.playfair(size: 20, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: ar),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 18, 22, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ar ? 'اختر نوع المجموعة. هذا يحدد التحقق المطلوب لكل عضو قبل الانضمام.' : 'Choose the group type. This decides what verification each member needs before joining.',
                      style: AxnText.playfair(size: 12.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.7, isArabic: ar),
                    ),
                    const SizedBox(height: 24),
                    _TypeSelectCard(
                      icon: '👨‍👩‍👧',
                      title: ar ? 'مجموعة عائلية' : 'Family group',
                      desc: ar ? 'تتطلب الهوية الوطنية + رمز التحقق لكل عضو. مصممة لتتبع الأطفال وحماية العائلة أثناء الزيارة.' : 'Requires national ID + OTP for every member. Built for tracking children and keeping the whole family in sync during a visit.',
                      color: AxnColors.familyBg(isLight),
                      isSelected: _isFamily == true,
                      onTap: () => setState(() => _isFamily = true),
                      isLight: isLight,
                      ar: ar,
                    ),
                    const SizedBox(height: 14),
                    _TypeSelectCard(
                      icon: '🧑‍🤝‍🧑',
                      title: ar ? 'مجموعة أصدقاء' : 'Group',
                      desc: ar ? 'رقم الهاتف + رمز التحقق فقط. مثالية للأصدقاء والبالغين الذين يريدون مشاركة موقعهم أثناء الرحلة.' : 'Just phone number + OTP. Best for friends and other adults who want to share their trip location.',
                      color: AxnColors.groupBg(isLight),
                      isSelected: _isFamily == false,
                      onTap: () => setState(() => _isFamily = false),
                      isLight: isLight,
                      ar: ar,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
              child: SizedBox(
                width: double.infinity,
                child: Material(
                  color: _isFamily == null ? AxnColors.muted(isLight).withValues(alpha: 0.3) : AxnColors.navy(isLight),
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: _isFamily == null
                        ? null
                        : () => Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => CreateGroupInfoScreen(isFamily: _isFamily!, onGroupCreated: widget.onGroupCreated),
                            )),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          ar ? 'متابعة' : 'Continue',
                          style: AxnText.playfair(size: 15, weight: FontWeight.w700, color: Colors.white, isArabic: ar),
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
}

class _TypeSelectCard extends StatelessWidget {
  final String icon;
  final String title;
  final String desc;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isLight;
  final bool ar;

  const _TypeSelectCard({
    required this.icon,
    required this.title,
    required this.desc,
    required this.color,
    required this.isSelected,
    required this.onTap,
    required this.isLight,
    required this.ar,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? const Color(0xFFFBEDEE) : AxnColors.rowBg(isLight),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AxnColors.tealDeep(isLight) : AxnColors.line(isLight),
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: color),
                    child: Center(child: Text(icon, style: const TextStyle(fontSize: 20))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(title, style: AxnText.playfair(size: 15.5, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: ar)),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: isSelected ? AxnColors.tealDeep(isLight) : const Color(0xFFD8D4CB), width: 2),
                    ),
                    child: isSelected
                        ? Center(
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: AxnColors.tealDeep(isLight)),
                            ),
                          )
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 32),
                child: Text(desc, style: AxnText.playfair(size: 12.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.65, isArabic: ar)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateGroupInfoScreen extends StatefulWidget {
  final bool isFamily;
  final ValueChanged<GroupData>? onGroupCreated;
  const CreateGroupInfoScreen({super.key, required this.isFamily, this.onGroupCreated});

  @override
  State<CreateGroupInfoScreen> createState() => _CreateGroupInfoScreenState();
}

class _CreateGroupInfoScreenState extends State<CreateGroupInfoScreen> {
  final _nameCtrl = TextEditingController();
  List<Color>? _selectedPhotoGradient;

  static const _gradients = [
    [Color(0xFFCFEFE6), Color(0xFF7FC9B8)],
    [Color(0xFFE4EFFC), Color(0xFF8FADE0)],
    [Color(0xFFFCE3E9), Color(0xFFE093A8)],
    [Color(0xFFF7E3C4), Color(0xFFD9A85C)],
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final scope = AppScope.of(context);
    final ar = scope.isArabic;

    return Scaffold(
      backgroundColor: AxnColors.bg(isLight),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(22, 6, 22, 0),
              child: Row(
                children: [
                  Material(
                    color: AxnColors.rowBg(isLight),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(child: AxnSvgIcons.backArrow(color: AxnColors.ink(isLight), size: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    ar ? 'تفاصيل المجموعة' : 'Group details',
                    style: AxnText.playfair(size: 20, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: ar),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 18, 22, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPhotoGradient = _gradients[DateTime.now().millisecondsSinceEpoch % _gradients.length];
                        });
                      },
                      child: Container(
                        width: 84,
                        height: 84,
                        margin: const EdgeInsets.only(top: 6, bottom: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AxnColors.rowBg(isLight),
                          border: _selectedPhotoGradient == null ? Border.all(color: const Color(0xFFD8D4CB), width: 1.6) : null,
                          gradient: _selectedPhotoGradient != null
                              ? LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: _selectedPhotoGradient!)
                              : null,
                        ),
                        child: _selectedPhotoGradient == null
                            ? Center(child: Text('📷', style: TextStyle(fontSize: 26, color: AxnColors.muted(isLight))))
                            : null,
                      ),
                    ),
                    Text(
                      ar ? 'أضف صورة للمجموعة (اختياري)' : 'Add a group photo (optional)',
                      style: AxnText.playfair(size: 12, weight: FontWeight.w400, color: AxnColors.muted(isLight), isArabic: ar),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        ar ? 'اسم المجموعة' : 'Group name',
                        style: AxnText.playfair(size: 12.5, weight: FontWeight.w600, color: const Color(0xFF6B6255), isArabic: ar),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(16)),
                      child: TextField(
                        controller: _nameCtrl,
                        textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
                        textAlign: ar ? TextAlign.right : TextAlign.start,
                        decoration: InputDecoration(
                          hintText: ar ? 'مثال: رحلة نهاية الأسبوع' : 'e.g. The Amman weekend crew',
                          hintStyle: AxnText.playfair(size: 14.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), isArabic: ar),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                        style: AxnText.playfair(size: 14.5, weight: FontWeight.w500, color: AxnColors.ink(isLight), isArabic: ar),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        ar ? 'نوع المجموعة' : 'Group type',
                        style: AxnText.playfair(size: 12.5, weight: FontWeight.w600, color: const Color(0xFF6B6255), isArabic: ar),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Wrap(
                        spacing: 6,
                        children: widget.isFamily
                            ? [
                                _Pill(text: ar ? 'عائلة' : 'Family', bg: AxnColors.familyBg(isLight), tx: AxnColors.familyTx(isLight), isArabic: ar),
                                _Pill(text: ar ? 'موثق بالهوية الوطنية' : 'National ID verified', bg: AxnColors.verifiedBg(isLight), tx: AxnColors.verifiedTx(isLight), isArabic: ar),
                              ]
                            : [
                                _Pill(text: ar ? 'مجموعة' : 'Group', bg: AxnColors.groupBg(isLight), tx: AxnColors.groupTx(isLight), isArabic: ar),
                                _Pill(text: ar ? 'موثق بالهاتف' : 'Phone verified', bg: AxnColors.phoneVerifBg(isLight), tx: AxnColors.phoneVerifTx(isLight), isArabic: ar),
                              ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
              child: SizedBox(
                width: double.infinity,
                child: Material(
                  color: AxnColors.navy(isLight),
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      final name = _nameCtrl.text.trim().isEmpty ? (widget.isFamily ? 'Family Group' : 'My Group') : _nameCtrl.text;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CreateGroupInviteScreen(
                          groupName: name,
                          isFamily: widget.isFamily,
                          onGroupCreated: widget.onGroupCreated,
                        ),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          ar ? 'متابعة' : 'Continue',
                          style: AxnText.playfair(size: 15, weight: FontWeight.w700, color: Colors.white, isArabic: ar),
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
}

class CreateGroupInviteScreen extends StatefulWidget {
  final String groupName;
  final bool isFamily;
  final ValueChanged<GroupData>? onGroupCreated;
  const CreateGroupInviteScreen({super.key, required this.groupName, required this.isFamily, this.onGroupCreated});

  @override
  State<CreateGroupInviteScreen> createState() => _CreateGroupInviteScreenState();
}

class _CreateGroupInviteScreenState extends State<CreateGroupInviteScreen> {
  int _activeTab = 0;
  final List<Map<String, dynamic>> _members = [
    {'phone': TextEditingController(), 'id': TextEditingController(), 'consent': true}
  ];

  void _addMember() {
    setState(() {
      _members.add({'phone': TextEditingController(), 'id': TextEditingController(), 'consent': true});
    });
  }

  void _removeMember(int index) {
    if (_members.length > 1) {
      setState(() {
        _members[index]['phone'].dispose();
        _members[index]['id'].dispose();
        _members.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    for (final m in _members) {
      m['phone'].dispose();
      m['id'].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final scope = AppScope.of(context);
    final ar = scope.isArabic;

    return Scaffold(
      backgroundColor: AxnColors.bg(isLight),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(22, 6, 22, 0),
              child: Row(
                children: [
                  Material(
                    color: AxnColors.rowBg(isLight),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(child: AxnSvgIcons.backArrow(color: AxnColors.ink(isLight), size: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    ar ? 'دعوة الأعضاء' : 'Invite members',
                    style: AxnText.playfair(size: 20, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: ar),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 18, 22, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _activeTab = 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: _activeTab == 0 ? (isLight ? Colors.white : const Color(0xFF2A2820)) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: _activeTab == 0 ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))] : [],
                                ),
                                child: Center(
                                  child: Text(ar ? 'دعوة برقم الهاتف' : 'Invite by phone', style: AxnText.playfair(size: 13, weight: _activeTab == 0 ? FontWeight.w700 : FontWeight.w600, color: _activeTab == 0 ? AxnColors.ink(isLight) : AxnColors.muted(isLight), isArabic: ar)),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _activeTab = 1),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: _activeTab == 1 ? (isLight ? Colors.white : const Color(0xFF2A2820)) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: _activeTab == 1 ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))] : [],
                                ),
                                child: Center(
                                  child: Text(ar ? 'دعوة برمز QR' : 'Invite by QR', style: AxnText.playfair(size: 13, weight: _activeTab == 1 ? FontWeight.w700 : FontWeight.w600, color: _activeTab == 1 ? AxnColors.ink(isLight) : AxnColors.muted(isLight), isArabic: ar)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    if (_activeTab == 0) ...[
                      for (int i = 0; i < _members.length; i++)
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(18)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    ar ? 'رقم الهاتف' : 'Phone number',
                                    style: AxnText.playfair(size: 12.5, weight: FontWeight.w600, color: const Color(0xFF6B6255), isArabic: ar),
                                  ),
                                  const Spacer(),
                                  if (i > 0)
                                    GestureDetector(
                                      onTap: () => _removeMember(i),
                                      child: Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: AxnColors.avMoreBg(isLight)),
                                        child: Center(child: Text('✕', style: TextStyle(fontSize: 12, color: AxnColors.avMoreTx(isLight)))),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Container(
                                decoration: BoxDecoration(color: isLight ? Colors.white : const Color(0xFF161A22), borderRadius: BorderRadius.circular(14)),
                                child: TextField(
                                  controller: _members[i]['phone'],
                                  keyboardType: TextInputType.phone,
                                  textDirection: TextDirection.ltr,
                                  decoration: InputDecoration(
                                    hintText: '+962 7 ••• ••••',
                                    hintStyle: AxnText.playfair(size: 14, weight: FontWeight.w400, color: AxnColors.muted(isLight)),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                  ),
                                  style: AxnText.playfair(size: 14, weight: FontWeight.w500, color: AxnColors.ink(isLight)),
                                ),
                              ),
                              if (widget.isFamily) ...[
                                const SizedBox(height: 12),
                                Text(
                                  ar ? 'الرقم الوطني' : 'National ID',
                                  style: AxnText.playfair(size: 12.5, weight: FontWeight.w600, color: const Color(0xFF6B6255), isArabic: ar),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  decoration: BoxDecoration(color: isLight ? Colors.white : const Color(0xFF161A22), borderRadius: BorderRadius.circular(14)),
                                  child: TextField(
                                    controller: _members[i]['id'],
                                    keyboardType: TextInputType.number,
                                    textDirection: TextDirection.ltr,
                                    decoration: InputDecoration(
                                      hintText: ar ? 'رقم الهوية الوطنية' : 'National ID number',
                                      hintStyle: AxnText.playfair(size: 14, weight: FontWeight.w400, color: AxnColors.muted(isLight), isArabic: ar),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                    ),
                                    style: AxnText.playfair(size: 14, weight: FontWeight.w500, color: AxnColors.ink(isLight)),
                                  ),
                                ),
                              ],
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () => setState(() => _members[i]['consent'] = !_members[i]['consent']),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 19,
                                      height: 19,
                                      margin: const EdgeInsets.only(top: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: _members[i]['consent'] ? AxnColors.tealDeep(isLight) : (isLight ? Colors.white : Colors.black26),
                                        border: Border.all(color: _members[i]['consent'] ? AxnColors.tealDeep(isLight) : const Color(0xFFD8D4CB), width: 1.8),
                                      ),
                                      child: _members[i]['consent']
                                          ? const Center(child: Icon(Icons.check, size: 13, color: Colors.white))
                                          : null,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        widget.isFamily
                                            ? (ar ? 'أؤكد هوية هذا العضو وموافقته على مشاركة الموقع لأمان العائلة.' : "I confirm this member's identity and consent to sharing their location for family safety.")
                                            : (ar ? 'يوافق هذا العضو على مشاركة موقعه مع المجموعة أثناء الزيارات.' : "This member agrees to share their location with the group during visits."),
                                        style: AxnText.playfair(size: 12, weight: FontWeight.w400, color: const Color(0xFF6B6255), height: 1.6, isArabic: ar),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 4),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: _addMember,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AxnColors.dashedBorder(isLight), width: 1.6),
                            ),
                            child: Center(
                              child: Text(
                                ar ? '＋  إضافة عضو آخر' : '＋  Add another member',
                                style: AxnText.playfair(size: 13.5, weight: FontWeight.w700, color: AxnColors.createGroupText(isLight), isArabic: ar),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              width: 190,
                              height: 190,
                              decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(20)),
                              child: Center(child: Text('▦', style: TextStyle(fontSize: 90, color: AxnColors.ink(isLight)))),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              ar ? 'اطلب منهم مسح هذا الرمز باستخدام تطبيق AXN لطلب الانضمام. ستظل تؤكد كل عضو قبل إضافته.' : "Ask them to scan this code with their AXN app to request to join. You'll still confirm each member before they're added.",
                              textAlign: TextAlign.center,
                              style: AxnText.playfair(size: 12.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.6, isArabic: ar),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
              child: SizedBox(
                width: double.infinity,
                child: Material(
                  color: AxnColors.navy(isLight),
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CreateGroupOtpScreen(
                          groupName: widget.groupName,
                          isFamily: widget.isFamily,
                          memberCount: _members.length + 1,
                          onGroupCreated: widget.onGroupCreated,
                        ),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          ar ? 'إرسال الدعوات والتحقق' : 'Send invites & verify',
                          style: AxnText.playfair(size: 15, weight: FontWeight.w700, color: Colors.white, isArabic: ar),
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
}

class CreateGroupOtpScreen extends StatefulWidget {
  final String groupName;
  final bool isFamily;
  final int memberCount;
  final ValueChanged<GroupData>? onGroupCreated;
  const CreateGroupOtpScreen({super.key, required this.groupName, required this.isFamily, required this.memberCount, this.onGroupCreated});

  @override
  State<CreateGroupOtpScreen> createState() => _CreateGroupOtpScreenState();
}

class _CreateGroupOtpScreenState extends State<CreateGroupOtpScreen> {
  final _ctrl = TextEditingController(text: '4910');

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _finish() {
    final newGroup = GroupData(
      id: 'new-${DateTime.now().millisecondsSinceEpoch}',
      name: widget.groupName,
      type: widget.isFamily ? GroupType.family : GroupType.group,
      members: [
        GroupMember(name: 'You', initials: 'YO', color: const Color(0xFFCFE8DE), role: 'Admin (You)', verified: widget.isFamily ? VerificationStatus.national : VerificationStatus.phone, live: true),
        for (int i = 1; i < widget.memberCount; i++)
          GroupMember(
            name: 'Member $i',
            initials: 'M$i',
            color: [const Color(0xFFD9D3F2), const Color(0xFFF7E3C4), const Color(0xFFE4EFFC), const Color(0xFFFCE3E9)][(i - 1) % 4],
            role: 'Member',
            verified: widget.isFamily ? VerificationStatus.national : VerificationStatus.phone,
            live: false,
          ),
      ],
      consentGranted: true,
    );

    widget.onGroupCreated?.call(newGroup);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CreateGroupSuccessScreen(group: newGroup),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final scope = AppScope.of(context);
    final ar = scope.isArabic;

    return Scaffold(
      backgroundColor: AxnColors.bg(isLight),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(22, 6, 22, 0),
              child: Row(
                children: [
                  Material(
                    color: AxnColors.rowBg(isLight),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(child: AxnSvgIcons.backArrow(color: AxnColors.ink(isLight), size: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    ar ? 'التحقق' : 'Verify',
                    style: AxnText.playfair(size: 20, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: ar),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 18, 22, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AxnColors.groupBg(isLight)),
                      child: const Center(child: Text('🔐', style: TextStyle(fontSize: 28))),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      ar ? 'أدخل الرمز' : 'Enter the code',
                      style: AxnText.playfair(size: 21, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: ar),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ar ? 'أرسلنا رمزًا مكونًا من 6 أرقام إلى رقم هاتفك لتأكيد وإنشاء المجموعة.' : 'We sent a 6-digit code to your number to confirm and create the group.',
                      textAlign: TextAlign.center,
                      style: AxnText.playfair(size: 13, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.6, isArabic: ar),
                    ),
                    const SizedBox(height: 26),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (index) {
                          final char = index < _ctrl.text.length ? _ctrl.text[index] : '';
                          final isFilled = char.isNotEmpty;
                          return Container(
                            width: 44,
                            height: 54,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: isFilled ? const Color(0xFFFBEDEE) : AxnColors.rowBg(isLight),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isFilled ? AxnColors.tealDeep(isLight) : Colors.transparent,
                                width: 1.6,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                char,
                                style: AxnText.playfair(size: 20, weight: FontWeight.w700, color: AxnColors.ink(isLight)),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      ar ? 'لم تستلم الرمز؟ إعادة الإرسال' : "Didn't get it? Resend code",
                      style: AxnText.playfair(size: 12.5, weight: FontWeight.w600, color: AxnColors.tealDeep(isLight), isArabic: ar),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
              child: SizedBox(
                width: double.infinity,
                child: Material(
                  color: AxnColors.tealDeep(isLight),
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: _finish,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          ar ? 'التحقق وإنشاء المجموعة' : 'Verify & create group',
                          style: AxnText.playfair(size: 15, weight: FontWeight.w700, color: Colors.white, isArabic: ar),
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
}

class CreateGroupSuccessScreen extends StatelessWidget {
  final GroupData group;
  const CreateGroupSuccessScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final scope = AppScope.of(context);
    final ar = scope.isArabic;

    return Scaffold(
      backgroundColor: AxnColors.bg(isLight),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFE1F3E2)),
                        child: const Center(
                          child: Icon(Icons.check_rounded, color: Color(0xFF3FA35B), size: 40),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        ar ? 'تم إنشاء المجموعة!' : 'Group created!',
                        style: AxnText.playfair(size: 24, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: ar),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ar ? 'سيتلقى الأعضاء دعوة للتأكيد وبدء مشاركة موقعهم أثناء هذه الزيارة.' : 'Members will get an invite to confirm and start sharing their location during this visit.',
                        textAlign: TextAlign.center,
                        style: AxnText.playfair(size: 13, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.7, isArabic: ar),
                      ),
                      const SizedBox(height: 26),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(18)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(group.name, style: AxnText.playfair(size: 14.5, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: ar)),
                            const SizedBox(height: 4),
                            Text(
                              group.type == GroupType.family
                                  ? (ar ? 'مجموعة عائلية · ${group.members.length} أعضاء' : 'Family group · ${group.members.length} members')
                                  : (ar ? 'مجموعة · ${group.members.length} أعضاء' : 'Group · ${group.members.length} members'),
                              style: AxnText.playfair(size: 12, weight: FontWeight.w400, color: AxnColors.muted(isLight), isArabic: ar),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: AxnColors.navy(isLight),
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => GroupDetailsScreen(group: group)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              ar ? 'الذهاب إلى المجموعة' : 'Go to group',
                              style: AxnText.playfair(size: 15, weight: FontWeight.w700, color: Colors.white, isArabic: ar),
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
                      color: AxnColors.rowBg(isLight),
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              ar ? 'تم' : 'Done',
                              style: AxnText.playfair(size: 15, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: ar),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// GROUP DETAILS SCREEN (Map, Members, Settings)
// ============================================================================
class GroupDetailsScreen extends StatefulWidget {
  final GroupData group;
  const GroupDetailsScreen({super.key, required this.group});

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  int _activeTab = 0;
  String _shareMode = 'visit';
  bool _safeZoneOn = true;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final scope = AppScope.of(context);
    final ar = scope.isArabic;
    final isFamily = widget.group.type == GroupType.family;

    return Scaffold(
      backgroundColor: AxnColors.bg(isLight),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(22, 6, 22, 0),
              child: Row(
                children: [
                  Material(
                    color: AxnColors.rowBg(isLight),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(child: AxnSvgIcons.backArrow(color: AxnColors.ink(isLight), size: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      widget.group.name,
                      style: AxnText.playfair(size: 20, weight: FontWeight.w600, color: AxnColors.ink(isLight), isArabic: ar),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 12, 22, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _AvatarStack(members: widget.group.members, isLight: isLight, size: 44),
                    const SizedBox(height: 12),
                    Text(
                      widget.group.name,
                      style: AxnText.playfair(size: 22, weight: FontWeight.w500, color: AxnColors.ink(isLight), isArabic: ar),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isFamily
                          ? (ar ? 'مجموعة عائلية · ${widget.group.members.length} أعضاء' : 'Family group · ${widget.group.members.length} members')
                          : (ar ? 'مجموعة · ${widget.group.members.length} أعضاء' : 'Group · ${widget.group.members.length} members'),
                      style: AxnText.playfair(size: 12.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), isArabic: ar),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: AxnColors.line(isLight), width: 1.6)),
                      ),
                      child: Row(
                        children: [
                          _buildTabItem(0, ar ? 'الخريطة' : 'Map', isLight, ar),
                          _buildTabItem(1, ar ? 'الأعضاء' : 'Members', isLight, ar),
                          _buildTabItem(2, ar ? 'الإعدادات' : 'Settings', isLight, ar),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _buildTabContent(isLight, ar, isFamily),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(int index, String label, bool isLight, bool ar) {
    final isActive = _activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = index),
        child: Container(
          padding: const EdgeInsets.only(bottom: 11),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? AxnColors.tealDeep(isLight) : Colors.transparent,
                width: 2.4,
              ),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AxnText.playfair(
                size: 13.5,
                weight: FontWeight.w700,
                color: isActive ? AxnColors.ink(isLight) : AxnColors.muted(isLight),
                isArabic: ar,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(bool isLight, bool ar, bool isFamily) {
    if (_activeTab == 0) {
      return Column(
        children: [
          Container(
            height: 230,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFEFEDE6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                CustomPaint(
                  size: const Size(double.infinity, 230),
                  painter: _MapGridPainter(),
                ),
                ...widget.group.members.asMap().entries.map((entry) {
                  final i = entry.key;
                  final m = entry.value;
                  const positions = [
                    Offset(0.26, 0.30),
                    Offset(0.62, 0.18),
                    Offset(0.40, 0.60),
                    Offset(0.74, 0.55),
                    Offset(0.18, 0.68),
                  ];
                  final pos = positions[i % positions.length];
                  return Positioned(
                    left: pos.dx * 300,
                    top: pos.dy * 190,
                    child: _MapPin(member: m, isYou: i == 0, isLight: isLight),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            ar ? 'تمركز حول مدينة عمرا · تم التحديث الآن' : 'Centered on Amra City · updated just now',
            style: AxnText.playfair(size: 11.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), isArabic: ar),
          ),
        ],
      );
    } else if (_activeTab == 1) {
      return Column(
        children: widget.group.members.map((m) {
          final isYou = m.name == 'username' || m.name == 'You';
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AxnColors.line(isLight)))),
            child: Row(
              children: [
                _MemberBubble(initials: m.initials, color: m.color, live: m.live, size: 34, isLight: isLight),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isYou ? (ar ? 'أنت' : 'You') : m.name,
                        style: AxnText.playfair(size: 14, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: ar),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        m.role,
                        style: AxnText.playfair(size: 11.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), isArabic: ar),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      m.live ? (ar ? 'مباشر الآن' : 'Live now') : (ar ? 'غير متصل' : 'Away'),
                      style: AxnText.playfair(
                        size: 11,
                        weight: FontWeight.w600,
                        color: m.live ? AxnColors.dotLive(isLight) : AxnColors.muted(isLight),
                        isArabic: ar,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildVerificationBadge(m.verified, isLight, ar),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      );
    } else {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(18)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ar ? 'مشاركة موقعي' : 'Share my location',
                  style: AxnText.playfair(size: 13.5, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: ar),
                ),
                const SizedBox(height: 4),
                Text(
                  ar ? 'اختر ما إذا كان موقعك يظل مرئيًا لهذه المجموعة طوال الوقت، أو فقط أثناء تواجدك في زيارة.' : 'Choose whether your location stays visible to this group all the time, or only while you\'re on a visit.',
                  style: AxnText.playfair(size: 12, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.6, isArabic: ar),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(color: const Color(0xFFEAE7DF), borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _shareMode = 'always'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            decoration: BoxDecoration(
                              color: _shareMode == 'always' ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Center(
                              child: Text(
                                ar ? 'دائمًا' : 'Always',
                                style: AxnText.playfair(size: 12, weight: FontWeight.w700, color: _shareMode == 'always' ? AxnColors.ink(isLight) : AxnColors.muted(isLight), isArabic: ar),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _shareMode = 'visit'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            decoration: BoxDecoration(
                              color: _shareMode == 'visit' ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Center(
                              child: Text(
                                ar ? 'أثناء الزيارات فقط' : 'During visits only',
                                style: AxnText.playfair(size: 12, weight: FontWeight.w700, color: _shareMode == 'visit' ? AxnColors.ink(isLight) : AxnColors.muted(isLight), isArabic: ar),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isFamily)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(18)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ar ? 'المناطق الآمنة' : 'Safe zones',
                    style: AxnText.playfair(size: 13.5, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: ar),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ar ? 'تلقي إشعار إذا غادر طفل في هذه المجموعة منطقة حددتها.' : 'Get notified if a child in this group leaves a zone you\'ve set.',
                    style: AxnText.playfair(size: 12, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.6, isArabic: ar),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(color: const Color(0xFFFBEDEE), borderRadius: BorderRadius.circular(11)),
                        child: const Center(child: Text('📍', style: TextStyle(fontSize: 16))),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ar ? 'المنزل — مدينة عمرا' : 'Home — Amra City', style: AxnText.playfair(size: 13.5, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: ar)),
                            const SizedBox(height: 1),
                            Text(ar ? 'نصف قطر 300م · التنبيهات مفعّلة' : '300m radius · alerts on', style: AxnText.playfair(size: 11.5, weight: FontWeight.w400, color: AxnColors.muted(isLight), isArabic: ar)),
                          ],
                        ),
                      ),
                      Switch.adaptive(
                        value: _safeZoneOn,
                        activeColor: AxnColors.tealDeep(isLight),
                        onChanged: (val) => setState(() => _safeZoneOn = val),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      ar ? '＋ إضافة منطقة آمنة' : '＋ Add a safe zone',
                      style: AxnText.playfair(size: 12.5, weight: FontWeight.w700, color: AxnColors.tealDeep(isLight), isArabic: ar),
                    ),
                  ),
                ],
              ),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AxnColors.rowBg(isLight), borderRadius: BorderRadius.circular(18)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ar ? 'الإدارة' : 'Admin',
                  style: AxnText.playfair(size: 13.5, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: ar),
                ),
                const SizedBox(height: 4),
                Text(
                  ar ? 'أنت أنشأت هذه المجموعة، لذا يمكنك إدارة الأعضاء وإعداداتها.' : 'You created this group, so you can manage members and its settings.',
                  style: AxnText.playfair(size: 12, weight: FontWeight.w400, color: AxnColors.muted(isLight), height: 1.6, isArabic: ar),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: isLight ? Colors.white : const Color(0xFF2A2820),
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => CreateGroupInviteScreen(groupName: widget.group.name, isFamily: isFamily),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Center(
                          child: Text(
                            ar ? 'دعوة المزيد من الأعضاء' : 'Invite more members',
                            style: AxnText.playfair(size: 13.5, weight: FontWeight.w700, color: AxnColors.ink(isLight), isArabic: ar),
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
                    color: AxnColors.dangerBg(isLight),
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(ar ? 'مغادرة المجموعة؟' : 'Leave group?'),
                            content: Text(ar ? 'هل أنت متأكد من مغادرة هذه المجموعة؟' : 'Are you sure you want to leave this group?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text(ar ? 'إلغاء' : 'Cancel')),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text(ar ? 'مغادرة' : 'Leave', style: const TextStyle(color: Color(0xFFD65D6B))),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Center(
                          child: Text(
                            ar ? 'مغادرة المجموعة' : 'Leave group',
                            style: AxnText.playfair(size: 13.5, weight: FontWeight.w700, color: AxnColors.dangerTx(isLight), isArabic: ar),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget _buildVerificationBadge(VerificationStatus status, bool isLight, bool ar) {
    switch (status) {
      case VerificationStatus.national:
        return _Pill(text: ar ? 'هوية موثقة' : 'National ID verified', bg: AxnColors.verifiedBg(isLight), tx: AxnColors.verifiedTx(isLight), isArabic: ar);
      case VerificationStatus.phone:
        return _Pill(text: ar ? 'هاتف موثق' : 'Phone verified', bg: AxnColors.phoneVerifBg(isLight), tx: AxnColors.phoneVerifTx(isLight), isArabic: ar);
      case VerificationStatus.none:
      default:
        return _Pill(text: ar ? 'غير موثق' : 'Not verified', bg: AxnColors.unverifiedBg(isLight), tx: AxnColors.unverifiedTx(isLight), isArabic: ar);
    }
  }
}

class _MapPin extends StatelessWidget {
  final GroupMember member;
  final bool isYou;
  final bool isLight;
  const _MapPin({required this.member, required this.isYou, required this.isLight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: isYou ? const Color(0xFFA93244) : member.color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2.5),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Center(
        child: Text(
          member.initials,
          style: AxnText.playfair(size: 10, weight: FontWeight.w700, color: isYou ? Colors.white : const Color(0xFF4A4436)),
        ),
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.04)
      ..strokeWidth = 1;
    for (double y = 0; y < size.height; y += 26) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    for (double x = 0; x < size.width; x += 26) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}