import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class DateFormatUtils {
  DateFormatUtils._();

  static const List<String> _enMonths = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static const List<String> _arMonths = [
    'كانون الثاني', 'شباط', 'آذار', 'نيسان', 'أيار', 'حزيران',
    'تموز', 'آب', 'أيلول', 'تشرين الأول', 'تشرين الثاني', 'كانون الأول',
  ];

  static String formatDate(DateTime date, String lang) {
    final day = date.day.toString().padLeft(2, '0');
    final monthIdx = date.month - 1;
    final year = date.year.toString();
    final month = lang == 'ar' ? _arMonths[monthIdx] : _enMonths[monthIdx];
    return '$day $month $year';
  }

  static String formatDateNumeric(DateTime date, String lang) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day / $month / $year';
  }

  static String formatNumber(int number) {
    final str = number.toString();
    final reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return str.replaceAllMapped(reg, (m) => '${m[1]},');
  }

  static String toLatinDigits(String input) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    const latinDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    String result = input;
    for (int i = 0; i < 10; i++) {
      result = result.replaceAll(arabicDigits[i], latinDigits[i]);
      result = result.replaceAll(persianDigits[i], latinDigits[i]);
    }
    return result;
  }
}

class I18n {
  I18n._();

  static String _replace(String template, Map<String, String>? params) {
    if (params == null || params.isEmpty) return template;
    String result = template;
    for (final entry in params.entries) {
      result = result.replaceAll('{${entry.key}}', entry.value);
    }
    return result;
  }

  /// Look up [key] against the generated [AppLocalizations] for [lang].
  /// Named parameters (e.g. `qrChip(ticketId)`) declared in the ARB are
  /// resolved first as a typed call; if the key has no parameters the raw
  /// getter is used instead.  When a placeholder substitution is declared in
  /// the ARB but the caller uses the untyped map form, the returned string
  /// contains `{paramName}` tokens which [_replace] expands.
  static String t(String key, String lang, [Map<String, String>? params]) {
    final loc = _cache[lang] ??= _loadSync(lang);
    switch (key) {
      case 'stadium': return loc.stadium;
      case 'tagline': return loc.tagline;
      case 'city': return loc.city;
      case 'ctaTicket': return loc.ctaTicket;
      case 'ctaCreate': return loc.ctaCreate;
      case 'ctaGuest': return loc.ctaGuest;
      case 'ctaLogin': return loc.ctaLogin;
      case 'toggleLabel': return loc.toggleLabel;
      case 'notifHead': return loc.notifHead;
      case 'notif1Title': return loc.notif1Title;
      case 'notif1Body': return loc.notif1Body;
      case 'notif2Title': return loc.notif2Title;
      case 'notif2Body': return loc.notif2Body;
      case 'notif3Title': return loc.notif3Title;
      case 'notif3Body': return loc.notif3Body;
      case 'guestNote': return loc.guestNote;
      case 'btnContinue': return loc.btnContinue;
      case 'm1Eyebrow': return loc.m1Eyebrow;
      case 'm1Title': return loc.m1Title;
      case 'm1Sub': return loc.m1Sub;
      case 'm1QrTitle': return loc.m1QrTitle;
      case 'm1QrDesc': return loc.m1QrDesc;
      case 'm1ManualTitle': return loc.m1ManualTitle;
      case 'm1ManualDesc': return loc.m1ManualDesc;
      case 'qrEyebrow': return loc.qrEyebrow;
      case 'qrTitle': return loc.qrTitle;
      case 'qrSub': return loc.qrSub;
      case 'qrChip':
        return params != null && params.containsKey('ticketId')
            ? loc.qrChip(params['ticketId']!)
            : _replace('🎫 Ticket {ticketId} ready to detect', params);
      case 'qrDetected': return loc.qrDetected;
      case 'qrManualInstead': return loc.qrManualInstead;
      case 'manualTitle': return loc.manualTitle;
      case 'manualSub': return loc.manualSub;
      case 'manualLabel': return loc.manualLabel;
      case 'mcEyebrow': return loc.mcEyebrow;
      case 'mcTitle': return loc.mcTitle;
      case 'mcSub': return loc.mcSub;
      case 'mcLabel': return loc.mcLabel;
      case 'mcVerifyBtn': return loc.mcVerifyBtn;
      case 'resendPrefix': return loc.resendPrefix;
      case 'resendAction':
        return params != null && params.containsKey('countdown')
            ? loc.resendAction(params['countdown']!)
            : _replace('Resend ({countdown})', params);
      case 'otpTitle': return loc.otpTitle;
      case 'otpSub': return loc.otpSub;
      case 'otpConfirmBtn': return loc.otpConfirmBtn;
      case 'caEyebrow': return loc.caEyebrow;
      case 'caTitle': return loc.caTitle;
      case 'caSub': return loc.caSub;
      case 'lblFullName': return loc.lblFullName;
      case 'lblNationalId': return loc.lblNationalId;
      case 'lblDob': return loc.lblDob;
      case 'phDob': return loc.phDob;
      case 'lblMobile': return loc.lblMobile;
      case 'lblEmail': return loc.lblEmail;
      case 'hintEmail': return loc.hintEmail;
      case 'lblPassword': return loc.lblPassword;
      case 'lblConfirmPassword': return loc.lblConfirmPassword;
      case 'caCreateBtn': return loc.caCreateBtn;
      case 'bindTitle': return loc.bindTitle;
      case 'bindSub': return loc.bindSub;
      case 'bind1Title': return loc.bind1Title;
      case 'bind1Sub': return loc.bind1Sub;
      case 'bind2Title': return loc.bind2Title;
      case 'bind2Sub': return loc.bind2Sub;
      case 'bind3Title': return loc.bind3Title;
      case 'bind3Sub': return loc.bind3Sub;
      case 'bindEnterBtn': return loc.bindEnterBtn;
      case 'loginTitle': return loc.loginTitle;
      case 'loginSub': return loc.loginSub;
      case 'lblUserOrEmail': return loc.lblUserOrEmail;
      case 'forgotPassword': return loc.forgotPassword;
      case 'loginBtn': return loc.loginBtn;
      case 'noAccountBtn': return loc.noAccountBtn;
      case 'obSkip': return loc.obSkip;
      case 'obNext': return loc.obNext;
      case 'obStart': return loc.obStart;
      case 'splash_wordAx': return loc.splash_wordAx;
      case 'splash_wordN': return loc.splash_wordN;
      case 'splash_tagline': return loc.splash_tagline;
      case 'ob1Title': return loc.ob1Title;
      case 'ob1Desc': return loc.ob1Desc;
      case 'ob2Title': return loc.ob2Title;
      case 'ob2Desc': return loc.ob2Desc;
      case 'ob3Title': return loc.ob3Title;
      case 'ob3Desc': return loc.ob3Desc;
      case 'ob4Title': return loc.ob4Title;
      case 'ob4Desc': return loc.ob4Desc;
      case 'welcome_pipe': return loc.welcome_pipe;
      case 'methodCardQrIcon': return loc.methodCardQrIcon;
      case 'methodCardManualIcon': return loc.methodCardManualIcon;
      case 'manualPlaceholder': return loc.manualPlaceholder;
      case 'maskedEmailChip': return loc.maskedEmailChip;
      case 'maskedEmailExample': return loc.maskedEmailExample;
      case 'otpDots': return loc.otpDots;

      case 'settings_title': return loc.settings_title;
      case 'settings_back': return loc.settings_back;
      case 'settings_notifications': return loc.settings_notifications;
      case 'settings_pushTitle': return loc.settings_pushTitle;
      case 'settings_pushSub': return loc.settings_pushSub;
      case 'settings_safeZoneTitle': return loc.settings_safeZoneTitle;
      case 'settings_safeZoneSub': return loc.settings_safeZoneSub;
      case 'settings_groupActivityTitle': return loc.settings_groupActivityTitle;
      case 'settings_groupActivitySub': return loc.settings_groupActivitySub;
      case 'settings_legacyCapsuleTitle': return loc.settings_legacyCapsuleTitle;
      case 'settings_legacyCapsuleSub': return loc.settings_legacyCapsuleSub;
      case 'settings_manageSafeZones': return loc.settings_manageSafeZones;
      case 'settings_preferences': return loc.settings_preferences;
      case 'settings_language': return loc.settings_language;
      case 'settings_langEn': return loc.settings_langEn;
      case 'settings_langAr': return loc.settings_langAr;
      case 'settings_theme': return loc.settings_theme;
      case 'settings_themeLight': return loc.settings_themeLight;
      case 'settings_themeDark': return loc.settings_themeDark;
      case 'settings_themeSystem': return loc.settings_themeSystem;
      case 'settings_accessibility': return loc.settings_accessibility;
      case 'settings_fontSize': return loc.settings_fontSize;
      case 'settings_fontSmall': return loc.settings_fontSmall;
      case 'settings_fontDefault': return loc.settings_fontDefault;
      case 'settings_fontLarge': return loc.settings_fontLarge;
      case 'settings_fontXLarge': return loc.settings_fontXLarge;
      case 'settings_locationSharing': return loc.settings_locationSharing;
      case 'settings_shareLocationTitle': return loc.settings_shareLocationTitle;
      case 'settings_shareLocationSub': return loc.settings_shareLocationSub;
      case 'settings_accountSecurity': return loc.settings_accountSecurity;
      case 'settings_changePin': return loc.settings_changePin;
      case 'settings_biometricTitle': return loc.settings_biometricTitle;
      case 'settings_biometricSub': return loc.settings_biometricSub;
      case 'settings_helpSupport': return loc.settings_helpSupport;
      case 'settings_helpCenter': return loc.settings_helpCenter;
      case 'settings_contactSupport': return loc.settings_contactSupport;
      case 'settings_reportProblem': return loc.settings_reportProblem;
      case 'settings_about': return loc.settings_about;
      case 'settings_version': return loc.settings_version;
      case 'settings_terms': return loc.settings_terms;
      case 'settings_privacy': return loc.settings_privacy;
      case 'settings_logoutNote': return loc.settings_logoutNote;

      case 'home_liveVisitors': return loc.home_liveVisitors;
      case 'home_stadiumEnv': return loc.home_stadiumEnv;
      case 'home_quickAssist': return loc.home_quickAssist;
      case 'home_hello':
        return params != null && params.containsKey('name')
            ? loc.home_hello(params['name']!)
            : _replace('Ahlan, {name} 👋', params);
      case 'home_visitorsToday': return loc.home_visitorsToday;
      case 'home_atGate': return loc.home_atGate;
      case 'home_inStands': return loc.home_inStands;
      case 'home_entering': return loc.home_entering;
      case 'home_envAir': return loc.home_envAir;
      case 'home_envAirSub': return loc.home_envAirSub;
      case 'home_envNoise': return loc.home_envNoise;
      case 'home_envNoiseSub': return loc.home_envNoiseSub;
      case 'home_envCrowd': return loc.home_envCrowd;
      case 'home_envCrowdSub': return loc.home_envCrowdSub;
      case 'home_envSafety': return loc.home_envSafety;
      case 'home_envSafetySub': return loc.home_envSafetySub;
      case 'home_eveningPlan': return loc.home_eveningPlan;
      case 'home_eveningPlanSub': return loc.home_eveningPlanSub;
      case 'home_eveningTime': return loc.home_eveningTime;
      case 'home_eveningStops':
        return params != null && params.containsKey('count')
            ? loc.home_eveningStops(params['count']!)
            : _replace('{count} stops', params);
      case 'home_rewardsTitle': return loc.home_rewardsTitle;
      case 'home_rewardsPoints':
        return params != null && params.containsKey('points')
            ? loc.home_rewardsPoints(params['points']!)
            : _replace('{points} pts', params);
      case 'home_rewardsSub': return loc.home_rewardsSub;
      case 'home_rewardsTierBadge': return loc.home_rewardsTierBadge;
      case 'home_assistFindCar': return loc.home_assistFindCar;
      case 'home_assistRoute': return loc.home_assistRoute;
      case 'home_assistSmartExit': return loc.home_assistSmartExit;
      case 'home_assistAI': return loc.home_assistAI;
      case 'home_assistSOS': return loc.home_assistSOS;
      case 'home_navHome': return loc.home_navHome;
      case 'home_navRoute': return loc.home_navRoute;
      case 'home_navAlert': return loc.home_navAlert;
      case 'home_navAI': return loc.home_navAI;
      case 'home_navSettings': return loc.home_navSettings;
      case 'home_avatarInitials': return loc.home_avatarInitials;
      case 'home_liveBadge': return loc.home_liveBadge;

      case 'profile_title': return loc.profile_title;
      case 'profile_verifiedBadge': return loc.profile_verifiedBadge;
      case 'profile_ticketBound':
        return params != null && params.containsKey('id')
            ? loc.profile_ticketBound(params['id']!)
            : _replace('Ticket {id} · Bound', params);
      case 'profile_eventsAttended':
        return params != null && params.containsKey('count')
            ? loc.profile_eventsAttended(params['count']!)
            : _replace('{count} events', params);
      case 'smartExit_eta':
        return params != null && params.containsKey('minutes')
        ? loc.smartExit_eta(params['minutes']!)
        : _replace('ETA {minutes} min', params);
      case 'smartExit_gate':
        return params != null && params.containsKey('name')
            ? loc.smartExit_gate(params['name']!)
            : _replace('Gate {name}', params);
      case 'smartExit_start': return loc.smartExit_start;
      case 'smartExit_title': return loc.smartExit_title;
      case 'smartExit_subtitle': return loc.smartExit_subtitle;
      case 'smartExit_live': return loc.smartExit_live;
      case 'smartExit_etaLabel': return loc.smartExit_etaLabel;
      case 'smartExit_distanceLabel': return loc.smartExit_distanceLabel;
      case 'smartExit_exitStrategy': return loc.smartExit_exitStrategy;
      case 'smartExit_findMyCar': return loc.smartExit_findMyCar;
      case 'smartExit_coolingZones': return loc.smartExit_coolingZones;
      case 'smartExit_firstAid': return loc.smartExit_firstAid;
      case 'smartExit_foodCourt': return loc.smartExit_foodCourt;
      case 'smartExit_comingSoon': return loc.smartExit_comingSoon;
      case 'smartExit_startGuidedExit': return loc.smartExit_startGuidedExit;

      case 'sos_title': return loc.sos_title;
      case 'sos_subtitle': return loc.sos_subtitle;
      case 'sos_holdButton': return loc.sos_holdButton;
      case 'sos_cancel': return loc.sos_cancel;
      case 'sos_countdown':
        return params != null && params.containsKey('seconds')
            ? loc.sos_countdown(params['seconds']!)
            : _replace('Releasing cancels… {seconds}', params);
      case 'sos_confirmationTitle': return loc.sos_confirmationTitle;
      case 'sos_confirmationSub': return loc.sos_confirmationSub;
      case 'sos_sharingLocation': return loc.sos_sharingLocation;
      case 'sos_callResponder': return loc.sos_callResponder;
      case 'sos_falseAlarm': return loc.sos_falseAlarm;
      case 'sos_done': return loc.sos_done;
      case 'sos_cancelButtonLabel': return loc.sos_cancelButtonLabel;
      case 'sos_cancelledToast': return loc.sos_cancelledToast;
      case 'sos_confirmButtonLabel': return loc.sos_confirmButtonLabel;
      case 'sos_countdownAutoPrefix': return loc.sos_countdownAutoPrefix;
      case 'sos_countdownHint': return loc.sos_countdownHint;
      case 'sos_countdownLabel': return loc.sos_countdownLabel;
      case 'sos_eta': return loc.sos_eta;
      case 'sos_failedCallLabel': return loc.sos_failedCallLabel;
      case 'sos_failedRetryLabel': return loc.sos_failedRetryLabel;
      case 'sos_failedSubtitle': return loc.sos_failedSubtitle;
      case 'sos_failedTitle': return loc.sos_failedTitle;
      case 'sos_gpsAccuracy': return loc.sos_gpsAccuracy;
      case 'sos_locationLabel': return loc.sos_locationLabel;
      case 'sos_locationSectionLabel': return loc.sos_locationSectionLabel;
      case 'sos_locationValue': return loc.sos_locationValue;
      case 'sos_safetyNote': return loc.sos_safetyNote;
      case 'sos_sendingSubtitle': return loc.sos_sendingSubtitle;
      case 'sos_sendingTitle': return loc.sos_sendingTitle;
      case 'sos_sendStep1': return loc.sos_sendStep1;
      case 'sos_sendStep2': return loc.sos_sendStep2;
      case 'sos_sendStep3': return loc.sos_sendStep3;
      case 'sos_serviceEta': return loc.sos_serviceEta;
      case 'sos_serviceMeta': return loc.sos_serviceMeta;
      case 'sos_serviceName': return loc.sos_serviceName;
      case 'sos_serviceSectionLabel': return loc.sos_serviceSectionLabel;
      case 'sos_successDoneLabel': return loc.sos_successDoneLabel;
      case 'sos_successEtaLabel': return loc.sos_successEtaLabel;
      case 'sos_successEtaValue': return loc.sos_successEtaValue;
      case 'sos_successNearestLabel': return loc.sos_successNearestLabel;
      case 'sos_successNearestValue': return loc.sos_successNearestValue;
      case 'sos_successSubtitle': return loc.sos_successSubtitle;
      case 'sos_successTitle': return loc.sos_successTitle;
      case 'sos_topbarSubtitle': return loc.sos_topbarSubtitle;
      case 'sos_topbarTitle': return loc.sos_topbarTitle;
      case 'sos_typeDescription': return loc.sos_typeDescription;
      case 'sos_typeName': return loc.sos_typeName;

      case 'findCar_title': return loc.findCar_title;
      case 'findCar_subtitle': return loc.findCar_subtitle;
      case 'findCar_zone':
        return params != null && params.containsKey('id')
            ? loc.findCar_zone(params['id']!)
            : _replace('Zone {id}', params);
      case 'findCar_row':
        return params != null && params.containsKey('name')
            ? loc.findCar_row(params['name']!)
            : _replace('Row {name}', params);
      case 'findCar_spot':
        return params != null && params.containsKey('number')
            ? loc.findCar_spot(params['number']!)
            : _replace('Spot {number}', params);
      case 'findCar_level':
        return params != null && params.containsKey('num')
            ? loc.findCar_level(params['num']!)
            : _replace('Level {num}', params);
      case 'findCar_walkTime':
        return params != null && params.containsKey('minutes')
            ? loc.findCar_walkTime(params['minutes']!)
            : _replace('~{minutes} min walk', params);
      case 'findCar_startNav': return loc.findCar_startNav;
      case 'findCar_updateSpot': return loc.findCar_updateSpot;

      case 'trip_title': return loc.trip_title;
      case 'trip_subtitle': return loc.trip_subtitle;
      case 'trip_startsAt':
        return params != null && params.containsKey('time')
            ? loc.trip_startsAt(params['time']!)
            : _replace('Starts at {time}', params);
      case 'trip_endsAt':
        return params != null && params.containsKey('time')
            ? loc.trip_endsAt(params['time']!)
            : _replace('Ends at {time}', params);
      case 'trip_stops':
        return params != null && params.containsKey('count')
            ? loc.trip_stops(params['count']!)
            : _replace('{count} stops', params);
      case 'trip_totalDuration':
        return params != null && params.containsKey('hours')
            ? loc.trip_totalDuration(params['hours']!)
            : _replace('Total duration ~{hours}h', params);
      case 'trip_leaveNow': return loc.trip_leaveNow;
      case 'trip_leaveEarlier': return loc.trip_leaveEarlier;
      case 'trip_leaveSoon':
        return params != null && params.containsKey('stop')
            ? loc.trip_leaveSoon(params['stop']!)
            : _replace('Leave soon to make it on time for your first stop: {stop}', params);
      case 'trip_kickoffIn':
        return params != null && params.containsKey('time')
            ? loc.trip_kickoffIn(params['time']!)
            : _replace('Kickoff in {time}', params);
      case 'trip_sharePlanPrefix': return loc.trip_sharePlanPrefix;
      case 'trip_categoryLabel': return loc.trip_categoryLabel;
      case 'trip_categoryFood': return loc.trip_categoryFood;
      case 'trip_categorySport': return loc.trip_categorySport;
      case 'trip_categoryArt': return loc.trip_categoryArt;
      case 'trip_categoryRelax': return loc.trip_categoryRelax;
      case 'trip_hintTitleExample': return loc.trip_hintTitleExample;
      case 'trip_hintDetailsExample': return loc.trip_hintDetailsExample;
      case 'trip_myEveningPlan': return loc.trip_myEveningPlan;
      case 'trip_opensDirectionsNextStop': return loc.trip_opensDirectionsNextStop;
      case 'trip_tonightsPlan': return loc.trip_tonightsPlan;
      case 'trip_notePrefix': return loc.trip_notePrefix;

      case 'aiPlanner_title': return loc.aiPlanner_title;
      case 'aiPlanner_subtitle': return loc.aiPlanner_subtitle;
      case 'aiPlanner_placeholder': return loc.aiPlanner_placeholder;
      case 'aiPlanner_send': return loc.aiPlanner_send;
      case 'aiPlanner_thinking': return loc.aiPlanner_thinking;
      case 'aiPlanner_suggestions': return loc.aiPlanner_suggestions;
      case 'aiPlanner_suggestion1': return loc.aiPlanner_suggestion1;
      case 'aiPlanner_suggestion2': return loc.aiPlanner_suggestion2;
      case 'aiPlanner_suggestion3': return loc.aiPlanner_suggestion3;
      case 'aiPlanner_online': return loc.aiPlanner_online;
      case 'aiPlanner_quickQuery1': return loc.aiPlanner_quickQuery1;
      case 'aiPlanner_quickQuery2': return loc.aiPlanner_quickQuery2;
      case 'aiPlanner_quickQuery3': return loc.aiPlanner_quickQuery3;
      case 'aiPlanner_quickQuery4': return loc.aiPlanner_quickQuery4;
      case 'aiPlanner_quickQuery5': return loc.aiPlanner_quickQuery5;
      case 'aiPlanner_responseDensity': return loc.aiPlanner_responseDensity;
      case 'aiPlanner_responseCafe': return loc.aiPlanner_responseCafe;
      case 'aiPlanner_responseParking': return loc.aiPlanner_responseParking;
      case 'aiPlanner_responseEvening': return loc.aiPlanner_responseEvening;
      case 'aiPlanner_responseJordan': return loc.aiPlanner_responseJordan;
      case 'aiPlanner_responseOfftopic': return loc.aiPlanner_responseOfftopic;
      case 'aiPlanner_responseDefault': return loc.aiPlanner_responseDefault;
      case 'aiPlanner_simulatedMode': return loc.aiPlanner_simulatedMode;

      case 'activeRoute_title': return loc.activeRoute_title;
      case 'activeRoute_nextStop': return loc.activeRoute_nextStop;
      case 'activeRoute_eta':
        return params != null && params.containsKey('time')
            ? loc.activeRoute_eta(params['time']!)
            : _replace('ETA {time}', params);
      case 'activeRoute_progress':
        return (params != null && params.containsKey('current') && params.containsKey('total'))
            ? loc.activeRoute_progress(params['current']!, params['total']!)
            : _replace('{current} of {total}', params);
      case 'activeRoute_remaining':
        return params != null && params.containsKey('count')
            ? loc.activeRoute_remaining(params['count']!)
            : _replace('{count} stops remaining', params);
      case 'activeRoute_endRoute': return loc.activeRoute_endRoute;

      case 'childSafety_title': return loc.childSafety_title;
      case 'childSafety_subtitle': return loc.childSafety_subtitle;
      case 'childSafety_linkWristband': return loc.childSafety_linkWristband;
      case 'childSafety_safeZones': return loc.childSafety_safeZones;
      case 'childSafety_alertHistory': return loc.childSafety_alertHistory;
      case 'childAlert_title': return loc.childAlert_title;
      case 'childAlert_active': return loc.childAlert_active;
      case 'childAlert_locationShared': return loc.childAlert_locationShared;
      case 'childAlert_resolve': return loc.childAlert_resolve;

      case 'profile_personalInfo': return loc.profile_personalInfo;
      case 'profile_nationalId': return loc.profile_nationalId;
      case 'profile_myGroups': return loc.profile_myGroups;
      case 'profile_groupsCount':
        return params != null && params.containsKey('count')
            ? loc.profile_groupsCount(params['count']!)
            : _replace('{count} groups', params);
      case 'profile_groupsHint': return loc.profile_groupsHint;
      case 'profile_myVisits': return loc.profile_myVisits;
      case 'profile_visitHistory': return loc.profile_visitHistory;
      case 'profile_legacyCapsule': return loc.profile_legacyCapsule;
      case 'profile_savedMemories': return loc.profile_savedMemories;
      case 'profile_more': return loc.profile_more;
      case 'profile_privacyData': return loc.profile_privacyData;
      case 'profile_everythingStored': return loc.profile_everythingStored;
      case 'profile_settings': return loc.profile_settings;
      case 'profile_logout': return loc.profile_logout;
      case 'profile_rewards': return loc.profile_rewards;
      case 'profile_account': return loc.profile_account;
      case 'profile_noGroups': return loc.profile_noGroups;
      case 'profile_noGroupsSub': return loc.profile_noGroupsSub;
      case 'profile_createGroup': return loc.profile_createGroup;
      case 'profile_seeAll': return loc.profile_seeAll;
      case 'profile_points': return loc.profile_points;
      case 'profile_trips': return loc.profile_trips;
      case 'profile_tier': return loc.profile_tier;
      case 'profile_family': return loc.profile_family;
      case 'profile_nationalVerified': return loc.profile_nationalVerified;
      case 'profile_group': return loc.profile_group;
      case 'profile_phoneVerified': return loc.profile_phoneVerified;
      case 'profile_members':
        return params != null && params.containsKey('count')
            ? loc.profile_members(params['count']!)
            : _replace('{count} members', params);
      case 'profile_pointsToGold':
        return params != null && params.containsKey('points')
            ? loc.profile_pointsToGold(params['points']!)
            : _replace('{points} pts to Gold', params);
      case 'profile_silver': return loc.profile_silver;
      case 'profile_matchday': return loc.profile_matchday;
      case 'profile_streak': return loc.profile_streak;

      case 'demo_title': return loc.demo_title;
      case 'demo_subtitle': return loc.demo_subtitle;
      case 'demo_simulate': return loc.demo_simulate;
      case 'demo_simulateSub': return loc.demo_simulateSub;
      case 'demo_active': return loc.demo_active;
      case 'demo_activeSub': return loc.demo_activeSub;
      case 'demo_live': return loc.demo_live;
      case 'demo_startBtn': return loc.demo_startBtn;
      case 'demo_stopBtn': return loc.demo_stopBtn;
      case 'demo_note': return loc.demo_note;

      case 'home_pointsLabel':
        return params != null && params.containsKey('points')
            ? loc.home_pointsLabel(params['points']!)
            : _replace('{points} pts', params);

      case 'home_envAirValue': return loc.home_envAirValue;
      case 'home_envNoiseValue': return loc.home_envNoiseValue;
      case 'home_envSafetyValue': return loc.home_envSafetyValue;

      case 'profile_rewardsPoints':
        return params != null && params.containsKey('points')
            ? loc.profile_rewardsPoints(params['points']!)
            : _replace('{points} reward points', params);
      case 'profile_memberSince':
        return params != null && params.containsKey('date')
            ? loc.profile_memberSince(params['date']!)
            : _replace('Member since {date}', params);
      case 'profile_sectionActivity': return loc.profile_sectionActivity;
      case 'profile_sectionFamily': return loc.profile_sectionFamily;
      case 'profile_sectionHistory': return loc.profile_sectionHistory;
      case 'profile_sectionRewards': return loc.profile_sectionRewards;
      case 'profile_noGroupsYet': return loc.profile_noGroupsYet;
      case 'profile_editProfile': return loc.profile_editProfile;
      case 'family_appTitle': return loc.family_appTitle;
      case 'family_brand': return loc.family_brand;
      case 'family_connecting': return loc.family_connecting;
      case 'family_connectMemberBtn': return loc.family_connectMemberBtn;
      case 'family_consentLabel': return loc.family_consentLabel;
      case 'family_doneBtn': return loc.family_doneBtn;
      case 'family_memberChildName': return loc.family_memberChildName;
      case 'family_memberChildRel': return loc.family_memberChildRel;
      case 'family_memberParentName': return loc.family_memberParentName;
      case 'family_memberParentRel': return loc.family_memberParentRel;
      case 'family_memberSiblingName': return loc.family_memberSiblingName;
      case 'family_memberSiblingRel': return loc.family_memberSiblingRel;
      case 'family_notNowBtn': return loc.family_notNowBtn;
      case 'family_permCollectedBullet1': return loc.family_permCollectedBullet1;
      case 'family_permCollectedBullet2': return loc.family_permCollectedBullet2;
      case 'family_permCollectedBullet3': return loc.family_permCollectedBullet3;
      case 'family_permCollectedTitle': return loc.family_permCollectedTitle;
      case 'family_permOverviewLabel': return loc.family_permOverviewLabel;
      case 'family_permPrivacyBullet1': return loc.family_permPrivacyBullet1;
      case 'family_permPrivacyBullet2': return loc.family_permPrivacyBullet2;
      case 'family_permPrivacyBullet3': return loc.family_permPrivacyBullet3;
      case 'family_permPrivacyTitle': return loc.family_permPrivacyTitle;
      case 'family_permUsedBullet1': return loc.family_permUsedBullet1;
      case 'family_permUsedBullet2': return loc.family_permUsedBullet2;
      case 'family_permUsedBullet3': return loc.family_permUsedBullet3;
      case 'family_permUsedTitle': return loc.family_permUsedTitle;
      case 'family_safetySubtitle': return loc.family_safetySubtitle;
      case 'family_safetyTitle': return loc.family_safetyTitle;
      case 'family_statusConnect': return loc.family_statusConnect;
      case 'family_statusConnected': return loc.family_statusConnected;
      case 'family_statusPending': return loc.family_statusPending;
      case 'family_successSubtitle': return loc.family_successSubtitle;
      case 'family_successTitle': return loc.family_successTitle;
      case 'family_yourFamilyLabel': return loc.family_yourFamilyLabel;
      case 'rewards_title': return loc.rewards_title;
      case 'rewards_currentTier': return loc.rewards_currentTier;
      case 'rewards_silver': return loc.rewards_silver;
      case 'rewards_bronze': return loc.rewards_bronze;
      case 'rewards_gold': return loc.rewards_gold;
      case 'rewards_platinum': return loc.rewards_platinum;
      case 'rewards_pointsBalance': return loc.rewards_pointsBalance;
      case 'rewards_pointsThisMatch': return loc.rewards_pointsThisMatch;
      case 'rewards_earnMore': return loc.rewards_earnMore;
      case 'rewards_scanIn': return loc.rewards_scanIn;
      case 'rewards_orderFood': return loc.rewards_orderFood;
      case 'rewards_visitExhibit': return loc.rewards_visitExhibit;
      case 'rewards_bringFriend': return loc.rewards_bringFriend;
      case 'rewards_redeemFor': return loc.rewards_redeemFor;
      case 'rewards_merchDiscount': return loc.rewards_merchDiscount;
      case 'rewards_merchCost': return loc.rewards_merchCost;
      case 'rewards_foodVoucher': return loc.rewards_foodVoucher;
      case 'rewards_foodCost': return loc.rewards_foodCost;
      case 'rewards_earlyEntry': return loc.rewards_earlyEntry;
      case 'rewards_earlyEntryCost': return loc.rewards_earlyEntryCost;
      case 'rewards_museumAccess': return loc.rewards_museumAccess;
      case 'rewards_museumAccessCost': return loc.rewards_museumAccessCost;
      case 'smartExit_recommended': return loc.smartExit_recommended;
      case 'smartExit_fastest': return loc.smartExit_fastest;
      case 'smartExit_crowd': return loc.smartExit_crowd;
      case 'smartExit_low': return loc.smartExit_low;
      case 'smartExit_medium': return loc.smartExit_medium;
      case 'smartExit_high': return loc.smartExit_high;
      case 'trip_planCopied': return loc.trip_planCopied;
      case 'trip_addedToPlan': return loc.trip_addedToPlan;
      case 'trip_planCleared': return loc.trip_planCleared;
      case 'trip_clearThisPlanTitle': return loc.trip_clearThisPlanTitle;
      case 'trip_clearThisPlanBody':
        return params != null && params.containsKey('count')
            ? loc.trip_clearThisPlanBody(params['count']!)
            : _replace('All {count} stops will be removed. You can build a new plan from scratch after.', params);
      case 'trip_clearPlan': return loc.trip_clearPlan;
      case 'trip_cancel': return loc.trip_cancel;
      case 'trip_leaveByHint':
        return params != null && params.containsKey('time')
            ? loc.trip_leaveByHint(params['time']!)
            : _replace('Leave by {time} to catch the fan zone before kickoff.', params);
      case 'trip_navigateNextStop': return loc.trip_navigateNextStop;
      case 'trip_addAStop': return loc.trip_addAStop;
      case 'trip_getDirections': return loc.trip_getDirections;
      case 'trip_addToPlan': return loc.trip_addToPlan;
      case 'trip_fieldTitle': return loc.trip_fieldTitle;
      case 'trip_fieldTime': return loc.trip_fieldTime;
      case 'trip_fieldDetailsOptional': return loc.trip_fieldDetailsOptional;
      case 'trip_hintExample': return loc.trip_hintExample;
      case 'trip_formError': return loc.trip_formError;
      case 'aiPlanner_welcome': return loc.aiPlanner_welcome;
      case 'activeRoute_detailsTitle': return loc.activeRoute_detailsTitle;
      case 'activeRoute_detailsSubtitle': return loc.activeRoute_detailsSubtitle;
      case 'activeRoute_guidanceBadge': return loc.activeRoute_guidanceBadge;
      case 'activeRoute_optimizedBadge': return loc.activeRoute_optimizedBadge;
      case 'activeRoute_timelineTitle': return loc.activeRoute_timelineTitle;
      case 'activeRoute_returnToMap': return loc.activeRoute_returnToMap;
      case 'activeRoute_oasisLabel': return loc.activeRoute_oasisLabel;
      case 'activeRoute_timeLeft': return loc.activeRoute_timeLeft;
      case 'activeRoute_distance': return loc.activeRoute_distance;
      case 'activeRoute_flowStatus': return loc.activeRoute_flowStatus;
      case 'profile_previewGroups': return loc.profile_previewGroups;
      case 'rewards_points': return loc.rewards_points;
      case 'rewards_pointsToTier':
        return params != null && params.containsKey('points') && params.containsKey('tier')
            ? loc.rewards_pointsToTier(params['points']!, params['tier']!)
            : _replace('{points} pts to {tier}', params);
      case 'rewards_trips': return loc.rewards_trips;
      case 'rewards_tierLabel': return loc.rewards_tierLabel;

      case 'rewards_streakTitle':
        return params != null && params.containsKey('days')
            ? loc.rewards_streakTitle(params['days']!)
            : _replace('{days}-day streak', params);
      case 'rewards_streakSub': return loc.rewards_streakSub;
      case 'rewards_currentLevelLabel': return loc.rewards_currentLevelLabel;
      case 'rewards_xpValue':
        return params != null && params.containsKey('xp')
            ? loc.rewards_xpValue(params['xp']!)
            : _replace('{xp} XP', params);
      case 'rewards_pointsExpireTitle': return loc.rewards_pointsExpireTitle;
      case 'rewards_featuredAchievement': return loc.rewards_featuredAchievement;
      case 'rewards_greenLevelLabel': return loc.rewards_greenLevelLabel;
      case 'rewards_redeemButton': return loc.rewards_redeemButton;
      case 'rewards_yourTripsThisMonth': return loc.rewards_yourTripsThisMonth;
      case 'rewards_fromSource':
        return params != null && params.containsKey('source')
            ? loc.rewards_fromSource(params['source']!)
            : _replace('From {source}', params);
      case 'rewards_convertedTitle': return loc.rewards_convertedTitle;
      case 'rewards_convertedBody': return loc.rewards_convertedBody;
      case 'rewards_doneButton': return loc.rewards_doneButton;
      case 'rewards_costLabel': return loc.rewards_costLabel;
      case 'rewards_pointsSuffix':
        return params != null && params.containsKey('points')
            ? loc.rewards_pointsSuffix(params['points']!)
            : _replace('{points} points', params);
      case 'rewards_redeemedTitle': return loc.rewards_redeemedTitle;
      case 'rewards_showCodeAt':
        return params != null && params.containsKey('place')
            ? loc.rewards_showCodeAt(params['place']!)
            : _replace('Show this code at {place}', params);
      case 'rewards_pageTitle': return loc.rewards_pageTitle;
      case 'childSafety_lastUpdateLabel': return loc.childSafety_lastUpdateLabel;
      case 'childSafety_closeAlertButton': return loc.childSafety_closeAlertButton;

      case 'rewards_silverVsGold': return loc.rewards_silverVsGold;
      case 'childAlert_activeTitle': return loc.childAlert_activeTitle;
      case 'childAlert_activeMetaTriggeredAt': return loc.childAlert_activeMetaTriggeredAt;
      case 'childAlert_activeMetaTime': return loc.childAlert_activeMetaTime;
      case 'childAlert_metaSourceSep': return loc.childAlert_metaSourceSep;
      case 'childAlert_metaSource': return loc.childAlert_metaSource;
      case 'childAlert_activeGuidanceBold': return loc.childAlert_activeGuidanceBold;
      case 'childAlert_activeGuidanceRest': return loc.childAlert_activeGuidanceRest;
      case 'childAlert_foundTitle': return loc.childAlert_foundTitle;
      case 'childAlert_foundMetaConfirmedAt': return loc.childAlert_foundMetaConfirmedAt;
      case 'childAlert_foundMetaTime': return loc.childAlert_foundMetaTime;
      case 'childAlert_foundGuidanceBold': return loc.childAlert_foundGuidanceBold;
      case 'childAlert_foundGuidanceRest': return loc.childAlert_foundGuidanceRest;
      case 'childAlert_resolvedTitle': return loc.childAlert_resolvedTitle;
      case 'childAlert_resolvedMetaClosedAt': return loc.childAlert_resolvedMetaClosedAt;
      case 'childAlert_resolvedMetaTime': return loc.childAlert_resolvedMetaTime;
      case 'childAlert_resolvedMetaReviewedBySep': return loc.childAlert_resolvedMetaReviewedBySep;
      case 'childAlert_resolvedMetaReviewedBy': return loc.childAlert_resolvedMetaReviewedBy;
      case 'childAlert_resolvedGuidance': return loc.childAlert_resolvedGuidance;
      case 'childAlert_unavailableTitle': return loc.childAlert_unavailableTitle;
      case 'childAlert_unavailableMetaLastSignal': return loc.childAlert_unavailableMetaLastSignal;
      case 'childAlert_unavailableGuidanceBold': return loc.childAlert_unavailableGuidanceBold;
      case 'childAlert_unavailableGuidanceRest': return loc.childAlert_unavailableGuidanceRest;
      case 'childAlertSticky_activeStatusLine': return loc.childAlertSticky_activeStatusLine;
      case 'childAlertSticky_connectedLabel': return loc.childAlertSticky_connectedLabel;
      case 'childAlertSticky_lastKnownLocLabel': return loc.childAlertSticky_lastKnownLocLabel;
      case 'childAlertSticky_outerConcourseValue': return loc.childAlertSticky_outerConcourseValue;
      case 'childAlertSticky_activeLocTime': return loc.childAlertSticky_activeLocTime;
      case 'childAlertSticky_foundStatusLine': return loc.childAlertSticky_foundStatusLine;
      case 'childAlertSticky_currentLocLabel': return loc.childAlertSticky_currentLocLabel;
      case 'childAlertSticky_foundLocValue': return loc.childAlertSticky_foundLocValue;
      case 'childAlertSticky_foundLocTime': return loc.childAlertSticky_foundLocTime;
      case 'childAlertSticky_unavailableStatusLine': return loc.childAlertSticky_unavailableStatusLine;
      case 'childAlertSticky_disconnectedLabel': return loc.childAlertSticky_disconnectedLabel;
      case 'childAlertSticky_unavailableLocTime': return loc.childAlertSticky_unavailableLocTime;

      case 'sosHome_allSystemsNormal': return loc.sosHome_allSystemsNormal;
      case 'sosHome_title': return loc.sosHome_title;
      case 'sosHome_subtitle': return loc.sosHome_subtitle;
      case 'sosHome_holdPrefix': return loc.sosHome_holdPrefix;
      case 'sosHome_holdInstructions':
        return params != null && params.containsKey('seconds')
            ? loc.sosHome_holdInstructions(params['seconds']!)
            : _replace('for {seconds} seconds to alert emergency teams.\nThis is not a false-alarm risk — release anytime to cancel.', params);
      case 'sosHome_servicesLabel': return loc.sosHome_servicesLabel;
      case 'sosHome_locationLabel': return loc.sosHome_locationLabel;
      case 'sosHome_contactsLabel': return loc.sosHome_contactsLabel;
      case 'sosHome_detectedLocationLabel': return loc.sosHome_detectedLocationLabel;
      case 'sosHome_locationValue': return loc.sosHome_locationValue;
      case 'sosHome_gpsAccuracy': return loc.sosHome_gpsAccuracy;
      case 'sosHome_shareLiveLocation': return loc.sosHome_shareLiveLocation;
      case 'sosHome_shareSubtitle': return loc.sosHome_shareSubtitle;
      case 'sosHome_serviceNamePolice': return loc.sosHome_serviceNamePolice;
      case 'sosHome_serviceNameAmbulance': return loc.sosHome_serviceNameAmbulance;
      case 'sosHome_serviceNameCivilDefense': return loc.sosHome_serviceNameCivilDefense;
      case 'sosHome_serviceNameMedical': return loc.sosHome_serviceNameMedical;
      case 'sosHome_serviceNameChildSafety': return loc.sosHome_serviceNameChildSafety;
      case 'sosHome_serviceNameLostPerson': return loc.sosHome_serviceNameLostPerson;
      case 'sosHome_contact1Name': return loc.sosHome_contact1Name;
      case 'sosHome_contact1Role': return loc.sosHome_contact1Role;
      case 'sosHome_contact2Name': return loc.sosHome_contact2Name;
      case 'sosHome_contact2Role': return loc.sosHome_contact2Role;
      case 'sosHome_contact3Name': return loc.sosHome_contact3Name;
      case 'sosHome_contact3Role': return loc.sosHome_contact3Role;
      case 'sosHome_settingsTitle': return loc.sosHome_settingsTitle;
      case 'sosHome_holdLabel':
        return params != null && params.containsKey('seconds')
            ? loc.sosHome_holdLabel(params['seconds']!)
            : _replace('HOLD {seconds} SEC', params);

      case 'findCar_startWalkback': return loc.findCar_startWalkback;
      case 'findCar_activeLocatorLabel': return loc.findCar_activeLocatorLabel;
      case 'findCar_zoneLabel': return loc.findCar_zoneLabel;
      case 'findCar_savedAgo': return loc.findCar_savedAgo;
      case 'findCar_etaMinutes': return loc.findCar_etaMinutes;
      case 'findCar_distance': return loc.findCar_distance;
      case 'findCar_savedSlotLabel': return loc.findCar_savedSlotLabel;
      case 'findCar_compassTracking': return loc.findCar_compassTracking;

      case 'evac_title': return loc.evac_title;
      case 'evac_heading': return loc.evac_heading;
      case 'evac_instructions': return loc.evac_instructions;
      case 'evac_disclaimer': return loc.evac_disclaimer;
      case 'evac_exitButton': return loc.evac_exitButton;

      case 'createGroup_title': return loc.createGroup_title;
      case 'createGroup_subtitle': return loc.createGroup_subtitle;
      case 'createGroup_familyTitle': return loc.createGroup_familyTitle;
      case 'createGroup_familySubtitle': return loc.createGroup_familySubtitle;
      case 'createGroup_groupTitle': return loc.createGroup_groupTitle;
      case 'createGroup_groupSubtitle': return loc.createGroup_groupSubtitle;
      case 'createGroup_phoneTitle': return loc.createGroup_phoneTitle;
      case 'createGroup_mobileLabel': return loc.createGroup_mobileLabel;
      case 'createGroup_mobilePlaceholder': return loc.createGroup_mobilePlaceholder;
      case 'createGroup_nationalIdTitle': return loc.createGroup_nationalIdTitle;
      case 'createGroup_otpTitle': return loc.createGroup_otpTitle;
      case 'createGroup_otpSubtitle': return loc.createGroup_otpSubtitle;
      case 'createGroup_finishButton': return loc.createGroup_finishButton;

      case 'createGroup_defaultFamilyName': return loc.createGroup_defaultFamilyName;
      case 'createGroup_defaultGroupName': return loc.createGroup_defaultGroupName;

      case 'childSafety_moderateSeverity': return loc.childSafety_moderateSeverity;
      case 'rewards_completedToday': return loc.rewards_completedToday;
      case 'rewards_missionPointsPlus':
        return params != null && params.containsKey('points')
            ? loc.rewards_missionPointsPlus(params['points']!)
            : _replace('+{points} points', params);
      case 'rewards_missionPointsPlusPts':
        return params != null && params.containsKey('points')
            ? loc.rewards_missionPointsPlusPts(params['points']!)
            : _replace('+{points} pts', params);
      case 'rewards_healthDisclaimer': return loc.rewards_healthDisclaimer;
      case 'rewards_convertNote': return loc.rewards_convertNote;
      case 'rewards_reachToUnlock':
        return params != null && params.containsKey('points')
            ? loc.rewards_reachToUnlock(params['points']!)
            : _replace('Reach {points} points to unlock', params);

      case 'childSafety_brandLabel': return loc.childSafety_brandLabel;
      case 'childSafety_pageTitle': return loc.childSafety_pageTitle;
      case 'childSafety_pageSubtitle': return loc.childSafety_pageSubtitle;
      case 'childSafety_childInitials': return loc.childSafety_childInitials;
      case 'childSafety_childName': return loc.childSafety_childName;
      case 'childSafety_ageGroup': return loc.childSafety_ageGroup;
      case 'childSafety_locationSectionLabel': return loc.childSafety_locationSectionLabel;
      case 'childSafety_zoneSectionLabel': return loc.childSafety_zoneSectionLabel;
      case 'childSafety_zoneTitle': return loc.childSafety_zoneTitle;
      case 'childSafety_activitySectionLabel': return loc.childSafety_activitySectionLabel;
      case 'childSafety_lastSeenLabel': return loc.childSafety_lastSeenLabel;
      case 'childSafety_checkInLabel': return loc.childSafety_checkInLabel;
      case 'childSafety_actionsSectionLabel': return loc.childSafety_actionsSectionLabel;
      case 'childSafety_callChildLabel': return loc.childSafety_callChildLabel;
      case 'childSafety_locateChildLabel': return loc.childSafety_locateChildLabel;
      case 'childSafety_checkInRequestLabel': return loc.childSafety_checkInRequestLabel;
      case 'childSafety_emergencyAlertLabel': return loc.childSafety_emergencyAlertLabel;
      case 'childSafety_timeline1Location': return loc.childSafety_timeline1Location;
      case 'childSafety_timeline1Time': return loc.childSafety_timeline1Time;
      case 'childSafety_timeline2Location': return loc.childSafety_timeline2Location;
      case 'childSafety_timeline2Time': return loc.childSafety_timeline2Time;
      case 'childSafety_timeline3Location': return loc.childSafety_timeline3Location;
      case 'childSafety_timeline3Time': return loc.childSafety_timeline3Time;
      case 'childSafety_normalStatusText': return loc.childSafety_normalStatusText;
      case 'childSafety_normalStatusSub': return loc.childSafety_normalStatusSub;
      case 'childSafety_normalLocationValue': return loc.childSafety_normalLocationValue;
      case 'childSafety_normalLocationTime': return loc.childSafety_normalLocationTime;
      case 'childSafety_normalZoneStatusText': return loc.childSafety_normalZoneStatusText;
      case 'childSafety_normalZoneSub': return loc.childSafety_normalZoneSub;
      case 'childSafety_normalLastSeen': return loc.childSafety_normalLastSeen;
      case 'childSafety_normalCheckInText': return loc.childSafety_normalCheckInText;
      case 'childSafety_warningConnLabel': return loc.childSafety_warningConnLabel;
      case 'childSafety_warningStatusText': return loc.childSafety_warningStatusText;
      case 'childSafety_warningStatusSub': return loc.childSafety_warningStatusSub;
      case 'childSafety_warningLocationValue': return loc.childSafety_warningLocationValue;
      case 'childSafety_warningLocationTime': return loc.childSafety_warningLocationTime;
      case 'childSafety_warningZoneSub': return loc.childSafety_warningZoneSub;
      case 'childSafety_warningLastSeen': return loc.childSafety_warningLastSeen;
      case 'childSafety_warningCheckInText': return loc.childSafety_warningCheckInText;
      case 'childSafety_offlineStatusText': return loc.childSafety_offlineStatusText;
      case 'childSafety_offlineStatusSub': return loc.childSafety_offlineStatusSub;
      case 'childSafety_offlineLocationValue': return loc.childSafety_offlineLocationValue;
      case 'childSafety_offlineLocationTime': return loc.childSafety_offlineLocationTime;
      case 'childSafety_offlineZoneStatusText': return loc.childSafety_offlineZoneStatusText;
      case 'childSafety_offlineZoneSub': return loc.childSafety_offlineZoneSub;
      case 'childSafety_offlineLastSeen': return loc.childSafety_offlineLastSeen;
      case 'childSafety_offlineCheckInText': return loc.childSafety_offlineCheckInText;
      case 'childSafety_summaryAlertTriggered': return loc.childSafety_summaryAlertTriggered;
      case 'childSafety_summaryResolved': return loc.childSafety_summaryResolved;
      case 'childSafety_summaryDuration': return loc.childSafety_summaryDuration;
      case 'childSafety_summaryOutcome': return loc.childSafety_summaryOutcome;
      case 'childSafety_summaryDurationValue': return loc.childSafety_summaryDurationValue;
      case 'childSafety_summaryOutcomeValue': return loc.childSafety_summaryOutcomeValue;
      case 'childSafety_recommendedActionsLabel': return loc.childSafety_recommendedActionsLabel;
      case 'childSafety_navigateToLocation': return loc.childSafety_navigateToLocation;
      case 'childSafety_shareLocation': return loc.childSafety_shareLocation;
      case 'childSafety_contactEmergencySupport': return loc.childSafety_contactEmergencySupport;
      case 'childSafety_alertSummaryLabel': return loc.childSafety_alertSummaryLabel;

      case 'childAlert_locationSectionLabel': return loc.childAlert_locationSectionLabel;

      case 'trip_stop1Title': return loc.trip_stop1Title;
      case 'trip_stop1Sub': return loc.trip_stop1Sub;
      case 'trip_stop2Title': return loc.trip_stop2Title;
      case 'trip_stop2Sub': return loc.trip_stop2Sub;
      case 'trip_stop2Note': return loc.trip_stop2Note;
      case 'trip_stop3Title': return loc.trip_stop3Title;
      case 'trip_stop3Sub': return loc.trip_stop3Sub;
      case 'trip_stop4Title': return loc.trip_stop4Title;
      case 'trip_stop4Sub': return loc.trip_stop4Sub;

      case 'rewards_ga1Label': return loc.rewards_ga1Label;
      case 'rewards_ga1Source': return loc.rewards_ga1Source;
      case 'rewards_ga2Label': return loc.rewards_ga2Label;
      case 'rewards_ga3Label': return loc.rewards_ga3Label;
      case 'rewards_ga3Source': return loc.rewards_ga3Source;
      case 'rewards_greenInfoFact': return loc.rewards_greenInfoFact;
      case 'rewards_m1Label': return loc.rewards_m1Label;
      case 'rewards_m2Label': return loc.rewards_m2Label;
      case 'rewards_m3Label': return loc.rewards_m3Label;
      case 'rewards_m4Label': return loc.rewards_m4Label;
      case 'rewards_r1Title': return loc.rewards_r1Title;
      case 'rewards_r1Desc': return loc.rewards_r1Desc;
      case 'rewards_r2Title': return loc.rewards_r2Title;
      case 'rewards_r2Desc': return loc.rewards_r2Desc;
      case 'rewards_r3Title': return loc.rewards_r3Title;
      case 'rewards_r3Desc': return loc.rewards_r3Desc;
      case 'rewards_v1Title': return loc.rewards_v1Title;
      case 'rewards_v1Desc': return loc.rewards_v1Desc;
      case 'rewards_v1Expiry': return loc.rewards_v1Expiry;
      case 'rewards_v2Title': return loc.rewards_v2Title;
      case 'rewards_v2Desc': return loc.rewards_v2Desc;
      case 'rewards_v2Expiry': return loc.rewards_v2Expiry;
      case 'rewards_v3Title': return loc.rewards_v3Title;
      case 'rewards_v3Desc': return loc.rewards_v3Desc;
      case 'rewards_v3Expiry': return loc.rewards_v3Expiry;
      case 'rewards_boardRankLabel': return loc.rewards_boardRankLabel;
      case 'rewards_boardSubLabel': return loc.rewards_boardSubLabel;
      case 'rewards_leaderboardTitle': return loc.rewards_leaderboardTitle;
      case 'rewards_leaderboardSubtitle': return loc.rewards_leaderboardSubtitle;
      case 'rewards_h1Label': return loc.rewards_h1Label;
      case 'rewards_h2Label': return loc.rewards_h2Label;
      case 'rewards_h3Label': return loc.rewards_h3Label;
      case 'rewards_h4Label': return loc.rewards_h4Label;
      case 'rewards_todayLabel': return loc.rewards_todayLabel;
      case 'rewards_yesterdayLabel': return loc.rewards_yesterdayLabel;
      case 'rewards_daysAgoLabel': return loc.rewards_daysAgoLabel;
      case 'rewards_matchAttendance': return loc.rewards_matchAttendance;
      case 'rewards_qrCheckIn': return loc.rewards_qrCheckIn;
      case 'rewards_convertedGreenPoints': return loc.rewards_convertedGreenPoints;
      case 'rewards_recommendationCopy': return loc.rewards_recommendationCopy;
      case 'rewards_achievementTitle': return loc.rewards_achievementTitle;
      case 'rewards_achievementSub': return loc.rewards_achievementSub;
      case 'rewards_greenLevelSheetTitle': return loc.rewards_greenLevelSheetTitle;
      case 'rewards_greenLevelSheetSubtitle': return loc.rewards_greenLevelSheetSubtitle;
      case 'rewards_historySheetTitle': return loc.rewards_historySheetTitle;
      case 'rewards_historySheetSubtitle': return loc.rewards_historySheetSubtitle;
      case 'rewards_missionsSheetTitle': return loc.rewards_missionsSheetTitle;
      case 'rewards_missionsSheetSubtitle': return loc.rewards_missionsSheetSubtitle;
      case 'rewards_pointMultiplier': return loc.rewards_pointMultiplier;
      case 'rewards_monthlyBonusReward': return loc.rewards_monthlyBonusReward;
      case 'rewards_prioritySupport': return loc.rewards_prioritySupport;
      case 'rewards_freeReward': return loc.rewards_freeReward;
      case 'rewards_included': return loc.rewards_included;
      case 'rewards_availableLocations': return loc.rewards_availableLocations;
      case 'rewards_valid30Days': return loc.rewards_valid30Days;
      case 'rewards_earnMorePoints': return loc.rewards_earnMorePoints;
      case 'rewards_recentActivity': return loc.rewards_recentActivity;
      case 'rewards_yourVouchers': return loc.rewards_yourVouchers;
      case 'rewards_redeemYourPoints': return loc.rewards_redeemYourPoints;
      case 'rewards_levelAware': return loc.rewards_levelAware;
      case 'rewards_levelActive': return loc.rewards_levelActive;
      case 'rewards_levelGreenGuardian': return loc.rewards_levelGreenGuardian;
      case 'rewards_lbName1': return loc.rewards_lbName1;
      case 'rewards_lbName2': return loc.rewards_lbName2;
      case 'rewards_lbName3': return loc.rewards_lbName3;
      case 'rewards_lbName4': return loc.rewards_lbName4;

      case 'rewards_greeting': return loc.rewards_greeting;
      case 'rewards_goldTierLabel': return loc.rewards_goldTierLabel;
      case 'rewards_silverMemberName': return loc.rewards_silverMemberName;
      case 'rewards_goldMemberName': return loc.rewards_goldMemberName;

      case 'rewards_pointsLockedSuffix':
        return params != null && params.containsKey('locked') && params.containsKey('points')
            ? loc.rewards_pointsLockedSuffix(params['locked']!, params['points']!)
            : _replace('{points} points{locked}', params);
      case 'rewards_lockedSuffix': return loc.rewards_lockedSuffix;

      case 'food_bizmodel_desc': return loc.food_bizmodel_desc;
      case 'food_bizmodel_label': return loc.food_bizmodel_label;
      case 'food_bizmodel_title': return loc.food_bizmodel_title;
      case 'food_brand_habibah_category': return loc.food_brand_habibah_category;
      case 'food_brand_habibah_tag': return loc.food_brand_habibah_tag;
      case 'food_brand_mansafha_category': return loc.food_brand_mansafha_category;
      case 'food_brand_mansafha_tag': return loc.food_brand_mansafha_tag;
      case 'food_brand_qahwa_category': return loc.food_brand_qahwa_category;
      case 'food_brand_qahwa_tag': return loc.food_brand_qahwa_tag;
      case 'food_cat_coffee': return loc.food_cat_coffee;
      case 'food_cat_jordanian': return loc.food_cat_jordanian;
      case 'food_cat_quickBite': return loc.food_cat_quickBite;
      case 'food_cat_sweets': return loc.food_cat_sweets;
      case 'food_chip_eventDiscovery': return loc.food_chip_eventDiscovery;
      case 'food_chip_futureOffers': return loc.food_chip_futureOffers;
      case 'food_chip_partnerVisibility': return loc.food_chip_partnerVisibility;
      case 'food_explore': return loc.food_explore;
      case 'food_eyebrow': return loc.food_eyebrow;
      case 'food_hero_badge': return loc.food_hero_badge;
      case 'food_hero_desc': return loc.food_hero_desc;
      case 'food_hero_title': return loc.food_hero_title;
      case 'food_pill_group': return loc.food_pill_group;
      case 'food_pill_local': return loc.food_pill_local;
      case 'food_pill_quick': return loc.food_pill_quick;
      case 'food_section_count': return loc.food_section_count;
      case 'food_section_eyebrow': return loc.food_section_eyebrow;
      case 'food_section_title': return loc.food_section_title;
      case 'food_subtitle': return loc.food_subtitle;
      case 'food_title': return loc.food_title;
      case 'facilities_care_desc': return loc.facilities_care_desc;
      case 'facilities_care_label': return loc.facilities_care_label;
      case 'facilities_care_title': return loc.facilities_care_title;
      case 'facilities_eyebrow': return loc.facilities_eyebrow;
      case 'facilities_health_body': return loc.facilities_health_body;
      case 'facilities_health_chip1': return loc.facilities_health_chip1;
      case 'facilities_health_chip2': return loc.facilities_health_chip2;
      case 'facilities_health_label': return loc.facilities_health_label;
      case 'facilities_health_title': return loc.facilities_health_title;
      case 'facilities_note': return loc.facilities_note;
      case 'facilities_prayer_body': return loc.facilities_prayer_body;
      case 'facilities_prayer_chip1': return loc.facilities_prayer_chip1;
      case 'facilities_prayer_chip2': return loc.facilities_prayer_chip2;
      case 'facilities_prayer_label': return loc.facilities_prayer_label;
      case 'facilities_prayer_title': return loc.facilities_prayer_title;
      case 'facilities_quick_health_subtitle': return loc.facilities_quick_health_subtitle;
      case 'facilities_quick_health_title': return loc.facilities_quick_health_title;
      case 'facilities_quick_prayer_subtitle': return loc.facilities_quick_prayer_subtitle;
      case 'facilities_quick_prayer_title': return loc.facilities_quick_prayer_title;
      case 'facilities_section_label': return loc.facilities_section_label;
      case 'facilities_section_title': return loc.facilities_section_title;
      case 'facilities_subtitle': return loc.facilities_subtitle;
      case 'facilities_title': return loc.facilities_title;

      default:
        return key;
    }
  }

  static final Map<String, AppLocalizations> _cache = <String, AppLocalizations>{};

  static AppLocalizations _loadSync(String lang) {
    return lookupAppLocalizations(Locale(lang));
  }
}

/// Holds the current language ('en' | 'ar') and notifies listeners on
/// toggle.  Fonts / text direction are driven from [lang] in
/// [AppThemeData] / the [Directionality] wrapper wired up in `main.dart`.
class LocaleController extends ChangeNotifier {
  String _lang = 'en';
  String get lang => _lang;
  bool get isArabic => _lang == 'ar';
  TextDirection get direction => isArabic ? TextDirection.rtl : TextDirection.ltr;

  String t(String key, [Map<String, String>? params]) => I18n.t(key, _lang, params);

  void toggle() {
    _lang = _lang == 'en' ? 'ar' : 'en';
    notifyListeners();
  }

  void setLang(String code) {
    if (code != 'en' && code != 'ar') return;
    if (_lang == code) return;
    _lang = code;
    notifyListeners();
  }
}
