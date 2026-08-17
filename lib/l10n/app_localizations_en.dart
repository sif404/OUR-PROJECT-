// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get stadium => 'Prince Hussein bin Abdullah II Stadium';

  @override
  String get tagline =>
      'Your gateway to matchday — activate once, walk straight in every time.';

  @override
  String get city => 'Amra Smart City';

  @override
  String get ctaTicket => 'Activate my ticket';

  @override
  String get ctaCreate => 'Create an account';

  @override
  String get ctaGuest => 'Browse as guest';

  @override
  String get ctaLogin => 'Already have an account — Log in';

  @override
  String get toggleLabel => 'العربية';

  @override
  String get notifHead => 'Notifications';

  @override
  String get notif1Title => 'Welcome to AMRA Smart City';

  @override
  String get notif1Body =>
      'Your account hub for matchday, transit, and city services.';

  @override
  String get notif2Title => 'Activate your ticket';

  @override
  String get notif2Body =>
      'Activate your ticket to unlock your matchday experience.';

  @override
  String get notif3Title => 'Set up your account';

  @override
  String get notif3Body =>
      'Create an account to enjoy all smart city services, or continue as a guest.';

  @override
  String get guestNote =>
      'Guest mode has limited access. Activate anytime for seating, wayfinding and rewards.';

  @override
  String get btnContinue => 'Continue';

  @override
  String get m1Eyebrow => 'Step 1 of 5';

  @override
  String get m1Title => 'How do you want to activate your ticket?';

  @override
  String get m1Sub =>
      'Choose the method that works best for you — we\'ll verify the ticket automatically.';

  @override
  String get m1QrTitle => 'Scan QR code';

  @override
  String get m1QrDesc =>
      'Open the camera and point it at your ticket\'s QR code — its details load automatically.';

  @override
  String get m1ManualTitle => 'Manual activation';

  @override
  String get m1ManualDesc =>
      'Enter your ticket ID and the verification code sent with your ticket.';

  @override
  String get qrEyebrow => 'Scan code';

  @override
  String get qrTitle => 'Point the camera at the QR code';

  @override
  String get qrSub =>
      'Line up the code inside the frame — it\'s detected automatically, no button needed.';

  @override
  String qrChip(String ticketId) {
    return '🎫 Ticket $ticketId ready to detect';
  }

  @override
  String get qrDetected => 'Detected — Continue';

  @override
  String get qrManualInstead => 'Enter the details manually instead';

  @override
  String get manualTitle => 'Enter your ticket ID';

  @override
  String get manualSub =>
      'You\'ll find this on your e-ticket or printed ticket.';

  @override
  String get manualLabel => 'Ticket ID';

  @override
  String get mcEyebrow => 'Verify ownership';

  @override
  String get mcTitle => 'Enter the verification code';

  @override
  String get mcSub =>
      'We sent a code to the email address associated with this ticket.';

  @override
  String get mcLabel => 'Verification code';

  @override
  String get mcVerifyBtn => 'Verify ticket';

  @override
  String get resendPrefix => 'Didn\'t get the code? ';

  @override
  String resendAction(String countdown) {
    return 'Resend ($countdown)';
  }

  @override
  String get otpTitle => 'Confirm you own this ticket';

  @override
  String get otpSub =>
      'We sent a 6-digit code to the email the ticket was sent to';

  @override
  String get otpConfirmBtn => 'Confirm and verify ownership';

  @override
  String get caEyebrow => 'Create account';

  @override
  String get caTitle => 'Set up your AXN account';

  @override
  String get caSub =>
      'This account links your ticket to you and stays with you long after the event ends.';

  @override
  String get lblFullName => 'Full name';

  @override
  String get lblNationalId => 'National ID';

  @override
  String get lblDob => 'Date of birth';

  @override
  String get phDob => 'DD / MM / YYYY';

  @override
  String get lblMobile => 'Mobile number';

  @override
  String get lblEmail => 'Email';

  @override
  String get hintEmail =>
      'Filled in automatically from the ticket — you can edit it if needed.';

  @override
  String get lblPassword => 'Password';

  @override
  String get lblConfirmPassword => 'Confirm password';

  @override
  String get caCreateBtn => 'Create account';

  @override
  String get bindTitle => 'Binding successful';

  @override
  String get bindSub =>
      'Your ticket is now linked to your account and this device — ready for event entry.';

  @override
  String get bind1Title => 'Ticket ⇄ Account';

  @override
  String get bind1Sub =>
      'One ticket = one account, and it can\'t be activated again';

  @override
  String get bind2Title => 'Account ⇄ Device';

  @override
  String get bind2Sub =>
      'Changing devices requires re-verification of your identity';

  @override
  String get bind3Title => 'QR status';

  @override
  String get bind3Sub =>
      'The QR code is now marked \"activated\" and can\'t be used again';

  @override
  String get bindEnterBtn => 'Enter AXN';

  @override
  String get loginTitle => 'Welcome back';

  @override
  String get loginSub =>
      'Your account is always here — check your event history, rewards, and memories anytime.';

  @override
  String get lblUserOrEmail => 'Username or email';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get loginBtn => 'Log in';

  @override
  String get noAccountBtn => 'Don\'t have an account — Create one';

  @override
  String get obSkip => 'Skip';

  @override
  String get obNext => 'Next';

  @override
  String get obStart => 'Get started';

  @override
  String get splash_wordAx => 'AX';

  @override
  String get splash_wordN => 'N';

  @override
  String get splash_tagline => 'AMRA EXCHANGE NEXUS';

  @override
  String get ob1Title => 'Discover the Smart City';

  @override
  String get ob1Desc =>
      'A live map showing events and crowd density in Amra city moment by moment.';

  @override
  String get ob2Title => 'Find Your Car Instantly';

  @override
  String get ob2Desc =>
      'The Find My Car feature guides you directly to your parking spot without getting lost.';

  @override
  String get ob3Title => 'Your Safety First';

  @override
  String get ob3Desc =>
      'With one tap on the emergency button, your live location is sent directly to response teams.';

  @override
  String get ob4Title => 'Ready to Get Started?';

  @override
  String get ob4Desc =>
      'Plan your visit with smart AI-powered recommendations and enjoy every moment.';

  @override
  String get welcome_pipe => '|';

  @override
  String get methodCardQrIcon => '▦';

  @override
  String get methodCardManualIcon => '✎';

  @override
  String get manualPlaceholder => 'JFA26-XXXXXX';

  @override
  String get maskedEmailChip => '✉️';

  @override
  String get maskedEmailExample => 'sa***@gmail.com';

  @override
  String get otpDots => '•';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_back => 'Back';

  @override
  String get settings_notifications => 'Notifications';

  @override
  String get settings_pushTitle => 'Push notifications';

  @override
  String get settings_pushSub => 'Alerts, updates and offers';

  @override
  String get settings_safeZoneTitle => 'Safe zone alerts';

  @override
  String get settings_safeZoneSub => 'Geofence entry and exit notifications';

  @override
  String get settings_groupActivityTitle => 'Group activity alerts';

  @override
  String get settings_groupActivitySub => 'Updates from your family groups';

  @override
  String get settings_legacyCapsuleTitle => 'Legacy Capsule alerts';

  @override
  String get settings_legacyCapsuleSub =>
      'Delivery and detection notifications';

  @override
  String get settings_manageSafeZones => 'Manage safe zones';

  @override
  String get settings_preferences => 'Preferences';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_langEn => 'EN';

  @override
  String get settings_langAr => 'AR';

  @override
  String get settings_theme => 'Theme';

  @override
  String get settings_themeLight => 'Light';

  @override
  String get settings_themeDark => 'Dark';

  @override
  String get settings_themeSystem => 'System';

  @override
  String get settings_accessibility => 'Accessibility';

  @override
  String get settings_fontSize => 'Font size';

  @override
  String get settings_fontSmall => 'Small';

  @override
  String get settings_fontDefault => 'Default';

  @override
  String get settings_fontLarge => 'Large';

  @override
  String get settings_fontXLarge => 'X-Large';

  @override
  String get settings_locationSharing => 'Location & sharing';

  @override
  String get settings_shareLocationTitle => 'Share live location';

  @override
  String get settings_shareLocationSub => 'Visible to linked family members';

  @override
  String get settings_accountSecurity => 'Account & security';

  @override
  String get settings_changePin => 'Change PIN / password';

  @override
  String get settings_biometricTitle => 'Biometric unlock';

  @override
  String get settings_biometricSub => 'Face ID or fingerprint';

  @override
  String get settings_helpSupport => 'Help & support';

  @override
  String get settings_helpCenter => 'Help center / FAQ';

  @override
  String get settings_contactSupport => 'Contact support';

  @override
  String get settings_reportProblem => 'Report a problem';

  @override
  String get settings_about => 'About';

  @override
  String get settings_version => 'Version';

  @override
  String get settings_terms => 'Terms of service';

  @override
  String get settings_privacy => 'Privacy policy';

  @override
  String get settings_logoutNote => 'Log out is available on your profile';

  @override
  String get home_liveVisitors => 'LIVE STADIUM VISITORS';

  @override
  String get home_stadiumEnv => 'STADIUM ENVIRONMENTS & CROWD';

  @override
  String get home_quickAssist => 'QUICK ASSIST';

  @override
  String get home_avatarInitials => 'AX';

  @override
  String get home_liveBadge => 'LIVE';

  @override
  String home_hello(String name) {
    return 'Ahlan, $name 👋';
  }

  @override
  String get home_visitorsToday => 'Visitors today';

  @override
  String get home_atGate => 'at gate';

  @override
  String get home_inStands => 'in stands';

  @override
  String get home_entering => 'entering';

  @override
  String get home_envAir => 'Air';

  @override
  String get home_envAirSub => 'Circulation & quality';

  @override
  String get home_envNoise => 'Noise';

  @override
  String get home_envNoiseSub => 'Decibel levels';

  @override
  String get home_envCrowd => 'Crowd';

  @override
  String get home_envCrowdSub => 'Zone density';

  @override
  String get home_envSafety => 'Safety';

  @override
  String get home_envSafetySub => 'Incident monitor';

  @override
  String get home_eveningPlan => 'Your evening plan';

  @override
  String get home_eveningPlanSub => 'Tap to see your curated schedule';

  @override
  String get home_eveningTime => '6:00 PM — 11:30 PM';

  @override
  String home_eveningStops(String count) {
    return '$count stops';
  }

  @override
  String get home_rewardsTitle => 'Matchday Rewards';

  @override
  String home_rewardsPoints(String points) {
    return '$points pts';
  }

  @override
  String get home_rewardsSub => 'Scan in, collect, unlock perks';

  @override
  String get home_rewardsTierBadge => 'Silver tier';

  @override
  String get home_assistFindCar => 'Find My Car';

  @override
  String get home_assistRoute => 'Route Planner';

  @override
  String get home_assistSmartExit => 'Smart Exit';

  @override
  String get home_assistAI => 'AI Planner';

  @override
  String get home_assistSOS => 'Emergency SOS';

  @override
  String get home_navHome => 'Home';

  @override
  String get home_navRoute => 'Route';

  @override
  String get home_navAlert => 'Alert';

  @override
  String get home_navAI => 'AI';

  @override
  String get home_navSettings => 'Settings';

  @override
  String get profile_title => 'Profile';

  @override
  String get profile_verifiedBadge => 'Verified ticket holder';

  @override
  String profile_ticketBound(String id) {
    return 'Ticket $id · Bound';
  }

  @override
  String profile_eventsAttended(String count) {
    return '$count events';
  }

  @override
  String profile_rewardsPoints(String points) {
    return '$points reward points';
  }

  @override
  String profile_memberSince(String date) {
    return 'Member since $date';
  }

  @override
  String get profile_sectionActivity => 'Recent activity';

  @override
  String get profile_sectionFamily => 'My family groups';

  @override
  String get profile_sectionHistory => 'Event history';

  @override
  String get profile_sectionRewards => 'Rewards & perks';

  @override
  String get profile_createGroup => '＋  Create group';

  @override
  String get profile_noGroupsYet =>
      'No groups yet — create one to link family members.';

  @override
  String get profile_logout => 'Log out';

  @override
  String get profile_editProfile => 'Edit profile';

  @override
  String get family_appTitle => 'Family account';

  @override
  String get family_brand => 'AXN Family';

  @override
  String get family_connecting => 'Connecting...';

  @override
  String get family_connectMemberBtn => 'Connect member';

  @override
  String get family_consentLabel =>
      'I agree to share my live location and match-day status with this family group.';

  @override
  String get family_doneBtn => 'Done';

  @override
  String get family_memberChildName => 'Child';

  @override
  String get family_memberChildRel => 'Child';

  @override
  String get family_memberParentName => 'Parent';

  @override
  String get family_memberParentRel => 'Parent';

  @override
  String get family_memberSiblingName => 'Sibling';

  @override
  String get family_memberSiblingRel => 'Sibling';

  @override
  String get family_notNowBtn => 'Not now';

  @override
  String get family_permCollectedBullet1 =>
      'Location permission is required to share your real-time position.';

  @override
  String get family_permCollectedBullet2 =>
      'Contacts permission is required to connect family members.';

  @override
  String get family_permCollectedBullet3 =>
      'Notification permission is required for safety alerts.';

  @override
  String get family_permCollectedTitle => 'Permissions collected';

  @override
  String get family_permOverviewLabel => 'Location & safety permissions';

  @override
  String get family_permPrivacyBullet1 =>
      'Only approved family members can see your status.';

  @override
  String get family_permPrivacyBullet2 =>
      'Your live location is shared only during match-day sessions.';

  @override
  String get family_permPrivacyBullet3 => 'Data is not used for marketing.';

  @override
  String get family_permPrivacyTitle => 'Privacy and data use';

  @override
  String get family_permUsedBullet1 =>
      'Shared only for live family safety and arrival updates.';

  @override
  String get family_permUsedBullet2 =>
      'Used to coordinate group meeting points.';

  @override
  String get family_permUsedBullet3 => 'Not stored beyond the event.';

  @override
  String get family_permUsedTitle => 'How permissions are used';

  @override
  String get family_safetySubtitle =>
      'Keep everyone connected and safe while you enjoy the match.';

  @override
  String get family_safetyTitle => 'Family safety';

  @override
  String get family_statusConnect => 'Connect';

  @override
  String get family_statusConnected => 'Connected';

  @override
  String get family_statusPending => 'Pending';

  @override
  String get family_successSubtitle =>
      'Your family member has been added successfully.';

  @override
  String get family_successTitle => 'Family connected';

  @override
  String get family_yourFamilyLabel => 'Your family';

  @override
  String get rewards_title => 'Rewards';

  @override
  String get rewards_currentTier => 'Current tier';

  @override
  String get rewards_silver => 'Silver';

  @override
  String get rewards_bronze => 'Bronze';

  @override
  String get rewards_gold => 'Gold';

  @override
  String get rewards_platinum => 'Platinum';

  @override
  String get rewards_pointsBalance => 'Points balance';

  @override
  String get rewards_pointsThisMatch => 'This matchday';

  @override
  String get rewards_earnMore => 'Earn more points';

  @override
  String get rewards_scanIn => 'Scan in at entry +50';

  @override
  String get rewards_orderFood => 'Order food & beverage +20/order';

  @override
  String get rewards_visitExhibit => 'Visit Legacy Capsule exhibit +100';

  @override
  String get rewards_bringFriend => 'Bring a friend +150';

  @override
  String get rewards_redeemFor => 'Redeem points for';

  @override
  String get rewards_merchDiscount => '15% merchandise voucher';

  @override
  String get rewards_merchCost => '1,200 pts';

  @override
  String get rewards_foodVoucher => 'Food & beverage voucher';

  @override
  String get rewards_foodCost => '800 pts';

  @override
  String get rewards_earlyEntry => 'Early stadium entry pass';

  @override
  String get rewards_earlyEntryCost => '2,500 pts';

  @override
  String get rewards_museumAccess => 'Legacy Capsule private access';

  @override
  String get rewards_museumAccessCost => '5,000 pts';

  @override
  String get smartExit_title => 'Smart Exit';

  @override
  String get smartExit_subtitle =>
      'Pick the fastest way out based on live crowd data';

  @override
  String get smartExit_recommended => 'Recommended';

  @override
  String get smartExit_fastest => 'Fastest route';

  @override
  String get smartExit_crowd => 'Crowd level';

  @override
  String get smartExit_low => 'Low';

  @override
  String get smartExit_medium => 'Medium';

  @override
  String get smartExit_high => 'High';

  @override
  String smartExit_eta(String minutes) {
    return 'ETA $minutes min';
  }

  @override
  String smartExit_gate(String name) {
    return 'Gate $name';
  }

  @override
  String get smartExit_start => 'Start exit guidance';

  @override
  String get smartExit_live => 'LIVE';

  @override
  String get smartExit_etaLabel => 'ETA';

  @override
  String get smartExit_distanceLabel => 'DISTANCE';

  @override
  String get smartExit_exitStrategy => 'Exit Strategy';

  @override
  String get smartExit_findMyCar => 'Find My Car';

  @override
  String get smartExit_coolingZones => 'Cooling Zones';

  @override
  String get smartExit_firstAid => 'First Aid';

  @override
  String get smartExit_foodCourt => 'Food Court';

  @override
  String get smartExit_comingSoon => 'Coming soon';

  @override
  String get smartExit_startGuidedExit => 'START GUIDED EXIT';

  @override
  String get sos_title => 'Emergency SOS';

  @override
  String get sos_subtitle =>
      'Hold for 3 seconds to alert response teams with your live location';

  @override
  String get sos_holdButton => 'HOLD TO ACTIVATE';

  @override
  String get sos_cancel => 'Cancel';

  @override
  String sos_countdown(String seconds) {
    return 'Releasing cancels… $seconds';
  }

  @override
  String get sos_confirmationTitle => 'Alert sent successfully';

  @override
  String get sos_confirmationSub =>
      'Response teams are on their way. Your live location is being shared.';

  @override
  String get sos_sharingLocation => 'Sharing live location';

  @override
  String get sos_callResponder => 'Call responder';

  @override
  String get sos_falseAlarm => 'False alarm — cancel alert';

  @override
  String get sos_done => 'Done';

  @override
  String get findCar_title => 'Find My Car';

  @override
  String get findCar_subtitle => 'Guided navigation to your parking spot';

  @override
  String findCar_zone(String id) {
    return 'Zone $id';
  }

  @override
  String findCar_row(String name) {
    return 'Row $name';
  }

  @override
  String findCar_spot(String number) {
    return 'Spot $number';
  }

  @override
  String findCar_level(String num) {
    return 'Level $num';
  }

  @override
  String findCar_walkTime(String minutes) {
    return '~$minutes min walk';
  }

  @override
  String get findCar_startNav => 'Start navigation';

  @override
  String get findCar_updateSpot => 'Update my spot';

  @override
  String get trip_title => 'Evening Plan';

  @override
  String get trip_subtitle => 'Your curated schedule for tonight\'s matchday';

  @override
  String trip_startsAt(String time) {
    return 'Starts at $time';
  }

  @override
  String trip_endsAt(String time) {
    return 'Ends at $time';
  }

  @override
  String trip_stops(String count) {
    return '$count stops';
  }

  @override
  String trip_totalDuration(String hours) {
    return 'Total duration ~${hours}h';
  }

  @override
  String get trip_leaveNow => 'Leave now';

  @override
  String get trip_leaveEarlier => 'Leave earlier tonight';

  @override
  String trip_leaveSoon(String stop) {
    return 'Leave soon to make it on time for your first stop: $stop';
  }

  @override
  String trip_kickoffIn(String time) {
    return 'Kickoff in $time';
  }

  @override
  String get trip_sharePlanPrefix => 'My evening plan:';

  @override
  String get trip_categoryLabel => 'Category';

  @override
  String get trip_categoryFood => 'Food & drink';

  @override
  String get trip_categorySport => 'Sport';

  @override
  String get trip_categoryArt => 'Art & culture';

  @override
  String get trip_categoryRelax => 'Relax';

  @override
  String get trip_hintTitleExample => 'e.g. Dinner at Rem';

  @override
  String get trip_hintDetailsExample => 'e.g. 10 min walk';

  @override
  String get trip_planCopied => 'Plan copied to share';

  @override
  String get trip_addedToPlan => 'Added to your plan';

  @override
  String get trip_planCleared => 'Plan cleared';

  @override
  String get trip_clearThisPlanTitle => 'Clear this plan?';

  @override
  String trip_clearThisPlanBody(String count) {
    return 'All $count stops will be removed. You can build a new plan from scratch after.';
  }

  @override
  String get trip_clearPlan => 'Clear plan';

  @override
  String get trip_cancel => 'Cancel';

  @override
  String get trip_opensDirectionsNextStop =>
      'Opens directions to your next stop';

  @override
  String get trip_tonightsPlan => 'Tonight\'s plan';

  @override
  String trip_leaveByHint(Object time) {
    return 'Leave by 5:40 to catch the fan zone before kickoff.';
  }

  @override
  String get trip_navigateNextStop => 'Navigate to next stop';

  @override
  String get trip_addAStop => 'Add a stop';

  @override
  String get trip_getDirections => 'Get directions';

  @override
  String get trip_addToPlan => 'Add to plan';

  @override
  String get trip_fieldTitle => 'Title';

  @override
  String get trip_fieldTime => 'Time';

  @override
  String get trip_fieldDetailsOptional => 'Details (optional)';

  @override
  String get trip_hintExample => 'e.g. 6:45 PM';

  @override
  String get trip_formError => 'Add a title and a time like \"6:45 PM\".';

  @override
  String get trip_myEveningPlan => 'My evening plan';

  @override
  String get trip_notePrefix => 'Note: ';

  @override
  String get aiPlanner_title => 'AI Planner';

  @override
  String get aiPlanner_subtitle =>
      'Tell us what you want — we\'ll build your perfect matchday experience';

  @override
  String get aiPlanner_placeholder =>
      'e.g. I want to watch the warm-up, grab food before kickoff, and visit the Legacy Capsule at halftime…';

  @override
  String get aiPlanner_send => 'Generate plan';

  @override
  String get aiPlanner_thinking => 'Planning your perfect evening…';

  @override
  String get aiPlanner_suggestions => 'Try saying:';

  @override
  String get aiPlanner_suggestion1 => 'Family-friendly with early exit';

  @override
  String get aiPlanner_suggestion2 => 'Premium lounge + meet the players';

  @override
  String get aiPlanner_suggestion3 => 'Quick visit: match only';

  @override
  String get aiPlanner_online => 'ONLINE';

  @override
  String get aiPlanner_simulatedMode =>
      'Running in simulated mode — add a real API key in Settings to enable live responses.';

  @override
  String get aiPlanner_welcome =>
      'Ahlan! I am Abu Al-Areef (ابو العريف), your AXN Smart City co-pilot. How can I help you plan your evening, navigate the stadium, find parking, or suggest places to visit in Jordan today?';

  @override
  String get aiPlanner_quickQuery1 => 'How is Gate 1 density?';

  @override
  String get aiPlanner_quickQuery2 => 'Suggest a quiet cafe';

  @override
  String get aiPlanner_quickQuery3 => 'Find my parking spot';

  @override
  String get aiPlanner_quickQuery4 => 'Plan my evening in Amman';

  @override
  String get aiPlanner_quickQuery5 => 'Places to visit in Jordan';

  @override
  String get aiPlanner_responseDensity =>
      'Gate 1 area currently has moderate density (17,842 visitors). However, Gate 3 is extremely clear with no queues! I suggest using Gate 3 for a seamless exit.';

  @override
  String get aiPlanner_responseCafe =>
      'I highly recommend Al-Waha Rooftop Cafe! It has a gorgeous view of Prince Al Hussein Stadium and serves traditional cardamom coffee. It\'s just a 3-minute walk from Gate 1.';

  @override
  String get aiPlanner_responseParking =>
      'Based on your active sync, your car is parked in Zone B, Slot 42. Follow the marked path from Sector C to exit directly next to Zone B.';

  @override
  String get aiPlanner_responseEvening =>
      'For a perfect evening in Jordan, I suggest visiting the Amman Citadel to watch a spectacular sunset over the hills, followed by hot Knafeh from Habibah downtown, and then tea at a cozy rooftop in Rainbow Street.';

  @override
  String get aiPlanner_responseJordan =>
      'Jordan is rich in wonders! You must see Petra (the rose-red Nabataean city), Wadi Rum (stay in a Martian bubble camp), float in the Dead Sea, explore the Roman ruins of Jerash, and visit Ajloun Castle.';

  @override
  String get aiPlanner_responseOfftopic =>
      'Ahlan! As Abu Al-Areef, your AXN Smart City Co-Pilot, my expertise is strictly dedicated to Prince Al Hussein Stadium facilities, gates, parking, and Jordan evening exploration itineraries. I cannot answer general or off-topic questions. How can I assist with your stadium visit today?';

  @override
  String get aiPlanner_responseDefault =>
      'Ahlan! I am Abu Al-Areef, your AXN Smart City Co-Pilot. I specialize exclusively in Prince Al Hussein Stadium guidance, matchday facilities, parking, and Jordan exploration itineraries. How can I assist with your stadium visit, Gate density, or evening plans today?';

  @override
  String get activeRoute_title => 'Active Route';

  @override
  String get activeRoute_nextStop => 'Next stop';

  @override
  String activeRoute_eta(String time) {
    return 'ETA $time';
  }

  @override
  String activeRoute_progress(String current, String total) {
    return '$current of $total';
  }

  @override
  String activeRoute_remaining(String count) {
    return '$count stops remaining';
  }

  @override
  String get activeRoute_endRoute => 'End route';

  @override
  String get activeRoute_detailsTitle => 'AI Route Details';

  @override
  String get activeRoute_detailsSubtitle => 'Step-by-Step Egress Guidance';

  @override
  String get activeRoute_guidanceBadge => 'ACTIVE PATH GUIDANCE';

  @override
  String get activeRoute_optimizedBadge => 'AI OPTIMIZED';

  @override
  String get activeRoute_timelineTitle => 'STEP-BY-STEP EGRESS TIMELINE';

  @override
  String get activeRoute_returnToMap => 'RETURN TO MAP';

  @override
  String get activeRoute_oasisLabel => 'Air-Cooled Rest Oasis';

  @override
  String get activeRoute_timeLeft => 'TIME LEFT';

  @override
  String get activeRoute_distance => 'DISTANCE';

  @override
  String get activeRoute_flowStatus => 'FLOW STATUS';

  @override
  String get childSafety_title => 'Child Safety';

  @override
  String get childSafety_subtitle =>
      'Link children with safety wristbands and get instant alerts if they move outside safe zones.';

  @override
  String get childSafety_linkWristband => 'Link a wristband';

  @override
  String get childSafety_safeZones => 'Safe zones';

  @override
  String get childSafety_alertHistory => 'Alert history';

  @override
  String get childAlert_title => 'Child Alert';

  @override
  String get childAlert_active => 'Alert active';

  @override
  String get childAlert_locationShared =>
      'Live location shared with response teams';

  @override
  String get childAlert_resolve => 'Mark as resolved';

  @override
  String get profile_personalInfo => 'Personal information';

  @override
  String get profile_nationalId => 'National ID and verification';

  @override
  String get profile_myGroups => 'My groups';

  @override
  String profile_groupsCount(String count) {
    return '$count groups';
  }

  @override
  String get profile_groupsHint =>
      'Create a Family group to enable Child Safety';

  @override
  String get profile_myVisits => 'My Visits';

  @override
  String get profile_visitHistory => 'Visit history';

  @override
  String get profile_legacyCapsule => 'Legacy Capsule';

  @override
  String get profile_savedMemories => 'Your saved memories';

  @override
  String get profile_more => 'More';

  @override
  String get profile_privacyData => 'Privacy & Data';

  @override
  String get profile_everythingStored => 'Everything stored on this device';

  @override
  String get profile_settings => 'Settings';

  @override
  String get profile_rewards => 'My Rewards';

  @override
  String get profile_account => 'Account';

  @override
  String get profile_noGroups => 'No groups yet';

  @override
  String get profile_noGroupsSub =>
      'Create a group to sync locations with family or friends during your next visit.';

  @override
  String get profile_seeAll => 'See all';

  @override
  String get profile_points => 'Points';

  @override
  String get profile_trips => 'Trips';

  @override
  String get profile_tier => 'Tier';

  @override
  String get profile_family => 'Family';

  @override
  String get profile_nationalVerified => 'National ID verified';

  @override
  String get profile_group => 'Group';

  @override
  String get profile_phoneVerified => 'Phone verified';

  @override
  String profile_members(String count) {
    return '$count members';
  }

  @override
  String profile_pointsToGold(String points) {
    return '$points pts to Gold';
  }

  @override
  String get profile_silver => 'Silver';

  @override
  String get profile_matchday => 'Matchday';

  @override
  String get profile_streak => 'Streak';

  @override
  String get profile_previewGroups => 'Preview groups empty state';

  @override
  String get demo_title => 'DEMO CONTROLS';

  @override
  String get demo_subtitle => 'Not visible to regular users';

  @override
  String get demo_simulate => 'Simulate emergency broadcast';

  @override
  String get demo_simulateSub => 'Forces evacuation mode over any screen';

  @override
  String get demo_active => 'Emergency broadcast active';

  @override
  String get demo_activeSub => 'Evacuation mode is showing on the app now';

  @override
  String get demo_live => 'Broadcast live on screen';

  @override
  String get demo_startBtn => 'Simulate broadcast';

  @override
  String get demo_stopBtn => 'Stop simulation';

  @override
  String get demo_note =>
      'Tap stop anytime to instantly restore the normal screen — safe to use live during the demo.';

  @override
  String home_pointsLabel(String points) {
    return '$points pts';
  }

  @override
  String get home_envAirValue => '24°C';

  @override
  String get home_envNoiseValue => '72 dB';

  @override
  String get home_envSafetyValue => '0 incidents';

  @override
  String get sos_topbarTitle => 'Emergency SOS';

  @override
  String get sos_topbarSubtitle => 'Confirm to alert the on-site safety team';

  @override
  String get sos_typeName => 'Medical Emergency';

  @override
  String get sos_typeDescription =>
      'The nearest medical team will be dispatched to your location';

  @override
  String get sos_countdownLabel => 'seconds';

  @override
  String get sos_countdownAutoPrefix => 'Auto-sending in — ';

  @override
  String get sos_countdownHint => 'you can cancel anytime before it\'s sent.';

  @override
  String get sos_locationSectionLabel => 'YOUR LOCATION';

  @override
  String get sos_locationLabel => 'Location';

  @override
  String get sos_locationValue => 'Gate 14, Section 214';

  @override
  String get sos_gpsAccuracy => 'GPS Accurate';

  @override
  String get sos_serviceSectionLabel => 'RESPONDING SERVICE';

  @override
  String get sos_serviceName => 'Medical Response Team';

  @override
  String get sos_serviceMeta => 'On-site paramedics';

  @override
  String get sos_serviceEta => '3';

  @override
  String get sos_eta => 'min';

  @override
  String get sos_confirmButtonLabel => 'Send Alert Now';

  @override
  String get sos_cancelButtonLabel => 'Cancel';

  @override
  String get sos_cancelledToast => 'SOS alert cancelled';

  @override
  String get sos_safetyNote =>
      'Your location and emergency type are shared only with the on-site safety team.';

  @override
  String get sos_sendStep1 => 'Locating you…';

  @override
  String get sos_sendStep2 => 'Notifying safety team…';

  @override
  String get sos_sendStep3 => 'Dispatching responder…';

  @override
  String get sos_sendingTitle => 'Sending your alert';

  @override
  String get sos_sendingSubtitle =>
      'Please stay where you are — help is on the way.';

  @override
  String get sos_successTitle => 'Help is on the way';

  @override
  String get sos_successSubtitle =>
      'A responder has been notified and is heading to your location.';

  @override
  String get sos_successEtaValue => '3 min';

  @override
  String get sos_successEtaLabel => 'Estimated arrival';

  @override
  String get sos_successNearestValue => 'Gate 14';

  @override
  String get sos_successNearestLabel => 'Nearest exit';

  @override
  String get sos_successDoneLabel => 'Done';

  @override
  String get sos_failedTitle => 'Alert failed to send';

  @override
  String get sos_failedSubtitle =>
      'We couldn\'t reach the safety team. Try again or call the operations center directly.';

  @override
  String get sos_failedRetryLabel => 'Try Again';

  @override
  String get sos_failedCallLabel => 'Call Operations Center';

  @override
  String get rewards_points => 'Points';

  @override
  String rewards_pointsToTier(String points, String tier) {
    return '$points pts to $tier';
  }

  @override
  String get rewards_trips => 'Trips';

  @override
  String get rewards_tierLabel => 'Tier';

  @override
  String rewards_streakTitle(String days) {
    return '$days-day streak';
  }

  @override
  String get rewards_streakSub => 'Keep it up — one slip and it resets';

  @override
  String get rewards_currentLevelLabel => 'Current Level';

  @override
  String rewards_xpValue(String xp) {
    return '$xp XP';
  }

  @override
  String get rewards_pointsExpireTitle => 'Points Expire';

  @override
  String get rewards_featuredAchievement => 'FEATURED ACHIEVEMENT';

  @override
  String get rewards_greenLevelLabel => 'Green level';

  @override
  String get rewards_redeemButton => 'Redeem';

  @override
  String get rewards_yourTripsThisMonth => 'Your trips this month';

  @override
  String rewards_fromSource(String source) {
    return 'From $source';
  }

  @override
  String get rewards_convertedTitle => 'Converted';

  @override
  String get rewards_convertedBody =>
      'Your green points were added to your Rewards balance.';

  @override
  String get rewards_doneButton => 'Done';

  @override
  String get rewards_costLabel => 'Cost';

  @override
  String rewards_pointsSuffix(String points) {
    return '$points points';
  }

  @override
  String get rewards_redeemedTitle => 'Redeemed';

  @override
  String rewards_showCodeAt(String place) {
    return 'Show this code at $place';
  }

  @override
  String get rewards_pageTitle => 'Rewards';

  @override
  String get childSafety_lastUpdateLabel => 'Last update';

  @override
  String get childSafety_closeAlertButton => 'Close alert';

  @override
  String get rewards_silverVsGold => 'Silver vs. Gold';

  @override
  String get childAlert_activeTitle => 'Child Safety Alert';

  @override
  String get childAlert_activeMetaTriggeredAt => 'Triggered at ';

  @override
  String get childAlert_activeMetaTime => '4:52 PM';

  @override
  String get childAlert_metaSourceSep => ' · Source: ';

  @override
  String get childAlert_metaSource => 'Safe Zone Monitor';

  @override
  String get childAlert_activeGuidanceBold => 'Stay calm.';

  @override
  String get childAlert_activeGuidanceRest =>
      ' Follow the recommended steps to locate your child safely.';

  @override
  String get childAlert_foundTitle => 'Child Found';

  @override
  String get childAlert_foundMetaConfirmedAt => 'Confirmed at ';

  @override
  String get childAlert_foundMetaTime => '4:57 PM';

  @override
  String get childAlert_foundGuidanceBold => 'Great news.';

  @override
  String get childAlert_foundGuidanceRest =>
      ' Child 1 has been located and is safe. You can close this alert whenever you\'re ready.';

  @override
  String get childAlert_resolvedTitle => 'Alert Resolved';

  @override
  String get childAlert_resolvedMetaClosedAt => 'Closed at ';

  @override
  String get childAlert_resolvedMetaTime => '4:58 PM';

  @override
  String get childAlert_resolvedMetaReviewedBySep => ' · Reviewed by ';

  @override
  String get childAlert_resolvedMetaReviewedBy => 'Stadium Safety Team';

  @override
  String get childAlert_resolvedGuidance =>
      'This alert has been closed and archived. Reach out to Family Safety anytime if you have questions.';

  @override
  String get childAlert_unavailableTitle => 'Location Unavailable';

  @override
  String get childAlert_unavailableMetaLastSignal => 'Last signal ';

  @override
  String get childAlert_unavailableGuidanceBold =>
      'Signal lost, not lost hope.';

  @override
  String get childAlert_unavailableGuidanceRest =>
      ' Contact Emergency Support — stadium staff can locate Child 1 using venue cameras.';

  @override
  String get childAlertSticky_activeStatusLine => 'Left Safe Zone near Gate C';

  @override
  String get childAlertSticky_connectedLabel => 'Connected';

  @override
  String get childAlertSticky_lastKnownLocLabel => 'Last known location';

  @override
  String get childAlertSticky_outerConcourseValue =>
      'Outer Concourse, near Gate C';

  @override
  String get childAlertSticky_activeLocTime => '38s ago';

  @override
  String get childAlertSticky_foundStatusLine =>
      'Back inside Safe Zone, with a guardian nearby';

  @override
  String get childAlertSticky_currentLocLabel => 'Current location';

  @override
  String get childAlertSticky_foundLocValue => 'Gate C, Reunification Point';

  @override
  String get childAlertSticky_foundLocTime => '5s ago';

  @override
  String get childAlertSticky_unavailableStatusLine =>
      'Signal lost near Gate C';

  @override
  String get childAlertSticky_disconnectedLabel => 'Disconnected';

  @override
  String get childAlertSticky_unavailableLocTime => '6 min ago';

  @override
  String get sosHome_allSystemsNormal => 'All systems normal';

  @override
  String get sosHome_title => 'Emergency assistance';

  @override
  String get sosHome_subtitle =>
      'Help is one press away. Your location is shared automatically the moment you request help.';

  @override
  String get sosHome_holdPrefix => 'Press and hold ';

  @override
  String sosHome_holdInstructions(String seconds) {
    return 'for $seconds seconds to alert emergency teams.\nThis is not a false-alarm risk — release anytime to cancel.';
  }

  @override
  String get sosHome_servicesLabel => 'Emergency services';

  @override
  String get sosHome_locationLabel => 'Your location';

  @override
  String get sosHome_contactsLabel => 'Emergency contacts';

  @override
  String get sosHome_detectedLocationLabel => 'Detected location';

  @override
  String get sosHome_locationValue => 'Section 214, Gate 5 concourse';

  @override
  String get sosHome_gpsAccuracy => '±15m';

  @override
  String get sosHome_shareLiveLocation => 'Share live location';

  @override
  String get sosHome_shareSubtitle => 'Visible to responders while active';

  @override
  String get sosHome_serviceNamePolice => 'Police';

  @override
  String get sosHome_serviceNameAmbulance => 'Ambulance';

  @override
  String get sosHome_serviceNameCivilDefense => 'Civil Defense';

  @override
  String get sosHome_serviceNameMedical => 'Medical emergency';

  @override
  String get sosHome_serviceNameChildSafety => 'Child safety';

  @override
  String get sosHome_serviceNameLostPerson => 'Lost person';

  @override
  String get sosHome_contact1Name => 'Stadium Operations Center';

  @override
  String get sosHome_contact1Role => '24/7 control room';

  @override
  String get sosHome_contact2Name => 'Medical response team';

  @override
  String get sosHome_contact2Role => 'On-site paramedics';

  @override
  String get sosHome_contact3Name => 'Emergency contact';

  @override
  String get sosHome_contact3Role => 'Personal — added by you';

  @override
  String get sosHome_settingsTitle => 'SOS settings';

  @override
  String sosHome_holdLabel(String seconds) {
    return 'HOLD $seconds SEC';
  }

  @override
  String get findCar_startWalkback => 'START WALKBACK GUIDANCE';

  @override
  String get findCar_activeLocatorLabel => 'Active Parking Locator';

  @override
  String get findCar_zoneLabel => 'Zone B · Row 12 · Gate 2';

  @override
  String get findCar_savedAgo => 'Saved 3 hours ago';

  @override
  String get findCar_etaMinutes => '3 min';

  @override
  String get findCar_distance => '196m left';

  @override
  String get findCar_savedSlotLabel => 'SAVED PARKING SLOT';

  @override
  String get findCar_compassTracking => 'COMPASS TRACKING';

  @override
  String get evac_title => 'Evacuation Simulation';

  @override
  String get evac_heading => 'Emergency Evacuation';

  @override
  String get evac_instructions =>
      'Follow the nearest exit route. Stay calm and move quickly to the assembly point.';

  @override
  String get evac_disclaimer =>
      'This is a simulation. In a real emergency, follow official instructions.';

  @override
  String get evac_exitButton => 'Exit Simulation';

  @override
  String get createGroup_title => 'Create a group';

  @override
  String get createGroup_subtitle => 'Choose the group type first.';

  @override
  String get createGroup_familyTitle => 'Family';

  @override
  String get createGroup_familySubtitle => 'Child safety features';

  @override
  String get createGroup_groupTitle => 'Group';

  @override
  String get createGroup_groupSubtitle => 'Friends / general group';

  @override
  String get createGroup_phoneTitle => 'Phone';

  @override
  String get createGroup_mobileLabel => 'Mobile';

  @override
  String get createGroup_mobilePlaceholder => '+962 7 9XXX XXXX';

  @override
  String get createGroup_nationalIdTitle => 'National ID';

  @override
  String get createGroup_otpTitle => 'OTP';

  @override
  String get createGroup_otpSubtitle => 'Enter the verification code.';

  @override
  String get createGroup_finishButton => 'Finish';

  @override
  String get createGroup_defaultFamilyName => 'New family';

  @override
  String get createGroup_defaultGroupName => 'New group';

  @override
  String get childSafety_moderateSeverity => 'MODERATE SEVERITY';

  @override
  String get rewards_completedToday => 'Completed today';

  @override
  String rewards_missionPointsPlus(String points) {
    return '+$points points';
  }

  @override
  String rewards_missionPointsPlusPts(String points) {
    return '+$points pts';
  }

  @override
  String get rewards_healthDisclaimer =>
      'General information, not a reflection of your personal health status.';

  @override
  String get rewards_convertNote =>
      'Converted points move to your Rewards balance and reset your green progress.';

  @override
  String rewards_reachToUnlock(String points) {
    return 'Reach $points points to unlock';
  }

  @override
  String get childSafety_brandLabel => 'AXN Smart City';

  @override
  String get childSafety_pageTitle => 'Child Safety';

  @override
  String get childSafety_pageSubtitle =>
      'Keep your family connected during your visit.';

  @override
  String get childSafety_childInitials => 'C1';

  @override
  String get childSafety_childName => 'Child 1';

  @override
  String get childSafety_ageGroup => 'Age 8–12';

  @override
  String get childSafety_locationSectionLabel => 'Live location';

  @override
  String get childSafety_zoneSectionLabel => 'Safety zone';

  @override
  String get childSafety_zoneTitle => 'Allowed area · North Stand & Concourse';

  @override
  String get childSafety_activitySectionLabel => 'Activity';

  @override
  String get childSafety_lastSeenLabel => 'Last seen';

  @override
  String get childSafety_checkInLabel => 'Check-in status';

  @override
  String get childSafety_actionsSectionLabel => 'Quick actions';

  @override
  String get childSafety_callChildLabel => 'Call Child';

  @override
  String get childSafety_locateChildLabel => 'Locate Child';

  @override
  String get childSafety_checkInRequestLabel => 'Send Check-in Request';

  @override
  String get childSafety_emergencyAlertLabel => 'Emergency Alert';

  @override
  String get childSafety_timeline1Location => 'Concourse B, Section 14';

  @override
  String get childSafety_timeline1Time => 'Just now';

  @override
  String get childSafety_timeline2Location => 'Food Court, North Stand';

  @override
  String get childSafety_timeline2Time => '14 min ago';

  @override
  String get childSafety_timeline3Location => 'Entered via Gate C';

  @override
  String get childSafety_timeline3Time => '52 min ago';

  @override
  String get childSafety_normalStatusText => 'Safe and Connected';

  @override
  String get childSafety_normalStatusSub => 'Updated just now';

  @override
  String get childSafety_normalLocationValue => 'Section 14, Concourse B';

  @override
  String get childSafety_normalLocationTime => '12s ago';

  @override
  String get childSafety_normalZoneStatusText => 'Inside Safe Zone';

  @override
  String get childSafety_normalZoneSub =>
      'You\'ll be notified if Child 1 leaves this area.';

  @override
  String get childSafety_normalLastSeen => '12 seconds ago';

  @override
  String get childSafety_normalCheckInText => 'Checked in · 5 min ago';

  @override
  String get childSafety_warningConnLabel => 'Connected · weak signal';

  @override
  String get childSafety_warningStatusText => 'Left Safe Zone';

  @override
  String get childSafety_warningStatusSub => 'Updated 1 min ago';

  @override
  String get childSafety_warningLocationValue => 'Near Gate C, Outer Concourse';

  @override
  String get childSafety_warningLocationTime => '1 min ago';

  @override
  String get childSafety_warningZoneSub =>
      'Child 1 is 40m outside the allowed area near Gate C.';

  @override
  String get childSafety_warningLastSeen => '1 minute ago';

  @override
  String get childSafety_warningCheckInText =>
      'Check-in requested · awaiting reply';

  @override
  String get childSafety_offlineStatusText => 'Device Offline';

  @override
  String get childSafety_offlineStatusSub => 'Last seen 18 min ago';

  @override
  String get childSafety_offlineLocationValue => 'Last known: Concourse B';

  @override
  String get childSafety_offlineLocationTime => '18 min ago';

  @override
  String get childSafety_offlineZoneStatusText => 'Location unavailable';

  @override
  String get childSafety_offlineZoneSub =>
      'Reconnecting — showing the last known position.';

  @override
  String get childSafety_offlineLastSeen => '18 minutes ago';

  @override
  String get childSafety_offlineCheckInText => 'Unavailable while offline';

  @override
  String get childSafety_summaryAlertTriggered => 'Alert triggered';

  @override
  String get childSafety_summaryResolved => 'Resolved';

  @override
  String get childSafety_summaryDuration => 'Duration';

  @override
  String get childSafety_summaryOutcome => 'Outcome';

  @override
  String get childSafety_summaryDurationValue => '6 minutes';

  @override
  String get childSafety_summaryOutcomeValue => 'Reunited at Gate C';

  @override
  String get childSafety_recommendedActionsLabel => 'Recommended actions';

  @override
  String get childSafety_navigateToLocation => 'Navigate to Location';

  @override
  String get childSafety_shareLocation => 'Share Location';

  @override
  String get childSafety_contactEmergencySupport => 'Contact Emergency Support';

  @override
  String get childSafety_alertSummaryLabel => 'Alert summary';

  @override
  String get childAlert_locationSectionLabel => 'Location';

  @override
  String get trip_stop1Title => 'Fan Zone Warm-up';

  @override
  String get trip_stop1Sub => 'Jersey meet-up · 6 min walk';

  @override
  String get trip_stop2Title => 'Jordan vs Spain';

  @override
  String get trip_stop2Sub => 'Kickoff · Public screening';

  @override
  String get trip_stop2Note =>
      'Leave home by 5:40 — roads near the stadium fill up fast before kickoff.';

  @override
  String get trip_stop3Title => 'Riverside Art Walk';

  @override
  String get trip_stop3Sub => 'Live sketching · 10 min walk';

  @override
  String get trip_stop4Title => 'Quiet Garden Lounge';

  @override
  String get trip_stop4Sub => 'Seated · 5 min walk';

  @override
  String get rewards_ga1Label => 'Walked instead of driving';

  @override
  String get rewards_ga1Source => 'Live Map';

  @override
  String get rewards_ga2Label => 'Used shared transport';

  @override
  String get rewards_ga3Label => 'Skipped a private car trip';

  @override
  String get rewards_ga3Source => 'Smart Parking Sync';

  @override
  String get rewards_greenInfoFact =>
      'Walking short distances is generally linked to improved mood.';

  @override
  String get rewards_m1Label => 'Report a violation';

  @override
  String get rewards_m2Label => 'Keep a 7-day streak';

  @override
  String get rewards_m3Label => 'Refer a friend';

  @override
  String get rewards_m4Label => 'Complete your profile';

  @override
  String get rewards_r1Title => 'Free coffee';

  @override
  String get rewards_r1Desc =>
      'One free hot or cold drink, any size, at participating cafés.';

  @override
  String get rewards_r2Title => 'Priority parking spot';

  @override
  String get rewards_r2Desc =>
      'Reserved parking for a full day at participating downtown lots.';

  @override
  String get rewards_r3Title => 'Gallery pass';

  @override
  String get rewards_r3Desc =>
      'Full-day entry for two to the National Gallery\'s current exhibition.';

  @override
  String get rewards_v1Title => 'Free Drink';

  @override
  String get rewards_v1Desc => 'One free hot or cold beverage.';

  @override
  String get rewards_v1Expiry => 'Expires 15 Aug';

  @override
  String get rewards_v2Title => '20% Merch Discount';

  @override
  String get rewards_v2Desc => 'Off official team merchandise.';

  @override
  String get rewards_v2Expiry => 'Expires 30 Sep';

  @override
  String get rewards_v3Title => 'Food Combo';

  @override
  String get rewards_v3Desc => 'Combo meal at the food court.';

  @override
  String get rewards_v3Expiry => 'Expires 10 Oct';

  @override
  String get rewards_boardRankLabel => 'You\'re #3 in AMRA';

  @override
  String get rewards_boardSubLabel => '260 points to reach #2';

  @override
  String get rewards_leaderboardTitle => 'Leaderboard';

  @override
  String get rewards_leaderboardSubtitle => 'Amman, this month';

  @override
  String get rewards_h1Label => 'Reported a violation';

  @override
  String get rewards_h2Label => 'Daily streak bonus';

  @override
  String get rewards_h3Label => 'Redeemed: Free coffee';

  @override
  String get rewards_h4Label => 'Referred a friend';

  @override
  String get rewards_todayLabel => 'Today';

  @override
  String get rewards_yesterdayLabel => 'Yesterday';

  @override
  String get rewards_daysAgoLabel => '3 days ago';

  @override
  String get rewards_matchAttendance => 'Match Attendance';

  @override
  String get rewards_qrCheckIn => 'QR Check-in';

  @override
  String get rewards_convertedGreenPoints => 'Converted Green points';

  @override
  String get rewards_recommendationCopy =>
      'You have enough points to redeem a Free Drink Coupon.';

  @override
  String get rewards_achievementTitle => 'Stadium Explorer';

  @override
  String get rewards_achievementSub =>
      'Visited every stadium zone during your visit.';

  @override
  String get rewards_greenLevelSheetTitle => 'Green level';

  @override
  String get rewards_greenLevelSheetSubtitle =>
      'Based on your trips across the app';

  @override
  String get rewards_historySheetTitle => 'History';

  @override
  String get rewards_historySheetSubtitle => 'Every point, tracked.';

  @override
  String get rewards_missionsSheetTitle => 'Missions';

  @override
  String get rewards_missionsSheetSubtitle =>
      'Simple actions that keep you compliant — and earn points.';

  @override
  String get rewards_pointMultiplier => 'Point multiplier';

  @override
  String get rewards_monthlyBonusReward => 'Monthly bonus reward';

  @override
  String get rewards_prioritySupport => 'Priority support';

  @override
  String get rewards_freeReward => 'Free reward';

  @override
  String get rewards_included => 'Included';

  @override
  String get rewards_availableLocations => 'Available at 6 locations in Amman';

  @override
  String get rewards_valid30Days => 'Valid 30 days';

  @override
  String get rewards_earnMorePoints => 'Earn more points';

  @override
  String get rewards_recentActivity => 'Recent Activity';

  @override
  String get rewards_yourVouchers => 'Your Vouchers';

  @override
  String get rewards_redeemYourPoints => 'Redeem your points';

  @override
  String get rewards_levelAware => 'Aware';

  @override
  String get rewards_levelActive => 'Active';

  @override
  String get rewards_levelGreenGuardian => 'Green Guardian';

  @override
  String get rewards_lbName1 => 'Lina M.';

  @override
  String get rewards_lbName2 => 'Omar T.';

  @override
  String get rewards_lbName3 => 'Sara K.';

  @override
  String get rewards_lbName4 => 'Yousef A.';

  @override
  String get rewards_greeting => 'Good evening';

  @override
  String get rewards_goldTierLabel => 'Gold tier';

  @override
  String get rewards_silverMemberName => 'Silver Member';

  @override
  String get rewards_goldMemberName => 'Gold Member';

  @override
  String rewards_pointsLockedSuffix(String locked, String points) {
    return '$points points$locked';
  }

  @override
  String get rewards_lockedSuffix => ' · locked';

  @override
  String get food_bizmodel_desc =>
      'Local food brands can reach visitors through curated placement, experiences, and future event-day offers — while AXN keeps the food journey inside the city experience.';

  @override
  String get food_bizmodel_label => 'FOOD PARTNER MODEL';

  @override
  String get food_bizmodel_title =>
      'Turn food into part of the city experience.';

  @override
  String get food_brand_habibah_category => 'Sweets';

  @override
  String get food_brand_habibah_tag => 'Jordanian classic';

  @override
  String get food_brand_mansafha_category => 'Jordanian';

  @override
  String get food_brand_mansafha_tag => 'Mansaf experience';

  @override
  String get food_brand_qahwa_category => 'Coffee';

  @override
  String get food_brand_qahwa_tag => 'Local coffee pick';

  @override
  String get food_cat_coffee => 'Coffee';

  @override
  String get food_cat_jordanian => 'Jordanian';

  @override
  String get food_cat_quickBite => 'Quick bite';

  @override
  String get food_cat_sweets => 'Sweets';

  @override
  String get food_chip_eventDiscovery => 'Event-day discovery';

  @override
  String get food_chip_futureOffers => 'Future offers';

  @override
  String get food_chip_partnerVisibility => 'Partner visibility';

  @override
  String get food_explore => 'Explore';

  @override
  String get food_eyebrow => 'FOOD EXPERIENCE';

  @override
  String get food_hero_badge => 'LOCAL FLAVORS';

  @override
  String get food_hero_desc =>
      'Quick stops, Jordanian flavors, and familiar local brands — built into the visit, not left outside it.';

  @override
  String get food_hero_title => 'Eat your way through the night.';

  @override
  String get food_pill_group => 'Group';

  @override
  String get food_pill_local => 'Local';

  @override
  String get food_pill_quick => 'Quick';

  @override
  String get food_section_count => '3 PICKS';

  @override
  String get food_section_eyebrow => 'LOCAL PICKS';

  @override
  String get food_section_title =>
      'Jordanian flavors, made part of the journey.';

  @override
  String get food_subtitle =>
      'Discover food as part of the experience — from a quick coffee to a proper Jordanian bite.';

  @override
  String get food_title => 'Good food,\nright along the way.';

  @override
  String get facilities_care_desc =>
      'AXN brings essential support into the journey — not as a list of pins, but as part of how people experience the city.';

  @override
  String get facilities_care_label => 'CARE LAYER';

  @override
  String get facilities_care_title => 'A better visit\nlooks after you.';

  @override
  String get facilities_eyebrow => 'CARE / COMFORT';

  @override
  String get facilities_health_body =>
      'Make health and first-aid support easy to discover when you or someone with you needs it.';

  @override
  String get facilities_health_chip1 => 'First aid';

  @override
  String get facilities_health_chip2 => 'Health support';

  @override
  String get facilities_health_label => 'HEALTH SUPPORT';

  @override
  String get facilities_health_title => 'Help when it matters.';

  @override
  String get facilities_note =>
      'The idea: AXN does not just tell visitors where a facility is — it helps them understand when and why it matters during their journey.';

  @override
  String get facilities_prayer_body =>
      'Find a calm, respectful space for prayer without interrupting the flow of your visit.';

  @override
  String get facilities_prayer_chip1 => 'Quiet space';

  @override
  String get facilities_prayer_chip2 => 'Prayer support';

  @override
  String get facilities_prayer_label => 'PRAYER SPACES';

  @override
  String get facilities_prayer_title => 'A moment to pause.';

  @override
  String get facilities_quick_health_subtitle => 'Help when needed';

  @override
  String get facilities_quick_health_title => 'Health';

  @override
  String get facilities_quick_prayer_subtitle => 'Quiet moments';

  @override
  String get facilities_quick_prayer_title => 'Prayer';

  @override
  String get facilities_section_label => 'ESSENTIAL SPACES';

  @override
  String get facilities_section_title => 'Support beyond the destination';

  @override
  String get facilities_subtitle =>
      'Quiet spaces, prayer, and health support — built into the experience so you can focus on the moment.';

  @override
  String get facilities_title => 'Everything you need,\nwhen you need a pause.';
}
