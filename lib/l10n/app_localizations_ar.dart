// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get stadium => 'ملعب الأمير الحسين بن عبدالله الثاني';

  @override
  String get tagline =>
      'بوابتك ليوم المباراة — فعّلها مرة واحدة وادخل مباشرة في كل مرة.';

  @override
  String get city => 'مدينة عمرة الذكية';

  @override
  String get ctaTicket => 'فعّل تذكرتي';

  @override
  String get ctaCreate => 'إنشاء حساب';

  @override
  String get ctaGuest => 'تصفّح كزائر';

  @override
  String get ctaLogin => 'لدي حساب مسبقًا — تسجيل الدخول';

  @override
  String get toggleLabel => 'English';

  @override
  String get notifHead => 'الإشعارات';

  @override
  String get notif1Title => 'مرحبًا بك في مدينة عمرة الذكية';

  @override
  String get notif1Body =>
      'مركز حسابك ليوم المباراة والمواصلات وخدمات المدينة.';

  @override
  String get notif2Title => 'فعّل تذكرتك';

  @override
  String get notif2Body => 'فعّل تذكرتك لفتح تجربة يوم المباراة.';

  @override
  String get notif3Title => 'أنشئ حسابك';

  @override
  String get notif3Body =>
      'أنشئ حسابًا للاستفادة من جميع خدمات المدينة الذكية، أو تابع كزائر.';

  @override
  String get guestNote =>
      'وضع الزائر وصوله محدود. فعّل تذكرتك في أي وقت للمقاعد والتوجيه والمكافآت.';

  @override
  String get btnContinue => 'متابعة';

  @override
  String get m1Eyebrow => 'الخطوة 1 من 5';

  @override
  String get m1Title => 'كيف تريد تفعيل تذكرتك؟';

  @override
  String get m1Sub => 'اختر الطريقة الأنسب لك — سنتحقق من التذكرة تلقائيًا.';

  @override
  String get m1QrTitle => 'مسح رمز QR';

  @override
  String get m1QrDesc =>
      'افتح الكاميرا ووجّهها نحو رمز QR الخاص بتذكرتك — ستُحمَّل التفاصيل تلقائيًا.';

  @override
  String get m1ManualTitle => 'تفعيل يدوي';

  @override
  String get m1ManualDesc => 'أدخل رقم التذكرة ورمز التحقق المُرسل معها.';

  @override
  String get qrEyebrow => 'مسح الرمز';

  @override
  String get qrTitle => 'وجّه الكاميرا نحو رمز QR';

  @override
  String get qrSub =>
      'ضع الرمز داخل الإطار — سيتم اكتشافه تلقائيًا دون الحاجة لأي زر.';

  @override
  String qrChip(String ticketId) {
    return '🎫 التذكرة $ticketId جاهزة للاكتشاف';
  }

  @override
  String get qrDetected => 'تم الاكتشاف — متابعة';

  @override
  String get qrManualInstead => 'أدخل التفاصيل يدويًا بدلاً من ذلك';

  @override
  String get manualTitle => 'أدخل رقم التذكرة';

  @override
  String get manualSub => 'ستجد هذا الرقم في تذكرتك الإلكترونية أو المطبوعة.';

  @override
  String get manualLabel => 'رقم التذكرة';

  @override
  String get mcEyebrow => 'تحقق من الملكية';

  @override
  String get mcTitle => 'أدخل رمز التحقق';

  @override
  String get mcSub =>
      'أرسلنا رمزًا إلى البريد الإلكتروني المرتبط بهذه التذكرة.';

  @override
  String get mcLabel => 'رمز التحقق';

  @override
  String get mcVerifyBtn => 'تحقق من التذكرة';

  @override
  String get resendPrefix => 'لم يصلك الرمز؟ ';

  @override
  String resendAction(String countdown) {
    return 'إعادة الإرسال ($countdown)';
  }

  @override
  String get otpTitle => 'أكّد ملكيتك لهذه التذكرة';

  @override
  String get otpSub =>
      'أرسلنا رمزًا مكوّنًا من 6 أرقام إلى البريد الإلكتروني الذي أُرسلت إليه التذكرة';

  @override
  String get otpConfirmBtn => 'تأكيد والتحقق من الملكية';

  @override
  String get caEyebrow => 'إنشاء حساب';

  @override
  String get caTitle => 'أنشئ حساب AXN الخاص بك';

  @override
  String get caSub =>
      'يربط هذا الحساب تذكرتك بك، ويبقى معك لفترة طويلة بعد انتهاء الفعالية.';

  @override
  String get lblFullName => 'الاسم الكامل';

  @override
  String get lblNationalId => 'الرقم الوطني';

  @override
  String get lblDob => 'تاريخ الميلاد';

  @override
  String get phDob => 'يوم / شهر / سنة';

  @override
  String get lblMobile => 'رقم الجوال';

  @override
  String get lblEmail => 'البريد الإلكتروني';

  @override
  String get hintEmail =>
      'تمت تعبئته تلقائيًا من التذكرة — يمكنك تعديله إذا لزم الأمر.';

  @override
  String get lblPassword => 'كلمة المرور';

  @override
  String get lblConfirmPassword => 'تأكيد كلمة المرور';

  @override
  String get caCreateBtn => 'إنشاء الحساب';

  @override
  String get bindTitle => 'تم الربط بنجاح';

  @override
  String get bindSub =>
      'أصبحت تذكرتك الآن مرتبطة بحسابك وبهذا الجهاز — جاهزة للدخول إلى الفعالية.';

  @override
  String get bind1Title => 'التذكرة ⇄ الحساب';

  @override
  String get bind1Sub => 'تذكرة واحدة = حساب واحد، ولا يمكن تفعيلها مرة أخرى';

  @override
  String get bind2Title => 'الحساب ⇄ الجهاز';

  @override
  String get bind2Sub => 'تغيير الجهاز يتطلب إعادة التحقق من هويتك';

  @override
  String get bind3Title => 'حالة رمز QR';

  @override
  String get bind3Sub =>
      'أصبح رمز QR الآن مُعلَّمًا بـ«مفعّل» ولا يمكن استخدامه مرة أخرى';

  @override
  String get bindEnterBtn => 'ادخل إلى AXN';

  @override
  String get loginTitle => 'مرحبًا بعودتك';

  @override
  String get loginSub =>
      'حسابك موجود دائمًا هنا — تحقق من سجل فعالياتك ومكافآتك وذكرياتك في أي وقت.';

  @override
  String get lblUserOrEmail => 'اسم المستخدم أو البريد الإلكتروني';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get loginBtn => 'تسجيل الدخول';

  @override
  String get noAccountBtn => 'ليس لديك حساب؟ أنشئ واحدًا';

  @override
  String get obSkip => 'تخطي';

  @override
  String get obNext => 'التالي';

  @override
  String get obStart => 'البدء';

  @override
  String get splash_wordAx => 'AX';

  @override
  String get splash_wordN => 'N';

  @override
  String get splash_tagline => 'AMRA EXCHANGE NEXUS';

  @override
  String get ob1Title => 'اكتشف المدينة الذكية';

  @override
  String get ob1Desc =>
      'خريطة حيّة تعرض الفعاليات وكثافة الحشود في مدينة عمرة لحظة بلحظة.';

  @override
  String get ob2Title => 'اعثر على سيارتك فورًا';

  @override
  String get ob2Desc =>
      'خاصية العثور على سيارتي تقودك مباشرة إلى موقف سيارتك دون تيه.';

  @override
  String get ob3Title => 'سلامتك أولًا';

  @override
  String get ob3Desc =>
      'بضغطة واحدة على زر الطوارئ يتم إرسال موقعك الحي مباشرة إلى فرق الاستجابة.';

  @override
  String get ob4Title => 'جاهز للبدء؟';

  @override
  String get ob4Desc =>
      'خطط لزيارتك بتوصيات ذكية مدعومة بالذكاء الاصطناعي واستمتع بكل لحظة.';

  @override
  String get welcome_pipe => '|';

  @override
  String get methodCardQrIcon => '▦';

  @override
  String get methodCardManualIcon => '✎';

  @override
  String get manualPlaceholder => 'JFA26-XXXXXX';

  @override
  String get maskedEmailChip => '✉️ sa***@gmail.com';

  @override
  String get maskedEmailExample => 'sa***@gmail.com';

  @override
  String get otpDots => '••••••';

  @override
  String get settings_title => 'الإعدادات';

  @override
  String get settings_back => 'رجوع';

  @override
  String get settings_notifications => 'الإشعارات';

  @override
  String get settings_pushTitle => 'إشعارات الدفع';

  @override
  String get settings_pushSub => 'التنبيهات والتحديثات والعروض';

  @override
  String get settings_safeZoneTitle => 'تنبيهات المناطق الآمنة';

  @override
  String get settings_safeZoneSub => 'إشعارات دخول وخروج المناطق الجغرافية';

  @override
  String get settings_groupActivityTitle => 'تنبيهات نشاط المجموعة';

  @override
  String get settings_groupActivitySub =>
      'تحديثات من مجموعات العائلة الخاصة بك';

  @override
  String get settings_legacyCapsuleTitle => 'تنبيهات الكبسولة التراثية';

  @override
  String get settings_legacyCapsuleSub => 'إشعارات التسليم والكشف';

  @override
  String get settings_manageSafeZones => 'إدارة المناطق الآمنة';

  @override
  String get settings_preferences => 'التفضيلات';

  @override
  String get settings_language => 'اللغة';

  @override
  String get settings_langEn => 'EN';

  @override
  String get settings_langAr => 'AR';

  @override
  String get settings_theme => 'المظهر';

  @override
  String get settings_themeLight => 'فاتح';

  @override
  String get settings_themeDark => 'داكن';

  @override
  String get settings_themeSystem => 'النظام';

  @override
  String get settings_accessibility => 'إمكانية الوصول';

  @override
  String get settings_fontSize => 'حجم الخط';

  @override
  String get settings_fontSmall => 'صغير';

  @override
  String get settings_fontDefault => 'افتراضي';

  @override
  String get settings_fontLarge => 'كبير';

  @override
  String get settings_fontXLarge => 'كبير جداً';

  @override
  String get settings_locationSharing => 'الموقع والمشاركة';

  @override
  String get settings_shareLocationTitle => 'مشاركة الموقع الحي';

  @override
  String get settings_shareLocationSub => 'ظاهر لأفراد العائلة المرتبطين';

  @override
  String get settings_accountSecurity => 'الحساب والأمان';

  @override
  String get settings_changePin => 'تغيير رقم التعريف الشخصي / كلمة المرور';

  @override
  String get settings_biometricTitle => 'الفتح البيومتري';

  @override
  String get settings_biometricSub => 'معرف الوجه أو بصمة الإصبع';

  @override
  String get settings_helpSupport => 'المساعدة والدعم';

  @override
  String get settings_helpCenter => 'مركز المساعدة / الأسئلة الشائعة';

  @override
  String get settings_contactSupport => 'التواصل مع الدعم';

  @override
  String get settings_reportProblem => 'الإبلاغ عن مشكلة';

  @override
  String get settings_about => 'حول التطبيق';

  @override
  String get settings_version => 'الإصدار';

  @override
  String get settings_terms => 'شروط الخدمة';

  @override
  String get settings_privacy => 'سياسة الخصوصية';

  @override
  String get settings_logoutNote => 'تسجيل الخروج متوفر في ملفك الشخصي';

  @override
  String get home_liveVisitors => 'زوار الاستاد حالياً';

  @override
  String get home_stadiumEnv => 'بيئة الاستاد وحركة الحشود';

  @override
  String get home_quickAssist => 'الخدمات السريعة';

  @override
  String get home_avatarInitials => 'AX';

  @override
  String get home_liveBadge => 'مباشر';

  @override
  String home_hello(String name) {
    return 'أهلاً، $name 👋';
  }

  @override
  String get home_visitorsToday => 'الزوار اليوم';

  @override
  String get home_atGate => 'عند البوابة';

  @override
  String get home_inStands => 'في المدرجات';

  @override
  String get home_entering => 'يدخلون';

  @override
  String get home_envAir => 'الهواء';

  @override
  String get home_envAirSub => 'التداول والجودة';

  @override
  String get home_envNoise => 'الضجيج';

  @override
  String get home_envNoiseSub => 'مستويات الديسيبل';

  @override
  String get home_envCrowd => 'الحشد';

  @override
  String get home_envCrowdSub => 'كثافة المنطقة';

  @override
  String get home_envSafety => 'السلامة';

  @override
  String get home_envSafetySub => 'مراقب الحوادث';

  @override
  String get home_eveningPlan => 'خطتك للمساء';

  @override
  String get home_eveningPlanSub => 'اضغط لرؤية جدولك المنظم';

  @override
  String get home_eveningTime => '6:00 م — 11:30 م';

  @override
  String home_eveningStops(String count) {
    return '$count محطات';
  }

  @override
  String get home_rewardsTitle => 'مكافآت يوم المباراة';

  @override
  String home_rewardsPoints(String points) {
    return '$points نقطة';
  }

  @override
  String get home_rewardsSub => 'امسح عند الدخول، اجمع، افتح المكافآت';

  @override
  String get home_rewardsTierBadge => 'فئة الفضة';

  @override
  String get home_assistFindCar => 'العثور على سيارتي';

  @override
  String get home_assistRoute => 'مخطط المسار';

  @override
  String get home_assistSmartExit => 'الخروج الذكي';

  @override
  String get home_assistAI => 'مخطط الذكاء الاصطناعي';

  @override
  String get home_assistSOS => 'طوارئ SOS';

  @override
  String get home_navHome => 'الرئيسية';

  @override
  String get home_navRoute => 'المسار';

  @override
  String get home_navAlert => 'تنبيه';

  @override
  String get home_navAI => 'ذكاء';

  @override
  String get home_navSettings => 'الإعدادات';

  @override
  String get profile_title => 'الملف الشخصي';

  @override
  String get profile_verifiedBadge => 'حامل تذكرة موثق';

  @override
  String profile_ticketBound(String id) {
    return 'التذكرة $id · مرتبطة';
  }

  @override
  String profile_eventsAttended(String count) {
    return '$count فعاليات';
  }

  @override
  String profile_rewardsPoints(String points) {
    return '$points نقطة مكافأة';
  }

  @override
  String profile_memberSince(String date) {
    return 'عضو منذ $date';
  }

  @override
  String get profile_sectionActivity => 'النشاط الأخير';

  @override
  String get profile_sectionFamily => 'مجموعات عائلتي';

  @override
  String get profile_sectionHistory => 'سجل الفعاليات';

  @override
  String get profile_sectionRewards => 'المكافآت والمزايا';

  @override
  String get profile_createGroup => '＋  إنشاء مجموعة';

  @override
  String get profile_noGroupsYet =>
      'لا توجد مجموعات بعد — أنشئ مجموعة لربط أفراد العائلة.';

  @override
  String get profile_logout => 'تسجيل الخروج';

  @override
  String get profile_editProfile => 'تعديل الملف الشخصي';

  @override
  String get family_appTitle => 'حساب العائلة';

  @override
  String get family_brand => 'AXN العائلة';

  @override
  String get family_connecting => 'جارٍ الاتصال...';

  @override
  String get family_connectMemberBtn => 'ربط العضو';

  @override
  String get family_consentLabel =>
      'أوافق على مشاركة موقعي الحي وحالتي في يوم المباراة مع هذه المجموعة العائلية.';

  @override
  String get family_doneBtn => 'تم';

  @override
  String get family_memberChildName => 'طفل';

  @override
  String get family_memberChildRel => 'طفل';

  @override
  String get family_memberParentName => 'والد';

  @override
  String get family_memberParentRel => 'والد';

  @override
  String get family_memberSiblingName => 'شقيق/شقيقة';

  @override
  String get family_memberSiblingRel => 'شقيق/شقيقة';

  @override
  String get family_notNowBtn => 'ليس الآن';

  @override
  String get family_permCollectedBullet1 =>
      'يلزم إذن الموقع لمشاركة موقعك المباشر.';

  @override
  String get family_permCollectedBullet2 =>
      'يلزم إذن جهات الاتصال لربط أفراد العائلة.';

  @override
  String get family_permCollectedBullet3 =>
      'يلزم إذن الإشعارات للتنبيهات الأمنية.';

  @override
  String get family_permCollectedTitle => 'الأذونات المجمعة';

  @override
  String get family_permOverviewLabel => 'أذونات الموقع والسلامة';

  @override
  String get family_permPrivacyBullet1 =>
      'يمكن لأفراد العائلة المعتمدين فقط رؤية حالتك.';

  @override
  String get family_permPrivacyBullet2 =>
      'يُشارك موقعك الحي فقط أثناء جلسات يوم المباراة.';

  @override
  String get family_permPrivacyBullet3 => 'لا تُستخدم البيانات للتسويق.';

  @override
  String get family_permPrivacyTitle => 'الخصوصية واستخدام البيانات';

  @override
  String get family_permUsedBullet1 =>
      'تُشارك فقط لأمان العائلة وتحديثات الوصول.';

  @override
  String get family_permUsedBullet2 => 'تُستخدم لتنسيق نقاط التجمع.';

  @override
  String get family_permUsedBullet3 => 'لا تُخزن بعد انتهاء الحدث.';

  @override
  String get family_permUsedTitle => 'كيفية استخدام الأذونات';

  @override
  String get family_safetySubtitle =>
      'ابقَ الجميع على اتصال وآمنًا أثناء استمتاعك بالمباراة.';

  @override
  String get family_safetyTitle => 'سلامة العائلة';

  @override
  String get family_statusConnect => 'ربط';

  @override
  String get family_statusConnected => 'متصل';

  @override
  String get family_statusPending => 'قيد الانتظار';

  @override
  String get family_successSubtitle => 'تمت إضافة فرد العائلة بنجاح.';

  @override
  String get family_successTitle => 'تم ربط العائلة';

  @override
  String get family_yourFamilyLabel => 'عائلتك';

  @override
  String get rewards_title => 'المكافآت';

  @override
  String get rewards_currentTier => 'الفئة الحالية';

  @override
  String get rewards_silver => 'فضية';

  @override
  String get rewards_bronze => 'برونزية';

  @override
  String get rewards_gold => 'ذهبية';

  @override
  String get rewards_platinum => 'بلاتينية';

  @override
  String get rewards_pointsBalance => 'رصيد النقاط';

  @override
  String get rewards_pointsThisMatch => 'يوم المباراة';

  @override
  String get rewards_earnMore => 'اكسب المزيد من النقاط';

  @override
  String get rewards_scanIn => 'امسح عند الدخول +50';

  @override
  String get rewards_orderFood => 'اطلب طعام ومشروبات +20/طلب';

  @override
  String get rewards_visitExhibit => 'زر معرض الكبسولة التراثية +100';

  @override
  String get rewards_bringFriend => 'أحضر صديقاً +150';

  @override
  String get rewards_redeemFor => 'استبدل النقاط بـ';

  @override
  String get rewards_merchDiscount => 'قسيمة خصم 15% على المنتجات';

  @override
  String get rewards_merchCost => '1,200 نقطة';

  @override
  String get rewards_foodVoucher => 'قسيمة طعام ومشروبات';

  @override
  String get rewards_foodCost => '800 نقطة';

  @override
  String get rewards_earlyEntry => 'بطاقة دخول مبكر للاستاد';

  @override
  String get rewards_earlyEntryCost => '2,500 نقطة';

  @override
  String get rewards_museumAccess => 'دخول خاص للكبسولة التراثية';

  @override
  String get rewards_museumAccessCost => '5,000 نقطة';

  @override
  String get smartExit_title => 'الخروج الذكي';

  @override
  String get smartExit_subtitle =>
      'اختر أسرع طريق للخروج بناءً على بيانات الحشد الحي';

  @override
  String get smartExit_recommended => 'موصى به';

  @override
  String get smartExit_fastest => 'أسرع مسار';

  @override
  String get smartExit_crowd => 'مستوى الحشد';

  @override
  String get smartExit_low => 'منخفض';

  @override
  String get smartExit_medium => 'متوسط';

  @override
  String get smartExit_high => 'مرتفع';

  @override
  String smartExit_eta(String minutes) {
    return 'الوقت المقدر $minutes دقيقة';
  }

  @override
  String smartExit_gate(String name) {
    return 'البوابة $name';
  }

  @override
  String get smartExit_start => 'ابدأ توجيه الخروج';

  @override
  String get smartExit_live => 'مباشر';

  @override
  String get smartExit_etaLabel => 'الوقت التقديري';

  @override
  String get smartExit_distanceLabel => 'المسافة';

  @override
  String get smartExit_exitStrategy => 'خطة الخروج';

  @override
  String get smartExit_findMyCar => 'العثور على سيارتي';

  @override
  String get smartExit_coolingZones => 'مناطق التبريد';

  @override
  String get smartExit_firstAid => 'الإسعافات الأولية';

  @override
  String get smartExit_foodCourt => 'ساحة الطعام';

  @override
  String get smartExit_comingSoon => 'قريباً';

  @override
  String get smartExit_startGuidedExit => 'بدء التوجيه الحي';

  @override
  String get sos_title => 'طوارئ SOS';

  @override
  String get sos_subtitle =>
      'استمر بالضغط لمدة 3 ثوانٍ لتنبيه فرق الاستجابة بموقعك الحي';

  @override
  String get sos_holdButton => 'اضغط باستمرار للتفعيل';

  @override
  String get sos_cancel => 'إلغاء';

  @override
  String sos_countdown(String seconds) {
    return 'التحرير يلغي… $seconds';
  }

  @override
  String get sos_confirmationTitle => 'تم إرسال التنبيه بنجاح';

  @override
  String get sos_confirmationSub =>
      'فرق الاستجابة في طريقها. موقعك الحي تتم مشاركته.';

  @override
  String get sos_sharingLocation => 'يتم مشاركة الموقع الحي';

  @override
  String get sos_callResponder => 'اتصال بالمستجيب';

  @override
  String get sos_falseAlarm => 'إنذار كاذب — إلغاء التنبيه';

  @override
  String get sos_done => 'تم';

  @override
  String get findCar_title => 'العثور على سيارتي';

  @override
  String get findCar_subtitle => 'تنقل موجه إلى موقف سيارتك';

  @override
  String findCar_zone(String id) {
    return 'المنطقة $id';
  }

  @override
  String findCar_row(String name) {
    return 'الصف $name';
  }

  @override
  String findCar_spot(String number) {
    return 'الموقف $number';
  }

  @override
  String findCar_level(String num) {
    return 'الطابق $num';
  }

  @override
  String findCar_walkTime(String minutes) {
    return '~$minutes دقيقة مشياً';
  }

  @override
  String get findCar_startNav => 'ابدأ التنقل';

  @override
  String get findCar_updateSpot => 'تحديث موقفي';

  @override
  String get trip_title => 'خطة المساء';

  @override
  String get trip_subtitle => 'جدولك المنظم لليلة مباراة اليوم';

  @override
  String trip_startsAt(String time) {
    return 'يبدأ في $time';
  }

  @override
  String trip_endsAt(String time) {
    return 'ينتهي في $time';
  }

  @override
  String trip_stops(String count) {
    return '$count محطات';
  }

  @override
  String trip_totalDuration(String hours) {
    return 'المدة الإجمالية ~$hours ساعة';
  }

  @override
  String get trip_leaveNow => 'غادر الآن';

  @override
  String get trip_leaveEarlier => 'غادر أبكر هذه الليلة';

  @override
  String trip_leaveSoon(String stop) {
    return 'غادر قريباً لتصل في الوقت المناسب إلى محطتك الأولى: $stop';
  }

  @override
  String trip_kickoffIn(String time) {
    return 'يبدأ في $time';
  }

  @override
  String get trip_sharePlanPrefix => 'خطة مسائي:';

  @override
  String get trip_categoryLabel => 'الفئة';

  @override
  String get trip_categoryFood => 'الطعام و الشراب';

  @override
  String get trip_categorySport => 'الرياضة';

  @override
  String get trip_categoryArt => 'الفن و الثقافة';

  @override
  String get trip_categoryRelax => 'استرخاء';

  @override
  String get trip_hintTitleExample => 'مثال: العشاء عند ريم';

  @override
  String get trip_hintDetailsExample => 'مثال: مشي 10 دقائق';

  @override
  String get trip_planCopied => 'تم نسخ الخطة للمشاركة';

  @override
  String get trip_addedToPlan => 'تمت الإضافة إلى خطتك';

  @override
  String get trip_planCleared => 'تم مسح الخطة';

  @override
  String get trip_clearThisPlanTitle => 'مسح هذه الخطة؟';

  @override
  String trip_clearThisPlanBody(String count) {
    return 'سيتم إزالة جميع $count محطات. يمكنك بناء خطة جديدة من البداية بعد ذلك.';
  }

  @override
  String get trip_clearPlan => 'مسح الخطة';

  @override
  String get trip_cancel => 'إلغاء';

  @override
  String get trip_opensDirectionsNextStop => 'يفتح الاتجاهات إلى محطتك التالية';

  @override
  String get trip_tonightsPlan => 'خطة الليلة';

  @override
  String trip_leaveByHint(Object time) {
    return 'غادر بحلول $time لتصل إلى منطقة المشجعين قبل انطلاق المباراة.';
  }

  @override
  String get trip_navigateNextStop => 'التنقل إلى المحطة التالية';

  @override
  String get trip_addAStop => 'إضافة محطة';

  @override
  String get trip_getDirections => 'الحصول على الاتجاهات';

  @override
  String get trip_addToPlan => 'إضافة إلى الخطة';

  @override
  String get trip_fieldTitle => 'العنوان';

  @override
  String get trip_fieldTime => 'الوقت';

  @override
  String get trip_fieldDetailsOptional => 'التفاصيل (اختياري)';

  @override
  String get trip_hintExample => 'مثال: 6:45 م';

  @override
  String get trip_formError => 'أضف عنوانًا ووقتًا مثل \"6:45 م\".';

  @override
  String get trip_myEveningPlan => 'خطة المساء';

  @override
  String get trip_notePrefix => 'ملاحظة: ';

  @override
  String get aiPlanner_title => 'مخطط الذكاء الاصطناعي';

  @override
  String get aiPlanner_subtitle =>
      'أخبرنا ماذا تريد — سنبني تجربة يوم المباراة المثالية لك';

  @override
  String get aiPlanner_placeholder =>
      'مثال: أريد مشاهدة الإحماء، وتناول الطعام قبل بداية المباراة، وزيارة الكبسولة التراثية في وقت الاستراحة…';

  @override
  String get aiPlanner_send => 'إنشاء الخطة';

  @override
  String get aiPlanner_thinking => 'نخطط لمسائك المثالي…';

  @override
  String get aiPlanner_suggestions => 'جرّب القول:';

  @override
  String get aiPlanner_suggestion1 => 'مناسب للعائلة مع خروج مبكر';

  @override
  String get aiPlanner_suggestion2 => 'صالة كبار الشخصيات + لقاء اللاعبين';

  @override
  String get aiPlanner_suggestion3 => 'زيارة سريعة: المباراة فقط';

  @override
  String get aiPlanner_online => 'متصل';

  @override
  String get aiPlanner_simulatedMode =>
      'يعمل في وضع المحاكاة — أضف مفتاح API حقيقي في الإعدادات لتفعيل الاستجابات الحية.';

  @override
  String get aiPlanner_welcome =>
      'أهلاً بك! أنا أبو العريف، مساعدك الذكي في مدينة عمرة. كيف يمكنني مساعدتك في تخطيط أمسيتك، الملاحة بالاستاد، العثور على موقف سيارتك، أو اقتراح معالم سياحية في الأردن اليوم؟';

  @override
  String get aiPlanner_quickQuery1 => 'كيف تبدو الكثافة عند بوابة ١؟';

  @override
  String get aiPlanner_quickQuery2 => 'اقترح مقهى هادئ في الاستاد';

  @override
  String get aiPlanner_quickQuery3 => 'أين موقف سيارتي؟';

  @override
  String get aiPlanner_quickQuery4 => 'خطط لأمسيتي في عمان';

  @override
  String get aiPlanner_quickQuery5 => 'أماكن مميزة لزيارتها في الأردن';

  @override
  String get aiPlanner_responseDensity =>
      'منطقة بوابة ١ بها كثافة متوسطة حالياً (١٧,٨٤٢ زائر). في المقابل، بوابة ٣ خالية تماماً من الصفوف! ننصح باستخدام بوابة ٣ لتجربة خروج سلسة وسريعة.';

  @override
  String get aiPlanner_responseCafe =>
      'ننصح بشدة بمقهى الواحة العلوي! يتميز بإطلالة ساحرة على الاستاد ويقدم القهوة العربية الأصيلة بالهال، ويبعد ٣ دقائق مشياً فقط عن بوابة ١.';

  @override
  String get aiPlanner_responseParking =>
      'بناءً على المزامنة النشطة لسيارتك، موقفك موجود في المنطقة ب، المساحة ٤٢. اتبع الممر المحدد من القطاع ج للخروج مباشرة بجوار المنطقة ب.';

  @override
  String get aiPlanner_responseEvening =>
      'لقضاء أمسية مثالية في عمان، أنصحك بالصعود لجبل القلعة لمشاهدة الغروب الآسر، تليها تحلية بالكنافة الساخنة من حبيبة في وسط البلد، ومن ثم الاسترخاء في أحد مقاهي شارع الرينبو.';

  @override
  String get aiPlanner_responseJordan =>
      'الأردن غني بالعجائب! عليك بالتأكيد زيارة البتراء (المدينة الوردية الأثرية)، وادي رم (الاستمتاع بالنجوم والمبيت في المخيمات البيئية)، البحر الميت للتجربة الفريدة، جرش الأثرية، وقلعة عجلون الشامخة.';

  @override
  String get aiPlanner_responseOfftopic =>
      'أهلاً بك! أنا أبو العريف، مساعدك الذكي في مدينة عمرة واستاد الأمير الحسين، يقتصر تخصصي حصراً على مرافق الاستاد، البوابات، المواقف، وجولات وأمسيات الأردن. أعتذر عن الإجابة على المواضيع العامة خارج هذا التخصص. كيف يمكنني مساعدتك في رحلتك بالاستاد اليوم؟';

  @override
  String get aiPlanner_responseDefault =>
      'أهلاً بك! أنا أبو العريف، مساعدك الذكي في مدينة عمرة واستاد الأمير الحسين، يقتصر تخصصي حصراً على مرافق الاستاد، البوابات، المواقف، وجولات وأمسيات الأردن. كيف يمكنني مساعدتك في معرفة كثافة البوابات أو تخطيط أمسيتك اليوم؟';

  @override
  String get activeRoute_title => 'المسار النشط';

  @override
  String get activeRoute_nextStop => 'المحطة التالية';

  @override
  String activeRoute_eta(String time) {
    return 'الوقت المقدر $time';
  }

  @override
  String activeRoute_progress(String current, String total) {
    return '$current من $total';
  }

  @override
  String activeRoute_remaining(String count) {
    return '$count محطات متبقية';
  }

  @override
  String get activeRoute_endRoute => 'إنهاء المسار';

  @override
  String get activeRoute_detailsTitle => 'تفاصيل المسار الذكي';

  @override
  String get activeRoute_detailsSubtitle => 'إرشاد حي وتوجيه مغادرة بالملاحة';

  @override
  String get activeRoute_guidanceBadge =>
      'توجيه المسار النشط بالذكاء الاصطناعي';

  @override
  String get activeRoute_optimizedBadge => 'مسار محسّن';

  @override
  String get activeRoute_timelineTitle => 'خطوات المغادرة التتابعية';

  @override
  String get activeRoute_returnToMap => 'العودة إلى الخريطة التفاعلية';

  @override
  String get activeRoute_oasisLabel => 'واحة التبريد';

  @override
  String get activeRoute_timeLeft => 'الوقت المتبقي';

  @override
  String get activeRoute_distance => 'المسافة';

  @override
  String get activeRoute_flowStatus => 'حالة التدفق';

  @override
  String get childSafety_title => 'سلامة الأطفال';

  @override
  String get childSafety_subtitle =>
      'اربط الأطفال بأساور سلامة واحصل على تنبيهات فورية إذا خرجوا من المناطق الآمنة.';

  @override
  String get childSafety_linkWristband => 'ربط سوار';

  @override
  String get childSafety_safeZones => 'المناطق الآمنة';

  @override
  String get childSafety_alertHistory => 'سجل التنبيهات';

  @override
  String get childAlert_title => 'تنبيه طفل';

  @override
  String get childAlert_active => 'التنبيه نشط';

  @override
  String get childAlert_locationShared => 'الموقع الحي مشترك مع فرق الاستجابة';

  @override
  String get childAlert_resolve => 'وضع علامة تم الحل';

  @override
  String get profile_personalInfo => 'المعلومات الشخصية';

  @override
  String get profile_nationalId => 'الرقم الوطني والتحقق';

  @override
  String get profile_myGroups => 'مجموعاتي';

  @override
  String profile_groupsCount(String count) {
    return '$count مجموعات';
  }

  @override
  String get profile_groupsHint => 'أنشئ مجموعة عائلية لتفعيل سلامة الأطفال';

  @override
  String get profile_myVisits => 'زياراتي';

  @override
  String get profile_visitHistory => 'سجل الزيارات';

  @override
  String get profile_legacyCapsule => 'الكبسولة التراثية';

  @override
  String get profile_savedMemories => 'ذكرياتك المحفوظة';

  @override
  String get profile_more => 'المزيد';

  @override
  String get profile_privacyData => 'الخصوصية والبيانات';

  @override
  String get profile_everythingStored => 'كل شيء مخزن على هذا الجهاز';

  @override
  String get profile_settings => 'الإعدادات';

  @override
  String get profile_rewards => 'مكافآتي';

  @override
  String get profile_account => 'الحساب';

  @override
  String get profile_noGroups => 'لا توجد مجموعات بعد';

  @override
  String get profile_noGroupsSub =>
      'أنشئ مجموعة لمزامنة المواقع مع العائلة أو الأصدقاء خلال زيارتك القادمة.';

  @override
  String get profile_seeAll => 'عرض الكل';

  @override
  String get profile_points => 'النقاط';

  @override
  String get profile_trips => 'الرحلات';

  @override
  String get profile_tier => 'الفئة';

  @override
  String get profile_family => 'عائلة';

  @override
  String get profile_nationalVerified => 'الرقم الوطني موثق';

  @override
  String get profile_group => 'مجموعة';

  @override
  String get profile_phoneVerified => 'الهاتف موثق';

  @override
  String profile_members(String count) {
    return '$count أعضاء';
  }

  @override
  String profile_pointsToGold(String points) {
    return '$points نقطة إلى الذهبية';
  }

  @override
  String get profile_silver => 'فضية';

  @override
  String get profile_matchday => 'يوم المباراة';

  @override
  String get profile_streak => 'متتالي';

  @override
  String get profile_previewGroups => 'معاينة الحالة الفارغة للمجموعات';

  @override
  String get demo_title => 'عناصر التحكم التجريبية';

  @override
  String get demo_subtitle => 'غير مرئي للمستخدمين العاديين';

  @override
  String get demo_simulate => 'محاكاة بث الطوارئ';

  @override
  String get demo_simulateSub => 'يفرض وضع الإخلاء فوق أي شاشة';

  @override
  String get demo_active => 'بث الطوارئ نشط';

  @override
  String get demo_activeSub => 'وضع الإخلاء يظهر على التطبيق الآن';

  @override
  String get demo_live => 'البث مباشر على الشاشة';

  @override
  String get demo_startBtn => 'محاكاة البث';

  @override
  String get demo_stopBtn => 'إيقاف المحاكاة';

  @override
  String get demo_note =>
      'اضغط إيقاف في أي وقت لاستعادة الشاشة العادية فورًا — آمن للاستخدام المباشر أثناء العرض التوضيحي.';

  @override
  String home_pointsLabel(String points) {
    return '$points نقطة';
  }

  @override
  String get home_envAirValue => '24°م';

  @override
  String get home_envNoiseValue => '72 ديسيبل';

  @override
  String get home_envSafetyValue => '0 حوادث';

  @override
  String get sos_topbarTitle => 'بلاغ الطوارئ';

  @override
  String get sos_topbarSubtitle => 'أكد لتنبيه فريق السلامة في الموقع';

  @override
  String get sos_typeName => 'حالة طبية طارئة';

  @override
  String get sos_typeDescription => 'سيتم إرسال أقرب فريق طبي إلى موقعك';

  @override
  String get sos_countdownLabel => 'ثانية';

  @override
  String get sos_countdownAutoPrefix => 'الإرسال التلقائي خلال — ';

  @override
  String get sos_countdownHint => 'يمكنك الإلغاء في أي وقت قبل الإرسال.';

  @override
  String get sos_locationSectionLabel => 'موقعك';

  @override
  String get sos_locationLabel => 'الموقع';

  @override
  String get sos_locationValue => 'البوابة 14، القسم 214';

  @override
  String get sos_gpsAccuracy => 'دقة تحديد الموقع عالية';

  @override
  String get sos_serviceSectionLabel => 'جهة الاستجابة';

  @override
  String get sos_serviceName => 'فريق الاستجابة الطبية';

  @override
  String get sos_serviceMeta => 'مسعفون في الموقع';

  @override
  String get sos_serviceEta => '3';

  @override
  String get sos_eta => 'دقيقة';

  @override
  String get sos_confirmButtonLabel => 'إرسال البلاغ الآن';

  @override
  String get sos_cancelButtonLabel => 'إلغاء';

  @override
  String get sos_cancelledToast => 'تم إلغاء بلاغ الطوارئ';

  @override
  String get sos_safetyNote =>
      'يتم مشاركة موقعك ونوع الحالة مع فريق السلامة في الموقع فقط.';

  @override
  String get sos_sendStep1 => 'جارٍ تحديد موقعك…';

  @override
  String get sos_sendStep2 => 'جارٍ إبلاغ فريق السلامة…';

  @override
  String get sos_sendStep3 => 'جارٍ إرسال المستجيب…';

  @override
  String get sos_sendingTitle => 'جارٍ إرسال بلاغك';

  @override
  String get sos_sendingSubtitle =>
      'يرجى البقاء في مكانك — المساعدة في الطريق.';

  @override
  String get sos_successTitle => 'المساعدة في الطريق';

  @override
  String get sos_successSubtitle =>
      'تم إبلاغ أحد المستجيبين وهو متجه إلى موقعك.';

  @override
  String get sos_successEtaValue => '3 دقائق';

  @override
  String get sos_successEtaLabel => 'الوصول المتوقع';

  @override
  String get sos_successNearestValue => 'البوابة 14';

  @override
  String get sos_successNearestLabel => 'أقرب مخرج';

  @override
  String get sos_successDoneLabel => 'تم';

  @override
  String get sos_failedTitle => 'تعذر إرسال البلاغ';

  @override
  String get sos_failedSubtitle =>
      'تعذّر الوصول إلى فريق السلامة. حاول مرة أخرى أو اتصل بمركز العمليات مباشرة.';

  @override
  String get sos_failedRetryLabel => 'إعادة المحاولة';

  @override
  String get sos_failedCallLabel => 'الاتصال بمركز العمليات';

  @override
  String get rewards_points => 'النقاط';

  @override
  String rewards_pointsToTier(String points, String tier) {
    return '$points نقطة للوصول إلى $tier';
  }

  @override
  String get rewards_trips => 'الزيارات';

  @override
  String get rewards_tierLabel => 'المستوى';

  @override
  String rewards_streakTitle(String days) {
    return 'سلسلة $days أيام';
  }

  @override
  String get rewards_streakSub => 'واصل التقدم — أي انقطاع يعيد العداد للصفر';

  @override
  String get rewards_currentLevelLabel => 'المستوى الحالي';

  @override
  String rewards_xpValue(String xp) {
    return '$xp نقطة خبرة';
  }

  @override
  String get rewards_pointsExpireTitle => 'انتهاء صلاحية النقاط';

  @override
  String get rewards_featuredAchievement => 'إنجاز مميز';

  @override
  String get rewards_greenLevelLabel => 'المستوى الأخضر';

  @override
  String get rewards_redeemButton => 'استبدال';

  @override
  String get rewards_yourTripsThisMonth => 'زياراتك هذا الشهر';

  @override
  String rewards_fromSource(String source) {
    return 'من $source';
  }

  @override
  String get rewards_convertedTitle => 'تم التحويل';

  @override
  String get rewards_convertedBody =>
      'تمت إضافة نقاطك الخضراء إلى رصيد المكافآت الخاص بك.';

  @override
  String get rewards_doneButton => 'تم';

  @override
  String get rewards_costLabel => 'التكلفة';

  @override
  String rewards_pointsSuffix(String points) {
    return '$points نقطة';
  }

  @override
  String get rewards_redeemedTitle => 'تم الاستبدال';

  @override
  String rewards_showCodeAt(String place) {
    return 'أظهر هذا الرمز في $place';
  }

  @override
  String get rewards_pageTitle => 'المكافآت';

  @override
  String get childSafety_lastUpdateLabel => 'آخر تحديث';

  @override
  String get childSafety_closeAlertButton => 'إغلاق التنبيه';

  @override
  String get rewards_silverVsGold => 'الفضية مقابل الذهبية';

  @override
  String get childAlert_activeTitle => 'تنبيه سلامة الطفل';

  @override
  String get childAlert_activeMetaTriggeredAt => 'تم التفعيل الساعة ';

  @override
  String get childAlert_activeMetaTime => '4:52 م';

  @override
  String get childAlert_metaSourceSep => ' · المصدر: ';

  @override
  String get childAlert_metaSource => 'مراقب المنطقة الآمنة';

  @override
  String get childAlert_activeGuidanceBold => 'حافظ على هدوئك.';

  @override
  String get childAlert_activeGuidanceRest =>
      ' اتبع الخطوات الموصى بها لتحديد موقع طفلك بأمان.';

  @override
  String get childAlert_foundTitle => 'تم العثور على الطفل';

  @override
  String get childAlert_foundMetaConfirmedAt => 'تم التأكيد الساعة ';

  @override
  String get childAlert_foundMetaTime => '4:57 م';

  @override
  String get childAlert_foundGuidanceBold => 'خبر رائع.';

  @override
  String get childAlert_foundGuidanceRest =>
      ' تم تحديد موقع الطفل 1 وهو بأمان. يمكنك إغلاق هذا التنبيه متى شئت.';

  @override
  String get childAlert_resolvedTitle => 'تم حل التنبيه';

  @override
  String get childAlert_resolvedMetaClosedAt => 'تم الإغلاق الساعة ';

  @override
  String get childAlert_resolvedMetaTime => '4:58 م';

  @override
  String get childAlert_resolvedMetaReviewedBySep => ' · تمت المراجعة بواسطة ';

  @override
  String get childAlert_resolvedMetaReviewedBy => 'فريق سلامة الملعب';

  @override
  String get childAlert_resolvedGuidance =>
      'تم إغلاق هذا التنبيه وأرشفته. تواصل مع فريق سلامة الأسرة في أي وقت إذا كانت لديك أسئلة.';

  @override
  String get childAlert_unavailableTitle => 'الموقع غير متاح';

  @override
  String get childAlert_unavailableMetaLastSignal => 'آخر إشارة ';

  @override
  String get childAlert_unavailableGuidanceBold => 'فُقدت الإشارة، لا الأمل.';

  @override
  String get childAlert_unavailableGuidanceRest =>
      ' تواصل مع دعم الطوارئ — يمكن لطاقم الملعب تحديد موقع الطفل 1 باستخدام كاميرات المكان.';

  @override
  String get childAlertSticky_activeStatusLine =>
      'غادر المنطقة الآمنة قرب البوابة C';

  @override
  String get childAlertSticky_connectedLabel => 'متصل';

  @override
  String get childAlertSticky_lastKnownLocLabel => 'آخر موقع معروف';

  @override
  String get childAlertSticky_outerConcourseValue =>
      'الرواق الخارجي، قرب البوابة C';

  @override
  String get childAlertSticky_activeLocTime => 'قبل 38 ثانية';

  @override
  String get childAlertSticky_foundStatusLine =>
      'عاد إلى المنطقة الآمنة، برفقة ولي أمر قريب';

  @override
  String get childAlertSticky_currentLocLabel => 'الموقع الحالي';

  @override
  String get childAlertSticky_foundLocValue => 'البوابة C، نقطة لمّ الشمل';

  @override
  String get childAlertSticky_foundLocTime => 'قبل 5 ثوانٍ';

  @override
  String get childAlertSticky_unavailableStatusLine =>
      'فُقدت الإشارة قرب البوابة C';

  @override
  String get childAlertSticky_disconnectedLabel => 'غير متصل';

  @override
  String get childAlertSticky_unavailableLocTime => 'قبل 6 دقائق';

  @override
  String get sosHome_allSystemsNormal => 'جميع الأنظمة تعمل بشكل طبيعي';

  @override
  String get sosHome_title => 'المساعدة الطارئة';

  @override
  String get sosHome_subtitle =>
      'المساعدة على بعد ضغطة واحدة. تتم مشاركة موقعك تلقائيًا فور طلبك للمساعدة.';

  @override
  String get sosHome_holdPrefix => 'اضغط مطولًا ';

  @override
  String sosHome_holdInstructions(String seconds) {
    return 'لمدة $seconds ثوانٍ لتنبيه فرق الطوارئ.\nهذا لا يُعد إنذارًا كاذبًا — يمكنك الإفلات في أي وقت للإلغاء.';
  }

  @override
  String get sosHome_servicesLabel => 'خدمات الطوارئ';

  @override
  String get sosHome_locationLabel => 'موقعك';

  @override
  String get sosHome_contactsLabel => 'جهات اتصال الطوارئ';

  @override
  String get sosHome_detectedLocationLabel => 'الموقع المكتشف';

  @override
  String get sosHome_locationValue => 'القسم 214، رواق البوابة 5';

  @override
  String get sosHome_gpsAccuracy => '±15 م';

  @override
  String get sosHome_shareLiveLocation => 'مشاركة الموقع المباشر';

  @override
  String get sosHome_shareSubtitle => 'مرئي للمستجيبين أثناء التفعيل';

  @override
  String get sosHome_serviceNamePolice => 'الشرطة';

  @override
  String get sosHome_serviceNameAmbulance => 'الإسعاف';

  @override
  String get sosHome_serviceNameCivilDefense => 'الدفاع المدني';

  @override
  String get sosHome_serviceNameMedical => 'حالة طبية طارئة';

  @override
  String get sosHome_serviceNameChildSafety => 'سلامة الطفل';

  @override
  String get sosHome_serviceNameLostPerson => 'شخص مفقود';

  @override
  String get sosHome_contact1Name => 'مركز عمليات الملعب';

  @override
  String get sosHome_contact1Role => 'غرفة تحكم على مدار الساعة';

  @override
  String get sosHome_contact2Name => 'فريق الاستجابة الطبية';

  @override
  String get sosHome_contact2Role => 'مسعفون في الموقع';

  @override
  String get sosHome_contact3Name => 'جهة اتصال الطوارئ';

  @override
  String get sosHome_contact3Role => 'شخصية — أضفتها أنت';

  @override
  String get sosHome_settingsTitle => 'إعدادات الطوارئ';

  @override
  String sosHome_holdLabel(String seconds) {
    return 'اضغط مطولًا $seconds ثوانٍ';
  }

  @override
  String get findCar_startWalkback => 'بدء إرشاد العودة';

  @override
  String get findCar_activeLocatorLabel => 'محدد موقع السيارة النشط';

  @override
  String get findCar_zoneLabel => 'المنطقة B · الصف 12 · البوابة 2';

  @override
  String get findCar_savedAgo => 'تم الحفظ قبل 3 ساعات';

  @override
  String get findCar_etaMinutes => '3 دقائق';

  @override
  String get findCar_distance => '196 م متبقية';

  @override
  String get findCar_savedSlotLabel => 'موقف السيارة المحفوظ';

  @override
  String get findCar_compassTracking => 'تتبع البوصلة';

  @override
  String get evac_title => 'محاكاة الإخلاء';

  @override
  String get evac_heading => 'إخلاء طارئ';

  @override
  String get evac_instructions =>
      'اتبع أقرب مسار للمخرج. حافظ على هدوئك وتحرك بسرعة إلى نقطة التجمع.';

  @override
  String get evac_disclaimer =>
      'هذه محاكاة. في حالة الطوارئ الفعلية، اتبع التعليمات الرسمية.';

  @override
  String get evac_exitButton => 'إنهاء المحاكاة';

  @override
  String get createGroup_title => 'إنشاء مجموعة';

  @override
  String get createGroup_subtitle => 'اختر نوع المجموعة أولاً.';

  @override
  String get createGroup_familyTitle => 'العائلة';

  @override
  String get createGroup_familySubtitle => 'ميزات سلامة الطفل';

  @override
  String get createGroup_groupTitle => 'مجموعة';

  @override
  String get createGroup_groupSubtitle => 'أصدقاء / مجموعة عامة';

  @override
  String get createGroup_phoneTitle => 'الهاتف';

  @override
  String get createGroup_mobileLabel => 'رقم الجوال';

  @override
  String get createGroup_mobilePlaceholder => '+962 7 9XXX XXXX';

  @override
  String get createGroup_nationalIdTitle => 'الهوية الوطنية';

  @override
  String get createGroup_otpTitle => 'رمز التحقق';

  @override
  String get createGroup_otpSubtitle => 'أدخل رمز التحقق.';

  @override
  String get createGroup_finishButton => 'إنهاء';

  @override
  String get createGroup_defaultFamilyName => 'عائلة جديدة';

  @override
  String get createGroup_defaultGroupName => 'مجموعة جديدة';

  @override
  String get childSafety_moderateSeverity => 'خطورة متوسطة';

  @override
  String get rewards_completedToday => 'تم الإنجاز اليوم';

  @override
  String rewards_missionPointsPlus(String points) {
    return '+$points نقطة';
  }

  @override
  String rewards_missionPointsPlusPts(String points) {
    return '+$points نقطة';
  }

  @override
  String get rewards_healthDisclaimer =>
      'معلومات عامة، ولا تعكس حالتك الصحية الشخصية.';

  @override
  String get rewards_convertNote =>
      'تنتقل النقاط المحوَّلة إلى رصيد مكافآتك وتُعيد ضبط تقدمك الأخضر.';

  @override
  String rewards_reachToUnlock(String points) {
    return 'اجمع $points نقطة لفتح هذه المكافأة';
  }

  @override
  String get childSafety_brandLabel => 'مدينة AXN الذكية';

  @override
  String get childSafety_pageTitle => 'سلامة الطفل';

  @override
  String get childSafety_pageSubtitle => 'حافظ على تواصل أسرتك خلال زيارتك.';

  @override
  String get childSafety_childInitials => 'ط1';

  @override
  String get childSafety_childName => 'الطفل 1';

  @override
  String get childSafety_ageGroup => 'العمر 8–12';

  @override
  String get childSafety_locationSectionLabel => 'الموقع المباشر';

  @override
  String get childSafety_zoneSectionLabel => 'منطقة السلامة';

  @override
  String get childSafety_zoneTitle =>
      'المنطقة المسموحة · المدرج الشمالي والرواق';

  @override
  String get childSafety_activitySectionLabel => 'النشاط';

  @override
  String get childSafety_lastSeenLabel => 'آخر ظهور';

  @override
  String get childSafety_checkInLabel => 'حالة تسجيل الوصول';

  @override
  String get childSafety_actionsSectionLabel => 'إجراءات سريعة';

  @override
  String get childSafety_callChildLabel => 'اتصال بالطفل';

  @override
  String get childSafety_locateChildLabel => 'تحديد موقع الطفل';

  @override
  String get childSafety_checkInRequestLabel => 'إرسال طلب تسجيل وصول';

  @override
  String get childSafety_emergencyAlertLabel => 'تنبيه طارئ';

  @override
  String get childSafety_timeline1Location => 'الرواق B، القسم 14';

  @override
  String get childSafety_timeline1Time => 'الآن';

  @override
  String get childSafety_timeline2Location => 'ساحة الطعام، المدرج الشمالي';

  @override
  String get childSafety_timeline2Time => 'قبل 14 دقيقة';

  @override
  String get childSafety_timeline3Location => 'الدخول عبر البوابة C';

  @override
  String get childSafety_timeline3Time => 'قبل 52 دقيقة';

  @override
  String get childSafety_normalStatusText => 'بأمان ومتصل';

  @override
  String get childSafety_normalStatusSub => 'تم التحديث الآن';

  @override
  String get childSafety_normalLocationValue => 'القسم 14، الرواق B';

  @override
  String get childSafety_normalLocationTime => 'قبل 12 ثانية';

  @override
  String get childSafety_normalZoneStatusText => 'داخل المنطقة الآمنة';

  @override
  String get childSafety_normalZoneSub =>
      'سيتم إعلامك إذا غادر الطفل 1 هذه المنطقة.';

  @override
  String get childSafety_normalLastSeen => 'قبل 12 ثانية';

  @override
  String get childSafety_normalCheckInText => 'تم تسجيل الوصول · قبل 5 دقائق';

  @override
  String get childSafety_warningConnLabel => 'متصل · إشارة ضعيفة';

  @override
  String get childSafety_warningStatusText => 'غادر المنطقة الآمنة';

  @override
  String get childSafety_warningStatusSub => 'تم التحديث قبل دقيقة';

  @override
  String get childSafety_warningLocationValue =>
      'قرب البوابة C، الرواق الخارجي';

  @override
  String get childSafety_warningLocationTime => 'قبل دقيقة';

  @override
  String get childSafety_warningZoneSub =>
      'الطفل 1 يبعد 40 مترًا خارج المنطقة المسموحة قرب البوابة C.';

  @override
  String get childSafety_warningLastSeen => 'قبل دقيقة';

  @override
  String get childSafety_warningCheckInText =>
      'تم طلب تسجيل الوصول · بانتظار الرد';

  @override
  String get childSafety_offlineStatusText => 'الجهاز غير متصل';

  @override
  String get childSafety_offlineStatusSub => 'آخر ظهور قبل 18 دقيقة';

  @override
  String get childSafety_offlineLocationValue => 'آخر موقع معروف: الرواق B';

  @override
  String get childSafety_offlineLocationTime => 'قبل 18 دقيقة';

  @override
  String get childSafety_offlineZoneStatusText => 'الموقع غير متاح';

  @override
  String get childSafety_offlineZoneSub =>
      'جارٍ إعادة الاتصال — يتم عرض آخر موقع معروف.';

  @override
  String get childSafety_offlineLastSeen => 'قبل 18 دقيقة';

  @override
  String get childSafety_offlineCheckInText => 'غير متاح أثناء عدم الاتصال';

  @override
  String get childSafety_summaryAlertTriggered => 'تم تفعيل التنبيه';

  @override
  String get childSafety_summaryResolved => 'تم الحل';

  @override
  String get childSafety_summaryDuration => 'المدة';

  @override
  String get childSafety_summaryOutcome => 'النتيجة';

  @override
  String get childSafety_summaryDurationValue => '6 دقائق';

  @override
  String get childSafety_summaryOutcomeValue => 'تم لمّ الشمل عند البوابة C';

  @override
  String get childSafety_recommendedActionsLabel => 'الإجراءات الموصى بها';

  @override
  String get childSafety_navigateToLocation => 'التوجه إلى الموقع';

  @override
  String get childSafety_shareLocation => 'مشاركة الموقع';

  @override
  String get childSafety_contactEmergencySupport => 'التواصل مع دعم الطوارئ';

  @override
  String get childSafety_alertSummaryLabel => 'ملخص التنبيه';

  @override
  String get childAlert_locationSectionLabel => 'الموقع';

  @override
  String get trip_stop1Title => 'إحماء المنطقة الترفيهية';

  @override
  String get trip_stop1Sub => 'لقاء القمصان · 6 دقائق مشيًا';

  @override
  String get trip_stop2Title => 'الأردن ضد إسبانيا';

  @override
  String get trip_stop2Sub => 'الانطلاقة · عرض عام';

  @override
  String get trip_stop2Note =>
      'غادر المنزل بحلول 5:40 — تمتلئ الطرق قرب الملعب بسرعة قبل الانطلاقة.';

  @override
  String get trip_stop3Title => 'جولة فنية على النهر';

  @override
  String get trip_stop3Sub => 'رسم مباشر · 10 دقائق مشيًا';

  @override
  String get trip_stop4Title => 'صالة الحديقة الهادئة';

  @override
  String get trip_stop4Sub => 'جلوس · 5 دقائق مشيًا';

  @override
  String get rewards_ga1Label => 'مشى بدلًا من القيادة';

  @override
  String get rewards_ga1Source => 'الخريطة المباشرة';

  @override
  String get rewards_ga2Label => 'استخدم وسيلة نقل مشتركة';

  @override
  String get rewards_ga3Label => 'تجنّب رحلة بسيارة خاصة';

  @override
  String get rewards_ga3Source => 'مزامنة المواقف الذكية';

  @override
  String get rewards_greenInfoFact =>
      'يرتبط المشي لمسافات قصيرة عمومًا بتحسّن المزاج.';

  @override
  String get rewards_m1Label => 'الإبلاغ عن مخالفة';

  @override
  String get rewards_m2Label => 'حافظ على سلسلة 7 أيام';

  @override
  String get rewards_m3Label => 'دعوة صديق';

  @override
  String get rewards_m4Label => 'أكمل ملفك الشخصي';

  @override
  String get rewards_r1Title => 'قهوة مجانية';

  @override
  String get rewards_r1Desc =>
      'مشروب ساخن أو بارد مجاني، بأي حجم، في المقاهي المشاركة.';

  @override
  String get rewards_r2Title => 'موقف سيارات ذو أولوية';

  @override
  String get rewards_r2Desc =>
      'موقف محجوز ليوم كامل في مواقف وسط المدينة المشاركة.';

  @override
  String get rewards_r3Title => 'بطاقة دخول للمعرض';

  @override
  String get rewards_r3Desc =>
      'دخول ليوم كامل لشخصين إلى المعرض الحالي في المتحف الوطني.';

  @override
  String get rewards_v1Title => 'مشروب مجاني';

  @override
  String get rewards_v1Desc => 'مشروب ساخن أو بارد مجاني.';

  @override
  String get rewards_v1Expiry => 'تنتهي الصلاحية في 15 أغسطس';

  @override
  String get rewards_v2Title => 'خصم 20% على المنتجات';

  @override
  String get rewards_v2Desc => 'على منتجات الفريق الرسمية.';

  @override
  String get rewards_v2Expiry => 'تنتهي الصلاحية في 30 سبتمبر';

  @override
  String get rewards_v3Title => 'وجبة مميزة';

  @override
  String get rewards_v3Desc => 'وجبة مميزة في ساحة الطعام.';

  @override
  String get rewards_v3Expiry => 'تنتهي الصلاحية في 10 أكتوبر';

  @override
  String get rewards_boardRankLabel => 'أنت في المركز #3 في عمرة';

  @override
  String get rewards_boardSubLabel => '260 نقطة للوصول إلى المركز #2';

  @override
  String get rewards_leaderboardTitle => 'لوحة المتصدرين';

  @override
  String get rewards_leaderboardSubtitle => 'عمّان، هذا الشهر';

  @override
  String get rewards_h1Label => 'تم الإبلاغ عن مخالفة';

  @override
  String get rewards_h2Label => 'مكافأة السلسلة اليومية';

  @override
  String get rewards_h3Label => 'تم الاستبدال: قهوة مجانية';

  @override
  String get rewards_h4Label => 'تمت دعوة صديق';

  @override
  String get rewards_todayLabel => 'اليوم';

  @override
  String get rewards_yesterdayLabel => 'أمس';

  @override
  String get rewards_daysAgoLabel => 'قبل 3 أيام';

  @override
  String get rewards_matchAttendance => 'حضور المباراة';

  @override
  String get rewards_qrCheckIn => 'تسجيل الدخول عبر QR';

  @override
  String get rewards_convertedGreenPoints => 'تم تحويل النقاط الخضراء';

  @override
  String get rewards_recommendationCopy =>
      'لديك نقاط كافية لاستبدال قسيمة مشروب مجاني.';

  @override
  String get rewards_achievementTitle => 'مستكشف الملعب';

  @override
  String get rewards_achievementSub => 'زار كل مناطق الملعب خلال زيارته.';

  @override
  String get rewards_greenLevelSheetTitle => 'المستوى الأخضر';

  @override
  String get rewards_greenLevelSheetSubtitle =>
      'استنادًا إلى رحلاتك عبر التطبيق';

  @override
  String get rewards_historySheetTitle => 'السجل';

  @override
  String get rewards_historySheetSubtitle => 'كل نقطة، مُتتبَّعة.';

  @override
  String get rewards_missionsSheetTitle => 'المهام';

  @override
  String get rewards_missionsSheetSubtitle =>
      'إجراءات بسيطة تحافظ على التزامك — وتكسبك نقاطًا.';

  @override
  String get rewards_pointMultiplier => 'مضاعف النقاط';

  @override
  String get rewards_monthlyBonusReward => 'مكافأة شهرية';

  @override
  String get rewards_prioritySupport => 'دعم ذو أولوية';

  @override
  String get rewards_freeReward => 'مكافأة مجانية';

  @override
  String get rewards_included => 'مُضمَّن';

  @override
  String get rewards_availableLocations => 'متوفر في 6 مواقع في عمّان';

  @override
  String get rewards_valid30Days => 'صالح لمدة 30 يومًا';

  @override
  String get rewards_earnMorePoints => 'اكسب المزيد من النقاط';

  @override
  String get rewards_recentActivity => 'النشاط الأخير';

  @override
  String get rewards_yourVouchers => 'قسائمك';

  @override
  String get rewards_redeemYourPoints => 'استبدل نقاطك';

  @override
  String get rewards_levelAware => 'واعٍ';

  @override
  String get rewards_levelActive => 'نشِط';

  @override
  String get rewards_levelGreenGuardian => 'حارس البيئة';

  @override
  String get rewards_lbName1 => 'لينا م.';

  @override
  String get rewards_lbName2 => 'عمر ت.';

  @override
  String get rewards_lbName3 => 'سارة ك.';

  @override
  String get rewards_lbName4 => 'يوسف أ.';

  @override
  String get rewards_greeting => 'مساء الخير';

  @override
  String get rewards_goldTierLabel => 'المستوى الذهبي';

  @override
  String get rewards_silverMemberName => 'عضو فضي';

  @override
  String get rewards_goldMemberName => 'عضو ذهبي';

  @override
  String rewards_pointsLockedSuffix(String locked, String points) {
    return '$points نقطة$locked';
  }

  @override
  String get rewards_lockedSuffix => ' · مقفل';
}
