import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// Name of the main stadium venue
  ///
  /// In en, this message translates to:
  /// **'Prince Hussein bin Abdullah II Stadium'**
  String get stadium;

  /// Main marketing tagline shown on the welcome screen
  ///
  /// In en, this message translates to:
  /// **'Your gateway to matchday — activate once, walk straight in every time.'**
  String get tagline;

  /// Name of the smart city
  ///
  /// In en, this message translates to:
  /// **'Amra Smart City'**
  String get city;

  /// Primary CTA button to start ticket activation flow
  ///
  /// In en, this message translates to:
  /// **'Activate my ticket'**
  String get ctaTicket;

  /// Secondary CTA button to navigate to account creation
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get ctaCreate;

  /// Tertiary link to continue without creating an account
  ///
  /// In en, this message translates to:
  /// **'Browse as guest'**
  String get ctaGuest;

  /// Link to navigate to the login screen
  ///
  /// In en, this message translates to:
  /// **'Already have an account — Log in'**
  String get ctaLogin;

  /// Language toggle button label (shows the other language name)
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get toggleLabel;

  /// Header for the notifications panel
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifHead;

  /// Title of the first welcome notification
  ///
  /// In en, this message translates to:
  /// **'Welcome to AMRA Smart City'**
  String get notif1Title;

  /// Body of the first welcome notification
  ///
  /// In en, this message translates to:
  /// **'Your account hub for matchday, transit, and city services.'**
  String get notif1Body;

  /// Title of the ticket activation notification
  ///
  /// In en, this message translates to:
  /// **'Activate your ticket'**
  String get notif2Title;

  /// Body of the ticket activation notification
  ///
  /// In en, this message translates to:
  /// **'Activate your ticket to unlock your matchday experience.'**
  String get notif2Body;

  /// Title of the account setup notification
  ///
  /// In en, this message translates to:
  /// **'Set up your account'**
  String get notif3Title;

  /// Body of the account setup notification
  ///
  /// In en, this message translates to:
  /// **'Create an account to enjoy all smart city services, or continue as a guest.'**
  String get notif3Body;

  /// Informational note about limitations in guest mode
  ///
  /// In en, this message translates to:
  /// **'Guest mode has limited access. Activate anytime for seating, wayfinding and rewards.'**
  String get guestNote;

  /// Generic continue button label used across multi-step flows
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get btnContinue;

  /// Step indicator for the ticket activation method screen
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 5'**
  String get m1Eyebrow;

  /// Title of the method selection screen
  ///
  /// In en, this message translates to:
  /// **'How do you want to activate your ticket?'**
  String get m1Title;

  /// Subtitle explaining the method selection screen
  ///
  /// In en, this message translates to:
  /// **'Choose the method that works best for you — we\'ll verify the ticket automatically.'**
  String get m1Sub;

  /// Title for QR code activation method card
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get m1QrTitle;

  /// Description for QR code activation method card
  ///
  /// In en, this message translates to:
  /// **'Open the camera and point it at your ticket\'s QR code — its details load automatically.'**
  String get m1QrDesc;

  /// Title for manual ticket activation method card
  ///
  /// In en, this message translates to:
  /// **'Manual activation'**
  String get m1ManualTitle;

  /// Description for manual ticket activation method card
  ///
  /// In en, this message translates to:
  /// **'Enter your ticket ID and the verification code sent with your ticket.'**
  String get m1ManualDesc;

  /// Eyebrow label for the QR scanning screen
  ///
  /// In en, this message translates to:
  /// **'Scan code'**
  String get qrEyebrow;

  /// Title for the QR scanning screen
  ///
  /// In en, this message translates to:
  /// **'Point the camera at the QR code'**
  String get qrTitle;

  /// Subtitle with instructions for QR scanning
  ///
  /// In en, this message translates to:
  /// **'Line up the code inside the frame — it\'s detected automatically, no button needed.'**
  String get qrSub;

  /// Status chip showing the ticket ID while waiting for QR detection
  ///
  /// In en, this message translates to:
  /// **'🎫 Ticket {ticketId} ready to detect'**
  String qrChip(String ticketId);

  /// Success message shown when QR code is successfully detected
  ///
  /// In en, this message translates to:
  /// **'Detected — Continue'**
  String get qrDetected;

  /// Fallback link to switch from QR scan to manual entry
  ///
  /// In en, this message translates to:
  /// **'Enter the details manually instead'**
  String get qrManualInstead;

  /// Title for the manual ticket ID entry screen
  ///
  /// In en, this message translates to:
  /// **'Enter your ticket ID'**
  String get manualTitle;

  /// Subtitle explaining where to find the ticket ID
  ///
  /// In en, this message translates to:
  /// **'You\'ll find this on your e-ticket or printed ticket.'**
  String get manualSub;

  /// Form field label for ticket ID input
  ///
  /// In en, this message translates to:
  /// **'Ticket ID'**
  String get manualLabel;

  /// Eyebrow label for the manual code/verification screen
  ///
  /// In en, this message translates to:
  /// **'Verify ownership'**
  String get mcEyebrow;

  /// Title for the verification code entry screen
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code'**
  String get mcTitle;

  /// Subtitle explaining that a verification code was sent via email
  ///
  /// In en, this message translates to:
  /// **'We sent a code to the email address associated with this ticket.'**
  String get mcSub;

  /// Form field label for verification code input
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get mcLabel;

  /// Button to submit the verification code and verify ticket ownership
  ///
  /// In en, this message translates to:
  /// **'Verify ticket'**
  String get mcVerifyBtn;

  /// Text prefix preceding the resend code action link
  ///
  /// In en, this message translates to:
  /// **'Didn\'t get the code? '**
  String get resendPrefix;

  /// Resend code action button with countdown timer
  ///
  /// In en, this message translates to:
  /// **'Resend ({countdown})'**
  String resendAction(String countdown);

  /// Title for the OTP ownership confirmation screen
  ///
  /// In en, this message translates to:
  /// **'Confirm you own this ticket'**
  String get otpTitle;

  /// Subtitle explaining the 6-digit OTP was sent to the ticket email
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to the email the ticket was sent to'**
  String get otpSub;

  /// Button to confirm OTP and verify ticket ownership
  ///
  /// In en, this message translates to:
  /// **'Confirm and verify ownership'**
  String get otpConfirmBtn;

  /// Eyebrow label for the create account screen
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get caEyebrow;

  /// Title for the account creation screen
  ///
  /// In en, this message translates to:
  /// **'Set up your AXN account'**
  String get caTitle;

  /// Subtitle explaining the purpose and benefits of creating an account
  ///
  /// In en, this message translates to:
  /// **'This account links your ticket to you and stays with you long after the event ends.'**
  String get caSub;

  /// Form field label for full name input
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get lblFullName;

  /// Form field label for national ID number input
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get lblNationalId;

  /// Form field label for date of birth input
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get lblDob;

  /// Placeholder text for date of birth field format
  ///
  /// In en, this message translates to:
  /// **'DD / MM / YYYY'**
  String get phDob;

  /// Form field label for mobile phone number input
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get lblMobile;

  /// Form field label for email address input
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get lblEmail;

  /// Helper hint text explaining the email field is pre-filled from ticket
  ///
  /// In en, this message translates to:
  /// **'Filled in automatically from the ticket — you can edit it if needed.'**
  String get hintEmail;

  /// Form field label for password input
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get lblPassword;

  /// Form field label for password confirmation input
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get lblConfirmPassword;

  /// Submit button to finalize account creation
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get caCreateBtn;

  /// Title shown when ticket-account-device binding is successful
  ///
  /// In en, this message translates to:
  /// **'Binding successful'**
  String get bindTitle;

  /// Subtitle confirming ticket binding and readiness for entry
  ///
  /// In en, this message translates to:
  /// **'Your ticket is now linked to your account and this device — ready for event entry.'**
  String get bindSub;

  /// Heading for the ticket-to-account binding explanation
  ///
  /// In en, this message translates to:
  /// **'Ticket ⇄ Account'**
  String get bind1Title;

  /// Explanation that a ticket can only be bound to one account
  ///
  /// In en, this message translates to:
  /// **'One ticket = one account, and it can\'t be activated again'**
  String get bind1Sub;

  /// Heading for the account-to-device binding explanation
  ///
  /// In en, this message translates to:
  /// **'Account ⇄ Device'**
  String get bind2Title;

  /// Explanation that switching devices needs identity re-verification
  ///
  /// In en, this message translates to:
  /// **'Changing devices requires re-verification of your identity'**
  String get bind2Sub;

  /// Heading for the QR code status explanation
  ///
  /// In en, this message translates to:
  /// **'QR status'**
  String get bind3Title;

  /// Explanation that the QR code is marked activated and consumed
  ///
  /// In en, this message translates to:
  /// **'The QR code is now marked \"activated\" and can\'t be used again'**
  String get bind3Sub;

  /// Button to enter the main AXN app after successful binding
  ///
  /// In en, this message translates to:
  /// **'Enter AXN'**
  String get bindEnterBtn;

  /// Title for the returning user login screen
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginTitle;

  /// Subtitle on login screen describing account benefits
  ///
  /// In en, this message translates to:
  /// **'Your account is always here — check your event history, rewards, and memories anytime.'**
  String get loginSub;

  /// Form field label accepting either username or email for login
  ///
  /// In en, this message translates to:
  /// **'Username or email'**
  String get lblUserOrEmail;

  /// Link to initiate password recovery flow
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Login submit button label
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginBtn;

  /// Link from login screen to navigate to account creation
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account — Create one'**
  String get noAccountBtn;

  /// Button to skip remaining onboarding slides
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get obSkip;

  /// Button to advance to the next onboarding slide
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get obNext;

  /// Button on the final onboarding slide to begin the app
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get obStart;

  /// First two letters of the AXN wordmark on the splash screen
  ///
  /// In en, this message translates to:
  /// **'AX'**
  String get splash_wordAx;

  /// Accented N letter of the AXN wordmark on the splash screen
  ///
  /// In en, this message translates to:
  /// **'N'**
  String get splash_wordN;

  /// Full acronym expansion shown below the AXN wordmark on splash
  ///
  /// In en, this message translates to:
  /// **'AMRA EXCHANGE NEXUS'**
  String get splash_tagline;

  /// Onboarding slide 1 title — smart city discovery feature
  ///
  /// In en, this message translates to:
  /// **'Discover the Smart City'**
  String get ob1Title;

  /// Onboarding slide 1 description — live map with events and crowds
  ///
  /// In en, this message translates to:
  /// **'A live map showing events and crowd density in Amra city moment by moment.'**
  String get ob1Desc;

  /// Onboarding slide 2 title — find my car parking feature
  ///
  /// In en, this message translates to:
  /// **'Find Your Car Instantly'**
  String get ob2Title;

  /// Onboarding slide 2 description — car finding navigation assistance
  ///
  /// In en, this message translates to:
  /// **'The Find My Car feature guides you directly to your parking spot without getting lost.'**
  String get ob2Desc;

  /// Onboarding slide 3 title — emergency safety feature
  ///
  /// In en, this message translates to:
  /// **'Your Safety First'**
  String get ob3Title;

  /// Onboarding slide 3 description — SOS emergency location sharing
  ///
  /// In en, this message translates to:
  /// **'With one tap on the emergency button, your live location is sent directly to response teams.'**
  String get ob3Desc;

  /// Onboarding slide 4 title — final call to action
  ///
  /// In en, this message translates to:
  /// **'Ready to Get Started?'**
  String get ob4Title;

  /// Onboarding slide 4 description — AI planning recommendations
  ///
  /// In en, this message translates to:
  /// **'Plan your visit with smart AI-powered recommendations and enjoy every moment.'**
  String get ob4Desc;

  /// Vertical separator character between minor links on the welcome screen
  ///
  /// In en, this message translates to:
  /// **'|'**
  String get welcome_pipe;

  /// Icon glyph displayed in the QR method selection card
  ///
  /// In en, this message translates to:
  /// **'▦'**
  String get methodCardQrIcon;

  /// Icon glyph displayed in the manual method selection card
  ///
  /// In en, this message translates to:
  /// **'✎'**
  String get methodCardManualIcon;

  /// Example ticket ID format shown as placeholder in the manual entry field
  ///
  /// In en, this message translates to:
  /// **'JFA26-XXXXXX'**
  String get manualPlaceholder;

  /// Envelope icon prefix shown in the masked email chip on OTP screen
  ///
  /// In en, this message translates to:
  /// **'✉️'**
  String get maskedEmailChip;

  /// Example masked email address format shown on OTP screen
  ///
  /// In en, this message translates to:
  /// **'sa***@gmail.com'**
  String get maskedEmailExample;

  /// Bullet character used as placeholder for empty OTP digit boxes
  ///
  /// In en, this message translates to:
  /// **'•'**
  String get otpDots;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get settings_back;

  /// No description provided for @settings_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settings_notifications;

  /// No description provided for @settings_pushTitle.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get settings_pushTitle;

  /// No description provided for @settings_pushSub.
  ///
  /// In en, this message translates to:
  /// **'Alerts, updates and offers'**
  String get settings_pushSub;

  /// No description provided for @settings_safeZoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Safe zone alerts'**
  String get settings_safeZoneTitle;

  /// No description provided for @settings_safeZoneSub.
  ///
  /// In en, this message translates to:
  /// **'Geofence entry and exit notifications'**
  String get settings_safeZoneSub;

  /// No description provided for @settings_groupActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Group activity alerts'**
  String get settings_groupActivityTitle;

  /// No description provided for @settings_groupActivitySub.
  ///
  /// In en, this message translates to:
  /// **'Updates from your family groups'**
  String get settings_groupActivitySub;

  /// No description provided for @settings_legacyCapsuleTitle.
  ///
  /// In en, this message translates to:
  /// **'Legacy Capsule alerts'**
  String get settings_legacyCapsuleTitle;

  /// No description provided for @settings_legacyCapsuleSub.
  ///
  /// In en, this message translates to:
  /// **'Delivery and detection notifications'**
  String get settings_legacyCapsuleSub;

  /// No description provided for @settings_manageSafeZones.
  ///
  /// In en, this message translates to:
  /// **'Manage safe zones'**
  String get settings_manageSafeZones;

  /// No description provided for @settings_preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settings_preferences;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @settings_langEn.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get settings_langEn;

  /// No description provided for @settings_langAr.
  ///
  /// In en, this message translates to:
  /// **'AR'**
  String get settings_langAr;

  /// No description provided for @settings_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme;

  /// No description provided for @settings_themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settings_themeLight;

  /// No description provided for @settings_themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settings_themeDark;

  /// No description provided for @settings_themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settings_themeSystem;

  /// No description provided for @settings_accessibility.
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get settings_accessibility;

  /// No description provided for @settings_fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font size'**
  String get settings_fontSize;

  /// No description provided for @settings_fontSmall.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get settings_fontSmall;

  /// No description provided for @settings_fontDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get settings_fontDefault;

  /// No description provided for @settings_fontLarge.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get settings_fontLarge;

  /// No description provided for @settings_fontXLarge.
  ///
  /// In en, this message translates to:
  /// **'X-Large'**
  String get settings_fontXLarge;

  /// No description provided for @settings_locationSharing.
  ///
  /// In en, this message translates to:
  /// **'Location & sharing'**
  String get settings_locationSharing;

  /// No description provided for @settings_shareLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Share live location'**
  String get settings_shareLocationTitle;

  /// No description provided for @settings_shareLocationSub.
  ///
  /// In en, this message translates to:
  /// **'Visible to linked family members'**
  String get settings_shareLocationSub;

  /// No description provided for @settings_accountSecurity.
  ///
  /// In en, this message translates to:
  /// **'Account & security'**
  String get settings_accountSecurity;

  /// No description provided for @settings_changePin.
  ///
  /// In en, this message translates to:
  /// **'Change PIN / password'**
  String get settings_changePin;

  /// No description provided for @settings_biometricTitle.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock'**
  String get settings_biometricTitle;

  /// No description provided for @settings_biometricSub.
  ///
  /// In en, this message translates to:
  /// **'Face ID or fingerprint'**
  String get settings_biometricSub;

  /// No description provided for @settings_helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get settings_helpSupport;

  /// No description provided for @settings_helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help center / FAQ'**
  String get settings_helpCenter;

  /// No description provided for @settings_contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get settings_contactSupport;

  /// No description provided for @settings_reportProblem.
  ///
  /// In en, this message translates to:
  /// **'Report a problem'**
  String get settings_reportProblem;

  /// No description provided for @settings_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settings_about;

  /// No description provided for @settings_version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settings_version;

  /// No description provided for @settings_terms.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get settings_terms;

  /// No description provided for @settings_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settings_privacy;

  /// No description provided for @settings_logoutNote.
  ///
  /// In en, this message translates to:
  /// **'Log out is available on your profile'**
  String get settings_logoutNote;

  /// No description provided for @home_liveVisitors.
  ///
  /// In en, this message translates to:
  /// **'LIVE STADIUM VISITORS'**
  String get home_liveVisitors;

  /// No description provided for @home_stadiumEnv.
  ///
  /// In en, this message translates to:
  /// **'STADIUM ENVIRONMENTS & CROWD'**
  String get home_stadiumEnv;

  /// No description provided for @home_quickAssist.
  ///
  /// In en, this message translates to:
  /// **'QUICK ASSIST'**
  String get home_quickAssist;

  /// No description provided for @home_avatarInitials.
  ///
  /// In en, this message translates to:
  /// **'AX'**
  String get home_avatarInitials;

  /// No description provided for @home_liveBadge.
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get home_liveBadge;

  /// No description provided for @home_hello.
  ///
  /// In en, this message translates to:
  /// **'Ahlan, {name} 👋'**
  String home_hello(String name);

  /// No description provided for @home_visitorsToday.
  ///
  /// In en, this message translates to:
  /// **'Visitors today'**
  String get home_visitorsToday;

  /// No description provided for @home_atGate.
  ///
  /// In en, this message translates to:
  /// **'at gate'**
  String get home_atGate;

  /// No description provided for @home_inStands.
  ///
  /// In en, this message translates to:
  /// **'in stands'**
  String get home_inStands;

  /// No description provided for @home_entering.
  ///
  /// In en, this message translates to:
  /// **'entering'**
  String get home_entering;

  /// No description provided for @home_envAir.
  ///
  /// In en, this message translates to:
  /// **'Air'**
  String get home_envAir;

  /// No description provided for @home_envAirSub.
  ///
  /// In en, this message translates to:
  /// **'Circulation & quality'**
  String get home_envAirSub;

  /// No description provided for @home_envNoise.
  ///
  /// In en, this message translates to:
  /// **'Noise'**
  String get home_envNoise;

  /// No description provided for @home_envNoiseSub.
  ///
  /// In en, this message translates to:
  /// **'Decibel levels'**
  String get home_envNoiseSub;

  /// No description provided for @home_envCrowd.
  ///
  /// In en, this message translates to:
  /// **'Crowd'**
  String get home_envCrowd;

  /// No description provided for @home_envCrowdSub.
  ///
  /// In en, this message translates to:
  /// **'Zone density'**
  String get home_envCrowdSub;

  /// No description provided for @home_envSafety.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get home_envSafety;

  /// No description provided for @home_envSafetySub.
  ///
  /// In en, this message translates to:
  /// **'Incident monitor'**
  String get home_envSafetySub;

  /// No description provided for @home_eveningPlan.
  ///
  /// In en, this message translates to:
  /// **'Your evening plan'**
  String get home_eveningPlan;

  /// No description provided for @home_eveningPlanSub.
  ///
  /// In en, this message translates to:
  /// **'Tap to see your curated schedule'**
  String get home_eveningPlanSub;

  /// No description provided for @home_eveningTime.
  ///
  /// In en, this message translates to:
  /// **'6:00 PM — 11:30 PM'**
  String get home_eveningTime;

  /// No description provided for @home_eveningStops.
  ///
  /// In en, this message translates to:
  /// **'{count} stops'**
  String home_eveningStops(String count);

  /// No description provided for @home_rewardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Matchday Rewards'**
  String get home_rewardsTitle;

  /// No description provided for @home_rewardsPoints.
  ///
  /// In en, this message translates to:
  /// **'{points} pts'**
  String home_rewardsPoints(String points);

  /// No description provided for @home_rewardsSub.
  ///
  /// In en, this message translates to:
  /// **'Scan in, collect, unlock perks'**
  String get home_rewardsSub;

  /// No description provided for @home_rewardsTierBadge.
  ///
  /// In en, this message translates to:
  /// **'Silver tier'**
  String get home_rewardsTierBadge;

  /// No description provided for @home_assistFindCar.
  ///
  /// In en, this message translates to:
  /// **'Find My Car'**
  String get home_assistFindCar;

  /// No description provided for @home_assistRoute.
  ///
  /// In en, this message translates to:
  /// **'Route Planner'**
  String get home_assistRoute;

  /// No description provided for @home_assistSmartExit.
  ///
  /// In en, this message translates to:
  /// **'Smart Exit'**
  String get home_assistSmartExit;

  /// No description provided for @home_assistAI.
  ///
  /// In en, this message translates to:
  /// **'AI Planner'**
  String get home_assistAI;

  /// No description provided for @home_assistSOS.
  ///
  /// In en, this message translates to:
  /// **'Emergency SOS'**
  String get home_assistSOS;

  /// No description provided for @home_navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_navHome;

  /// No description provided for @home_navRoute.
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get home_navRoute;

  /// No description provided for @home_navAlert.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get home_navAlert;

  /// No description provided for @home_navAI.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get home_navAI;

  /// No description provided for @home_navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get home_navSettings;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_title;

  /// No description provided for @profile_verifiedBadge.
  ///
  /// In en, this message translates to:
  /// **'Verified ticket holder'**
  String get profile_verifiedBadge;

  /// No description provided for @profile_ticketBound.
  ///
  /// In en, this message translates to:
  /// **'Ticket {id} · Bound'**
  String profile_ticketBound(String id);

  /// No description provided for @profile_eventsAttended.
  ///
  /// In en, this message translates to:
  /// **'{count} events'**
  String profile_eventsAttended(String count);

  /// No description provided for @profile_rewardsPoints.
  ///
  /// In en, this message translates to:
  /// **'{points} reward points'**
  String profile_rewardsPoints(String points);

  /// No description provided for @profile_memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since {date}'**
  String profile_memberSince(String date);

  /// No description provided for @profile_sectionActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent activity'**
  String get profile_sectionActivity;

  /// No description provided for @profile_sectionFamily.
  ///
  /// In en, this message translates to:
  /// **'My family groups'**
  String get profile_sectionFamily;

  /// No description provided for @profile_sectionHistory.
  ///
  /// In en, this message translates to:
  /// **'Event history'**
  String get profile_sectionHistory;

  /// No description provided for @profile_sectionRewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards & perks'**
  String get profile_sectionRewards;

  /// No description provided for @profile_createGroup.
  ///
  /// In en, this message translates to:
  /// **'＋  Create group'**
  String get profile_createGroup;

  /// No description provided for @profile_noGroupsYet.
  ///
  /// In en, this message translates to:
  /// **'No groups yet — create one to link family members.'**
  String get profile_noGroupsYet;

  /// No description provided for @profile_logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profile_logout;

  /// No description provided for @profile_editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get profile_editProfile;

  /// No description provided for @family_appTitle.
  ///
  /// In en, this message translates to:
  /// **'Family account'**
  String get family_appTitle;

  /// No description provided for @family_brand.
  ///
  /// In en, this message translates to:
  /// **'AXN Family'**
  String get family_brand;

  /// No description provided for @family_connecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get family_connecting;

  /// No description provided for @family_connectMemberBtn.
  ///
  /// In en, this message translates to:
  /// **'Connect member'**
  String get family_connectMemberBtn;

  /// No description provided for @family_consentLabel.
  ///
  /// In en, this message translates to:
  /// **'I agree to share my live location and match-day status with this family group.'**
  String get family_consentLabel;

  /// No description provided for @family_doneBtn.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get family_doneBtn;

  /// No description provided for @family_memberChildName.
  ///
  /// In en, this message translates to:
  /// **'Child'**
  String get family_memberChildName;

  /// No description provided for @family_memberChildRel.
  ///
  /// In en, this message translates to:
  /// **'Child'**
  String get family_memberChildRel;

  /// No description provided for @family_memberParentName.
  ///
  /// In en, this message translates to:
  /// **'Parent'**
  String get family_memberParentName;

  /// No description provided for @family_memberParentRel.
  ///
  /// In en, this message translates to:
  /// **'Parent'**
  String get family_memberParentRel;

  /// No description provided for @family_memberSiblingName.
  ///
  /// In en, this message translates to:
  /// **'Sibling'**
  String get family_memberSiblingName;

  /// No description provided for @family_memberSiblingRel.
  ///
  /// In en, this message translates to:
  /// **'Sibling'**
  String get family_memberSiblingRel;

  /// No description provided for @family_notNowBtn.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get family_notNowBtn;

  /// No description provided for @family_permCollectedBullet1.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required to share your real-time position.'**
  String get family_permCollectedBullet1;

  /// No description provided for @family_permCollectedBullet2.
  ///
  /// In en, this message translates to:
  /// **'Contacts permission is required to connect family members.'**
  String get family_permCollectedBullet2;

  /// No description provided for @family_permCollectedBullet3.
  ///
  /// In en, this message translates to:
  /// **'Notification permission is required for safety alerts.'**
  String get family_permCollectedBullet3;

  /// No description provided for @family_permCollectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Permissions collected'**
  String get family_permCollectedTitle;

  /// No description provided for @family_permOverviewLabel.
  ///
  /// In en, this message translates to:
  /// **'Location & safety permissions'**
  String get family_permOverviewLabel;

  /// No description provided for @family_permPrivacyBullet1.
  ///
  /// In en, this message translates to:
  /// **'Only approved family members can see your status.'**
  String get family_permPrivacyBullet1;

  /// No description provided for @family_permPrivacyBullet2.
  ///
  /// In en, this message translates to:
  /// **'Your live location is shared only during match-day sessions.'**
  String get family_permPrivacyBullet2;

  /// No description provided for @family_permPrivacyBullet3.
  ///
  /// In en, this message translates to:
  /// **'Data is not used for marketing.'**
  String get family_permPrivacyBullet3;

  /// No description provided for @family_permPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy and data use'**
  String get family_permPrivacyTitle;

  /// No description provided for @family_permUsedBullet1.
  ///
  /// In en, this message translates to:
  /// **'Shared only for live family safety and arrival updates.'**
  String get family_permUsedBullet1;

  /// No description provided for @family_permUsedBullet2.
  ///
  /// In en, this message translates to:
  /// **'Used to coordinate group meeting points.'**
  String get family_permUsedBullet2;

  /// No description provided for @family_permUsedBullet3.
  ///
  /// In en, this message translates to:
  /// **'Not stored beyond the event.'**
  String get family_permUsedBullet3;

  /// No description provided for @family_permUsedTitle.
  ///
  /// In en, this message translates to:
  /// **'How permissions are used'**
  String get family_permUsedTitle;

  /// No description provided for @family_safetySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep everyone connected and safe while you enjoy the match.'**
  String get family_safetySubtitle;

  /// No description provided for @family_safetyTitle.
  ///
  /// In en, this message translates to:
  /// **'Family safety'**
  String get family_safetyTitle;

  /// No description provided for @family_statusConnect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get family_statusConnect;

  /// No description provided for @family_statusConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get family_statusConnected;

  /// No description provided for @family_statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get family_statusPending;

  /// No description provided for @family_successSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your family member has been added successfully.'**
  String get family_successSubtitle;

  /// No description provided for @family_successTitle.
  ///
  /// In en, this message translates to:
  /// **'Family connected'**
  String get family_successTitle;

  /// No description provided for @family_yourFamilyLabel.
  ///
  /// In en, this message translates to:
  /// **'Your family'**
  String get family_yourFamilyLabel;

  /// No description provided for @rewards_title.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewards_title;

  /// No description provided for @rewards_currentTier.
  ///
  /// In en, this message translates to:
  /// **'Current tier'**
  String get rewards_currentTier;

  /// No description provided for @rewards_silver.
  ///
  /// In en, this message translates to:
  /// **'Silver'**
  String get rewards_silver;

  /// No description provided for @rewards_bronze.
  ///
  /// In en, this message translates to:
  /// **'Bronze'**
  String get rewards_bronze;

  /// No description provided for @rewards_gold.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get rewards_gold;

  /// No description provided for @rewards_platinum.
  ///
  /// In en, this message translates to:
  /// **'Platinum'**
  String get rewards_platinum;

  /// No description provided for @rewards_pointsBalance.
  ///
  /// In en, this message translates to:
  /// **'Points balance'**
  String get rewards_pointsBalance;

  /// No description provided for @rewards_pointsThisMatch.
  ///
  /// In en, this message translates to:
  /// **'This matchday'**
  String get rewards_pointsThisMatch;

  /// No description provided for @rewards_earnMore.
  ///
  /// In en, this message translates to:
  /// **'Earn more points'**
  String get rewards_earnMore;

  /// No description provided for @rewards_scanIn.
  ///
  /// In en, this message translates to:
  /// **'Scan in at entry +50'**
  String get rewards_scanIn;

  /// No description provided for @rewards_orderFood.
  ///
  /// In en, this message translates to:
  /// **'Order food & beverage +20/order'**
  String get rewards_orderFood;

  /// No description provided for @rewards_visitExhibit.
  ///
  /// In en, this message translates to:
  /// **'Visit Legacy Capsule exhibit +100'**
  String get rewards_visitExhibit;

  /// No description provided for @rewards_bringFriend.
  ///
  /// In en, this message translates to:
  /// **'Bring a friend +150'**
  String get rewards_bringFriend;

  /// No description provided for @rewards_redeemFor.
  ///
  /// In en, this message translates to:
  /// **'Redeem points for'**
  String get rewards_redeemFor;

  /// No description provided for @rewards_merchDiscount.
  ///
  /// In en, this message translates to:
  /// **'15% merchandise voucher'**
  String get rewards_merchDiscount;

  /// No description provided for @rewards_merchCost.
  ///
  /// In en, this message translates to:
  /// **'1,200 pts'**
  String get rewards_merchCost;

  /// No description provided for @rewards_foodVoucher.
  ///
  /// In en, this message translates to:
  /// **'Food & beverage voucher'**
  String get rewards_foodVoucher;

  /// No description provided for @rewards_foodCost.
  ///
  /// In en, this message translates to:
  /// **'800 pts'**
  String get rewards_foodCost;

  /// No description provided for @rewards_earlyEntry.
  ///
  /// In en, this message translates to:
  /// **'Early stadium entry pass'**
  String get rewards_earlyEntry;

  /// No description provided for @rewards_earlyEntryCost.
  ///
  /// In en, this message translates to:
  /// **'2,500 pts'**
  String get rewards_earlyEntryCost;

  /// No description provided for @rewards_museumAccess.
  ///
  /// In en, this message translates to:
  /// **'Legacy Capsule private access'**
  String get rewards_museumAccess;

  /// No description provided for @rewards_museumAccessCost.
  ///
  /// In en, this message translates to:
  /// **'5,000 pts'**
  String get rewards_museumAccessCost;

  /// No description provided for @smartExit_title.
  ///
  /// In en, this message translates to:
  /// **'Smart Exit'**
  String get smartExit_title;

  /// No description provided for @smartExit_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick the fastest way out based on live crowd data'**
  String get smartExit_subtitle;

  /// No description provided for @smartExit_recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get smartExit_recommended;

  /// No description provided for @smartExit_fastest.
  ///
  /// In en, this message translates to:
  /// **'Fastest route'**
  String get smartExit_fastest;

  /// No description provided for @smartExit_crowd.
  ///
  /// In en, this message translates to:
  /// **'Crowd level'**
  String get smartExit_crowd;

  /// No description provided for @smartExit_low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get smartExit_low;

  /// No description provided for @smartExit_medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get smartExit_medium;

  /// No description provided for @smartExit_high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get smartExit_high;

  /// No description provided for @smartExit_eta.
  ///
  /// In en, this message translates to:
  /// **'ETA {minutes} min'**
  String smartExit_eta(String minutes);

  /// No description provided for @smartExit_gate.
  ///
  /// In en, this message translates to:
  /// **'Gate {name}'**
  String smartExit_gate(String name);

  /// No description provided for @smartExit_start.
  ///
  /// In en, this message translates to:
  /// **'Start exit guidance'**
  String get smartExit_start;

  /// No description provided for @smartExit_live.
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get smartExit_live;

  /// No description provided for @smartExit_etaLabel.
  ///
  /// In en, this message translates to:
  /// **'ETA'**
  String get smartExit_etaLabel;

  /// No description provided for @smartExit_distanceLabel.
  ///
  /// In en, this message translates to:
  /// **'DISTANCE'**
  String get smartExit_distanceLabel;

  /// No description provided for @smartExit_exitStrategy.
  ///
  /// In en, this message translates to:
  /// **'Exit Strategy'**
  String get smartExit_exitStrategy;

  /// No description provided for @smartExit_findMyCar.
  ///
  /// In en, this message translates to:
  /// **'Find My Car'**
  String get smartExit_findMyCar;

  /// No description provided for @smartExit_coolingZones.
  ///
  /// In en, this message translates to:
  /// **'Cooling Zones'**
  String get smartExit_coolingZones;

  /// No description provided for @smartExit_firstAid.
  ///
  /// In en, this message translates to:
  /// **'First Aid'**
  String get smartExit_firstAid;

  /// No description provided for @smartExit_foodCourt.
  ///
  /// In en, this message translates to:
  /// **'Food Court'**
  String get smartExit_foodCourt;

  /// No description provided for @smartExit_comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get smartExit_comingSoon;

  /// No description provided for @smartExit_startGuidedExit.
  ///
  /// In en, this message translates to:
  /// **'START GUIDED EXIT'**
  String get smartExit_startGuidedExit;

  /// No description provided for @sos_title.
  ///
  /// In en, this message translates to:
  /// **'Emergency SOS'**
  String get sos_title;

  /// No description provided for @sos_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Hold for 3 seconds to alert response teams with your live location'**
  String get sos_subtitle;

  /// No description provided for @sos_holdButton.
  ///
  /// In en, this message translates to:
  /// **'HOLD TO ACTIVATE'**
  String get sos_holdButton;

  /// No description provided for @sos_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get sos_cancel;

  /// No description provided for @sos_countdown.
  ///
  /// In en, this message translates to:
  /// **'Releasing cancels… {seconds}'**
  String sos_countdown(String seconds);

  /// No description provided for @sos_confirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Alert sent successfully'**
  String get sos_confirmationTitle;

  /// No description provided for @sos_confirmationSub.
  ///
  /// In en, this message translates to:
  /// **'Response teams are on their way. Your live location is being shared.'**
  String get sos_confirmationSub;

  /// No description provided for @sos_sharingLocation.
  ///
  /// In en, this message translates to:
  /// **'Sharing live location'**
  String get sos_sharingLocation;

  /// No description provided for @sos_callResponder.
  ///
  /// In en, this message translates to:
  /// **'Call responder'**
  String get sos_callResponder;

  /// No description provided for @sos_falseAlarm.
  ///
  /// In en, this message translates to:
  /// **'False alarm — cancel alert'**
  String get sos_falseAlarm;

  /// No description provided for @sos_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get sos_done;

  /// No description provided for @findCar_title.
  ///
  /// In en, this message translates to:
  /// **'Find My Car'**
  String get findCar_title;

  /// No description provided for @findCar_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Guided navigation to your parking spot'**
  String get findCar_subtitle;

  /// No description provided for @findCar_zone.
  ///
  /// In en, this message translates to:
  /// **'Zone {id}'**
  String findCar_zone(String id);

  /// No description provided for @findCar_row.
  ///
  /// In en, this message translates to:
  /// **'Row {name}'**
  String findCar_row(String name);

  /// No description provided for @findCar_spot.
  ///
  /// In en, this message translates to:
  /// **'Spot {number}'**
  String findCar_spot(String number);

  /// No description provided for @findCar_level.
  ///
  /// In en, this message translates to:
  /// **'Level {num}'**
  String findCar_level(String num);

  /// No description provided for @findCar_walkTime.
  ///
  /// In en, this message translates to:
  /// **'~{minutes} min walk'**
  String findCar_walkTime(String minutes);

  /// No description provided for @findCar_startNav.
  ///
  /// In en, this message translates to:
  /// **'Start navigation'**
  String get findCar_startNav;

  /// No description provided for @findCar_updateSpot.
  ///
  /// In en, this message translates to:
  /// **'Update my spot'**
  String get findCar_updateSpot;

  /// No description provided for @trip_title.
  ///
  /// In en, this message translates to:
  /// **'Evening Plan'**
  String get trip_title;

  /// No description provided for @trip_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your curated schedule for tonight\'s matchday'**
  String get trip_subtitle;

  /// No description provided for @trip_startsAt.
  ///
  /// In en, this message translates to:
  /// **'Starts at {time}'**
  String trip_startsAt(String time);

  /// No description provided for @trip_endsAt.
  ///
  /// In en, this message translates to:
  /// **'Ends at {time}'**
  String trip_endsAt(String time);

  /// No description provided for @trip_stops.
  ///
  /// In en, this message translates to:
  /// **'{count} stops'**
  String trip_stops(String count);

  /// No description provided for @trip_totalDuration.
  ///
  /// In en, this message translates to:
  /// **'Total duration ~{hours}h'**
  String trip_totalDuration(String hours);

  /// No description provided for @trip_leaveNow.
  ///
  /// In en, this message translates to:
  /// **'Leave now'**
  String get trip_leaveNow;

  /// No description provided for @trip_leaveEarlier.
  ///
  /// In en, this message translates to:
  /// **'Leave earlier tonight'**
  String get trip_leaveEarlier;

  /// No description provided for @trip_leaveSoon.
  ///
  /// In en, this message translates to:
  /// **'Leave soon to make it on time for your first stop: {stop}'**
  String trip_leaveSoon(String stop);

  /// No description provided for @trip_kickoffIn.
  ///
  /// In en, this message translates to:
  /// **'Kickoff in {time}'**
  String trip_kickoffIn(String time);

  /// No description provided for @trip_sharePlanPrefix.
  ///
  /// In en, this message translates to:
  /// **'My evening plan:'**
  String get trip_sharePlanPrefix;

  /// No description provided for @trip_categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get trip_categoryLabel;

  /// No description provided for @trip_categoryFood.
  ///
  /// In en, this message translates to:
  /// **'Food & drink'**
  String get trip_categoryFood;

  /// No description provided for @trip_categorySport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get trip_categorySport;

  /// No description provided for @trip_categoryArt.
  ///
  /// In en, this message translates to:
  /// **'Art & culture'**
  String get trip_categoryArt;

  /// No description provided for @trip_categoryRelax.
  ///
  /// In en, this message translates to:
  /// **'Relax'**
  String get trip_categoryRelax;

  /// No description provided for @trip_hintTitleExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. Dinner at Rem'**
  String get trip_hintTitleExample;

  /// No description provided for @trip_hintDetailsExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. 10 min walk'**
  String get trip_hintDetailsExample;

  /// No description provided for @trip_planCopied.
  ///
  /// In en, this message translates to:
  /// **'Plan copied to share'**
  String get trip_planCopied;

  /// No description provided for @trip_addedToPlan.
  ///
  /// In en, this message translates to:
  /// **'Added to your plan'**
  String get trip_addedToPlan;

  /// No description provided for @trip_planCleared.
  ///
  /// In en, this message translates to:
  /// **'Plan cleared'**
  String get trip_planCleared;

  /// No description provided for @trip_clearThisPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear this plan?'**
  String get trip_clearThisPlanTitle;

  /// No description provided for @trip_clearThisPlanBody.
  ///
  /// In en, this message translates to:
  /// **'All {count} stops will be removed. You can build a new plan from scratch after.'**
  String trip_clearThisPlanBody(String count);

  /// No description provided for @trip_clearPlan.
  ///
  /// In en, this message translates to:
  /// **'Clear plan'**
  String get trip_clearPlan;

  /// No description provided for @trip_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get trip_cancel;

  /// No description provided for @trip_opensDirectionsNextStop.
  ///
  /// In en, this message translates to:
  /// **'Opens directions to your next stop'**
  String get trip_opensDirectionsNextStop;

  /// No description provided for @trip_tonightsPlan.
  ///
  /// In en, this message translates to:
  /// **'Tonight\'s plan'**
  String get trip_tonightsPlan;

  /// No description provided for @trip_leaveByHint.
  ///
  /// In en, this message translates to:
  /// **'Leave by 5:40 to catch the fan zone before kickoff.'**
  String trip_leaveByHint(Object time);

  /// No description provided for @trip_navigateNextStop.
  ///
  /// In en, this message translates to:
  /// **'Navigate to next stop'**
  String get trip_navigateNextStop;

  /// No description provided for @trip_addAStop.
  ///
  /// In en, this message translates to:
  /// **'Add a stop'**
  String get trip_addAStop;

  /// No description provided for @trip_getDirections.
  ///
  /// In en, this message translates to:
  /// **'Get directions'**
  String get trip_getDirections;

  /// No description provided for @trip_addToPlan.
  ///
  /// In en, this message translates to:
  /// **'Add to plan'**
  String get trip_addToPlan;

  /// No description provided for @trip_fieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get trip_fieldTitle;

  /// No description provided for @trip_fieldTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get trip_fieldTime;

  /// No description provided for @trip_fieldDetailsOptional.
  ///
  /// In en, this message translates to:
  /// **'Details (optional)'**
  String get trip_fieldDetailsOptional;

  /// No description provided for @trip_hintExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. 6:45 PM'**
  String get trip_hintExample;

  /// No description provided for @trip_formError.
  ///
  /// In en, this message translates to:
  /// **'Add a title and a time like \"6:45 PM\".'**
  String get trip_formError;

  /// No description provided for @trip_myEveningPlan.
  ///
  /// In en, this message translates to:
  /// **'My evening plan'**
  String get trip_myEveningPlan;

  /// No description provided for @trip_notePrefix.
  ///
  /// In en, this message translates to:
  /// **'Note: '**
  String get trip_notePrefix;

  /// No description provided for @aiPlanner_title.
  ///
  /// In en, this message translates to:
  /// **'AI Planner'**
  String get aiPlanner_title;

  /// No description provided for @aiPlanner_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us what you want — we\'ll build your perfect matchday experience'**
  String get aiPlanner_subtitle;

  /// No description provided for @aiPlanner_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. I want to watch the warm-up, grab food before kickoff, and visit the Legacy Capsule at halftime…'**
  String get aiPlanner_placeholder;

  /// No description provided for @aiPlanner_send.
  ///
  /// In en, this message translates to:
  /// **'Generate plan'**
  String get aiPlanner_send;

  /// No description provided for @aiPlanner_thinking.
  ///
  /// In en, this message translates to:
  /// **'Planning your perfect evening…'**
  String get aiPlanner_thinking;

  /// No description provided for @aiPlanner_suggestions.
  ///
  /// In en, this message translates to:
  /// **'Try saying:'**
  String get aiPlanner_suggestions;

  /// No description provided for @aiPlanner_suggestion1.
  ///
  /// In en, this message translates to:
  /// **'Family-friendly with early exit'**
  String get aiPlanner_suggestion1;

  /// No description provided for @aiPlanner_suggestion2.
  ///
  /// In en, this message translates to:
  /// **'Premium lounge + meet the players'**
  String get aiPlanner_suggestion2;

  /// No description provided for @aiPlanner_suggestion3.
  ///
  /// In en, this message translates to:
  /// **'Quick visit: match only'**
  String get aiPlanner_suggestion3;

  /// No description provided for @aiPlanner_online.
  ///
  /// In en, this message translates to:
  /// **'ONLINE'**
  String get aiPlanner_online;

  /// No description provided for @aiPlanner_simulatedMode.
  ///
  /// In en, this message translates to:
  /// **'Running in simulated mode — add a real API key in Settings to enable live responses.'**
  String get aiPlanner_simulatedMode;

  /// No description provided for @aiPlanner_welcome.
  ///
  /// In en, this message translates to:
  /// **'Ahlan! I am Abu Al-Areef (ابو العريف), your AXN Smart City co-pilot. How can I help you plan your evening, navigate the stadium, find parking, or suggest places to visit in Jordan today?'**
  String get aiPlanner_welcome;

  /// No description provided for @aiPlanner_quickQuery1.
  ///
  /// In en, this message translates to:
  /// **'How is Gate 1 density?'**
  String get aiPlanner_quickQuery1;

  /// No description provided for @aiPlanner_quickQuery2.
  ///
  /// In en, this message translates to:
  /// **'Suggest a quiet cafe'**
  String get aiPlanner_quickQuery2;

  /// No description provided for @aiPlanner_quickQuery3.
  ///
  /// In en, this message translates to:
  /// **'Find my parking spot'**
  String get aiPlanner_quickQuery3;

  /// No description provided for @aiPlanner_quickQuery4.
  ///
  /// In en, this message translates to:
  /// **'Plan my evening in Amman'**
  String get aiPlanner_quickQuery4;

  /// No description provided for @aiPlanner_quickQuery5.
  ///
  /// In en, this message translates to:
  /// **'Places to visit in Jordan'**
  String get aiPlanner_quickQuery5;

  /// No description provided for @aiPlanner_responseDensity.
  ///
  /// In en, this message translates to:
  /// **'Gate 1 area currently has moderate density (17,842 visitors). However, Gate 3 is extremely clear with no queues! I suggest using Gate 3 for a seamless exit.'**
  String get aiPlanner_responseDensity;

  /// No description provided for @aiPlanner_responseCafe.
  ///
  /// In en, this message translates to:
  /// **'I highly recommend Al-Waha Rooftop Cafe! It has a gorgeous view of Prince Al Hussein Stadium and serves traditional cardamom coffee. It\'s just a 3-minute walk from Gate 1.'**
  String get aiPlanner_responseCafe;

  /// No description provided for @aiPlanner_responseParking.
  ///
  /// In en, this message translates to:
  /// **'Based on your active sync, your car is parked in Zone B, Slot 42. Follow the marked path from Sector C to exit directly next to Zone B.'**
  String get aiPlanner_responseParking;

  /// No description provided for @aiPlanner_responseEvening.
  ///
  /// In en, this message translates to:
  /// **'For a perfect evening in Jordan, I suggest visiting the Amman Citadel to watch a spectacular sunset over the hills, followed by hot Knafeh from Habibah downtown, and then tea at a cozy rooftop in Rainbow Street.'**
  String get aiPlanner_responseEvening;

  /// No description provided for @aiPlanner_responseJordan.
  ///
  /// In en, this message translates to:
  /// **'Jordan is rich in wonders! You must see Petra (the rose-red Nabataean city), Wadi Rum (stay in a Martian bubble camp), float in the Dead Sea, explore the Roman ruins of Jerash, and visit Ajloun Castle.'**
  String get aiPlanner_responseJordan;

  /// No description provided for @aiPlanner_responseOfftopic.
  ///
  /// In en, this message translates to:
  /// **'Ahlan! As Abu Al-Areef, your AXN Smart City Co-Pilot, my expertise is strictly dedicated to Prince Al Hussein Stadium facilities, gates, parking, and Jordan evening exploration itineraries. I cannot answer general or off-topic questions. How can I assist with your stadium visit today?'**
  String get aiPlanner_responseOfftopic;

  /// No description provided for @aiPlanner_responseDefault.
  ///
  /// In en, this message translates to:
  /// **'Ahlan! I am Abu Al-Areef, your AXN Smart City Co-Pilot. I specialize exclusively in Prince Al Hussein Stadium guidance, matchday facilities, parking, and Jordan exploration itineraries. How can I assist with your stadium visit, Gate density, or evening plans today?'**
  String get aiPlanner_responseDefault;

  /// No description provided for @activeRoute_title.
  ///
  /// In en, this message translates to:
  /// **'Active Route'**
  String get activeRoute_title;

  /// No description provided for @activeRoute_nextStop.
  ///
  /// In en, this message translates to:
  /// **'Next stop'**
  String get activeRoute_nextStop;

  /// No description provided for @activeRoute_eta.
  ///
  /// In en, this message translates to:
  /// **'ETA {time}'**
  String activeRoute_eta(String time);

  /// No description provided for @activeRoute_progress.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total}'**
  String activeRoute_progress(String current, String total);

  /// No description provided for @activeRoute_remaining.
  ///
  /// In en, this message translates to:
  /// **'{count} stops remaining'**
  String activeRoute_remaining(String count);

  /// No description provided for @activeRoute_endRoute.
  ///
  /// In en, this message translates to:
  /// **'End route'**
  String get activeRoute_endRoute;

  /// No description provided for @activeRoute_detailsTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Route Details'**
  String get activeRoute_detailsTitle;

  /// No description provided for @activeRoute_detailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Step-by-Step Egress Guidance'**
  String get activeRoute_detailsSubtitle;

  /// No description provided for @activeRoute_guidanceBadge.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE PATH GUIDANCE'**
  String get activeRoute_guidanceBadge;

  /// No description provided for @activeRoute_optimizedBadge.
  ///
  /// In en, this message translates to:
  /// **'AI OPTIMIZED'**
  String get activeRoute_optimizedBadge;

  /// No description provided for @activeRoute_timelineTitle.
  ///
  /// In en, this message translates to:
  /// **'STEP-BY-STEP EGRESS TIMELINE'**
  String get activeRoute_timelineTitle;

  /// No description provided for @activeRoute_returnToMap.
  ///
  /// In en, this message translates to:
  /// **'RETURN TO MAP'**
  String get activeRoute_returnToMap;

  /// No description provided for @activeRoute_oasisLabel.
  ///
  /// In en, this message translates to:
  /// **'Air-Cooled Rest Oasis'**
  String get activeRoute_oasisLabel;

  /// No description provided for @activeRoute_timeLeft.
  ///
  /// In en, this message translates to:
  /// **'TIME LEFT'**
  String get activeRoute_timeLeft;

  /// No description provided for @activeRoute_distance.
  ///
  /// In en, this message translates to:
  /// **'DISTANCE'**
  String get activeRoute_distance;

  /// No description provided for @activeRoute_flowStatus.
  ///
  /// In en, this message translates to:
  /// **'FLOW STATUS'**
  String get activeRoute_flowStatus;

  /// No description provided for @childSafety_title.
  ///
  /// In en, this message translates to:
  /// **'Child Safety'**
  String get childSafety_title;

  /// No description provided for @childSafety_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Link children with safety wristbands and get instant alerts if they move outside safe zones.'**
  String get childSafety_subtitle;

  /// No description provided for @childSafety_linkWristband.
  ///
  /// In en, this message translates to:
  /// **'Link a wristband'**
  String get childSafety_linkWristband;

  /// No description provided for @childSafety_safeZones.
  ///
  /// In en, this message translates to:
  /// **'Safe zones'**
  String get childSafety_safeZones;

  /// No description provided for @childSafety_alertHistory.
  ///
  /// In en, this message translates to:
  /// **'Alert history'**
  String get childSafety_alertHistory;

  /// No description provided for @childAlert_title.
  ///
  /// In en, this message translates to:
  /// **'Child Alert'**
  String get childAlert_title;

  /// No description provided for @childAlert_active.
  ///
  /// In en, this message translates to:
  /// **'Alert active'**
  String get childAlert_active;

  /// No description provided for @childAlert_locationShared.
  ///
  /// In en, this message translates to:
  /// **'Live location shared with response teams'**
  String get childAlert_locationShared;

  /// No description provided for @childAlert_resolve.
  ///
  /// In en, this message translates to:
  /// **'Mark as resolved'**
  String get childAlert_resolve;

  /// No description provided for @profile_personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get profile_personalInfo;

  /// No description provided for @profile_nationalId.
  ///
  /// In en, this message translates to:
  /// **'National ID and verification'**
  String get profile_nationalId;

  /// No description provided for @profile_myGroups.
  ///
  /// In en, this message translates to:
  /// **'My groups'**
  String get profile_myGroups;

  /// No description provided for @profile_groupsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} groups'**
  String profile_groupsCount(String count);

  /// No description provided for @profile_groupsHint.
  ///
  /// In en, this message translates to:
  /// **'Create a Family group to enable Child Safety'**
  String get profile_groupsHint;

  /// No description provided for @profile_myVisits.
  ///
  /// In en, this message translates to:
  /// **'My Visits'**
  String get profile_myVisits;

  /// No description provided for @profile_visitHistory.
  ///
  /// In en, this message translates to:
  /// **'Visit history'**
  String get profile_visitHistory;

  /// No description provided for @profile_legacyCapsule.
  ///
  /// In en, this message translates to:
  /// **'Legacy Capsule'**
  String get profile_legacyCapsule;

  /// No description provided for @profile_savedMemories.
  ///
  /// In en, this message translates to:
  /// **'Your saved memories'**
  String get profile_savedMemories;

  /// No description provided for @profile_more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get profile_more;

  /// No description provided for @profile_privacyData.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Data'**
  String get profile_privacyData;

  /// No description provided for @profile_everythingStored.
  ///
  /// In en, this message translates to:
  /// **'Everything stored on this device'**
  String get profile_everythingStored;

  /// No description provided for @profile_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profile_settings;

  /// No description provided for @profile_rewards.
  ///
  /// In en, this message translates to:
  /// **'My Rewards'**
  String get profile_rewards;

  /// No description provided for @profile_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profile_account;

  /// No description provided for @profile_noGroups.
  ///
  /// In en, this message translates to:
  /// **'No groups yet'**
  String get profile_noGroups;

  /// No description provided for @profile_noGroupsSub.
  ///
  /// In en, this message translates to:
  /// **'Create a group to sync locations with family or friends during your next visit.'**
  String get profile_noGroupsSub;

  /// No description provided for @profile_seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get profile_seeAll;

  /// No description provided for @profile_points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get profile_points;

  /// No description provided for @profile_trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get profile_trips;

  /// No description provided for @profile_tier.
  ///
  /// In en, this message translates to:
  /// **'Tier'**
  String get profile_tier;

  /// No description provided for @profile_family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get profile_family;

  /// No description provided for @profile_nationalVerified.
  ///
  /// In en, this message translates to:
  /// **'National ID verified'**
  String get profile_nationalVerified;

  /// No description provided for @profile_group.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get profile_group;

  /// No description provided for @profile_phoneVerified.
  ///
  /// In en, this message translates to:
  /// **'Phone verified'**
  String get profile_phoneVerified;

  /// No description provided for @profile_members.
  ///
  /// In en, this message translates to:
  /// **'{count} members'**
  String profile_members(String count);

  /// No description provided for @profile_pointsToGold.
  ///
  /// In en, this message translates to:
  /// **'{points} pts to Gold'**
  String profile_pointsToGold(String points);

  /// No description provided for @profile_silver.
  ///
  /// In en, this message translates to:
  /// **'Silver'**
  String get profile_silver;

  /// No description provided for @profile_matchday.
  ///
  /// In en, this message translates to:
  /// **'Matchday'**
  String get profile_matchday;

  /// No description provided for @profile_streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get profile_streak;

  /// No description provided for @profile_previewGroups.
  ///
  /// In en, this message translates to:
  /// **'Preview groups empty state'**
  String get profile_previewGroups;

  /// No description provided for @demo_title.
  ///
  /// In en, this message translates to:
  /// **'DEMO CONTROLS'**
  String get demo_title;

  /// No description provided for @demo_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Not visible to regular users'**
  String get demo_subtitle;

  /// No description provided for @demo_simulate.
  ///
  /// In en, this message translates to:
  /// **'Simulate emergency broadcast'**
  String get demo_simulate;

  /// No description provided for @demo_simulateSub.
  ///
  /// In en, this message translates to:
  /// **'Forces evacuation mode over any screen'**
  String get demo_simulateSub;

  /// No description provided for @demo_active.
  ///
  /// In en, this message translates to:
  /// **'Emergency broadcast active'**
  String get demo_active;

  /// No description provided for @demo_activeSub.
  ///
  /// In en, this message translates to:
  /// **'Evacuation mode is showing on the app now'**
  String get demo_activeSub;

  /// No description provided for @demo_live.
  ///
  /// In en, this message translates to:
  /// **'Broadcast live on screen'**
  String get demo_live;

  /// No description provided for @demo_startBtn.
  ///
  /// In en, this message translates to:
  /// **'Simulate broadcast'**
  String get demo_startBtn;

  /// No description provided for @demo_stopBtn.
  ///
  /// In en, this message translates to:
  /// **'Stop simulation'**
  String get demo_stopBtn;

  /// No description provided for @demo_note.
  ///
  /// In en, this message translates to:
  /// **'Tap stop anytime to instantly restore the normal screen — safe to use live during the demo.'**
  String get demo_note;

  /// No description provided for @home_pointsLabel.
  ///
  /// In en, this message translates to:
  /// **'{points} pts'**
  String home_pointsLabel(String points);

  /// No description provided for @home_envAirValue.
  ///
  /// In en, this message translates to:
  /// **'24°C'**
  String get home_envAirValue;

  /// No description provided for @home_envNoiseValue.
  ///
  /// In en, this message translates to:
  /// **'72 dB'**
  String get home_envNoiseValue;

  /// No description provided for @home_envSafetyValue.
  ///
  /// In en, this message translates to:
  /// **'0 incidents'**
  String get home_envSafetyValue;

  /// No description provided for @sos_topbarTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency SOS'**
  String get sos_topbarTitle;

  /// No description provided for @sos_topbarSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm to alert the on-site safety team'**
  String get sos_topbarSubtitle;

  /// No description provided for @sos_typeName.
  ///
  /// In en, this message translates to:
  /// **'Medical Emergency'**
  String get sos_typeName;

  /// No description provided for @sos_typeDescription.
  ///
  /// In en, this message translates to:
  /// **'The nearest medical team will be dispatched to your location'**
  String get sos_typeDescription;

  /// No description provided for @sos_countdownLabel.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get sos_countdownLabel;

  /// No description provided for @sos_countdownAutoPrefix.
  ///
  /// In en, this message translates to:
  /// **'Auto-sending in — '**
  String get sos_countdownAutoPrefix;

  /// No description provided for @sos_countdownHint.
  ///
  /// In en, this message translates to:
  /// **'you can cancel anytime before it\'s sent.'**
  String get sos_countdownHint;

  /// No description provided for @sos_locationSectionLabel.
  ///
  /// In en, this message translates to:
  /// **'YOUR LOCATION'**
  String get sos_locationSectionLabel;

  /// No description provided for @sos_locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get sos_locationLabel;

  /// No description provided for @sos_locationValue.
  ///
  /// In en, this message translates to:
  /// **'Gate 14, Section 214'**
  String get sos_locationValue;

  /// No description provided for @sos_gpsAccuracy.
  ///
  /// In en, this message translates to:
  /// **'GPS Accurate'**
  String get sos_gpsAccuracy;

  /// No description provided for @sos_serviceSectionLabel.
  ///
  /// In en, this message translates to:
  /// **'RESPONDING SERVICE'**
  String get sos_serviceSectionLabel;

  /// No description provided for @sos_serviceName.
  ///
  /// In en, this message translates to:
  /// **'Medical Response Team'**
  String get sos_serviceName;

  /// No description provided for @sos_serviceMeta.
  ///
  /// In en, this message translates to:
  /// **'On-site paramedics'**
  String get sos_serviceMeta;

  /// No description provided for @sos_serviceEta.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get sos_serviceEta;

  /// No description provided for @sos_eta.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get sos_eta;

  /// No description provided for @sos_confirmButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Send Alert Now'**
  String get sos_confirmButtonLabel;

  /// No description provided for @sos_cancelButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get sos_cancelButtonLabel;

  /// No description provided for @sos_cancelledToast.
  ///
  /// In en, this message translates to:
  /// **'SOS alert cancelled'**
  String get sos_cancelledToast;

  /// No description provided for @sos_safetyNote.
  ///
  /// In en, this message translates to:
  /// **'Your location and emergency type are shared only with the on-site safety team.'**
  String get sos_safetyNote;

  /// No description provided for @sos_sendStep1.
  ///
  /// In en, this message translates to:
  /// **'Locating you…'**
  String get sos_sendStep1;

  /// No description provided for @sos_sendStep2.
  ///
  /// In en, this message translates to:
  /// **'Notifying safety team…'**
  String get sos_sendStep2;

  /// No description provided for @sos_sendStep3.
  ///
  /// In en, this message translates to:
  /// **'Dispatching responder…'**
  String get sos_sendStep3;

  /// No description provided for @sos_sendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Sending your alert'**
  String get sos_sendingTitle;

  /// No description provided for @sos_sendingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please stay where you are — help is on the way.'**
  String get sos_sendingSubtitle;

  /// No description provided for @sos_successTitle.
  ///
  /// In en, this message translates to:
  /// **'Help is on the way'**
  String get sos_successTitle;

  /// No description provided for @sos_successSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A responder has been notified and is heading to your location.'**
  String get sos_successSubtitle;

  /// No description provided for @sos_successEtaValue.
  ///
  /// In en, this message translates to:
  /// **'3 min'**
  String get sos_successEtaValue;

  /// No description provided for @sos_successEtaLabel.
  ///
  /// In en, this message translates to:
  /// **'Estimated arrival'**
  String get sos_successEtaLabel;

  /// No description provided for @sos_successNearestValue.
  ///
  /// In en, this message translates to:
  /// **'Gate 14'**
  String get sos_successNearestValue;

  /// No description provided for @sos_successNearestLabel.
  ///
  /// In en, this message translates to:
  /// **'Nearest exit'**
  String get sos_successNearestLabel;

  /// No description provided for @sos_successDoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get sos_successDoneLabel;

  /// No description provided for @sos_failedTitle.
  ///
  /// In en, this message translates to:
  /// **'Alert failed to send'**
  String get sos_failedTitle;

  /// No description provided for @sos_failedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t reach the safety team. Try again or call the operations center directly.'**
  String get sos_failedSubtitle;

  /// No description provided for @sos_failedRetryLabel.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get sos_failedRetryLabel;

  /// No description provided for @sos_failedCallLabel.
  ///
  /// In en, this message translates to:
  /// **'Call Operations Center'**
  String get sos_failedCallLabel;

  /// No description provided for @rewards_points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get rewards_points;

  /// No description provided for @rewards_pointsToTier.
  ///
  /// In en, this message translates to:
  /// **'{points} pts to {tier}'**
  String rewards_pointsToTier(String points, String tier);

  /// No description provided for @rewards_trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get rewards_trips;

  /// No description provided for @rewards_tierLabel.
  ///
  /// In en, this message translates to:
  /// **'Tier'**
  String get rewards_tierLabel;

  /// No description provided for @rewards_streakTitle.
  ///
  /// In en, this message translates to:
  /// **'{days}-day streak'**
  String rewards_streakTitle(String days);

  /// No description provided for @rewards_streakSub.
  ///
  /// In en, this message translates to:
  /// **'Keep it up — one slip and it resets'**
  String get rewards_streakSub;

  /// No description provided for @rewards_currentLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Level'**
  String get rewards_currentLevelLabel;

  /// No description provided for @rewards_xpValue.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP'**
  String rewards_xpValue(String xp);

  /// No description provided for @rewards_pointsExpireTitle.
  ///
  /// In en, this message translates to:
  /// **'Points Expire'**
  String get rewards_pointsExpireTitle;

  /// No description provided for @rewards_featuredAchievement.
  ///
  /// In en, this message translates to:
  /// **'FEATURED ACHIEVEMENT'**
  String get rewards_featuredAchievement;

  /// No description provided for @rewards_greenLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Green level'**
  String get rewards_greenLevelLabel;

  /// No description provided for @rewards_redeemButton.
  ///
  /// In en, this message translates to:
  /// **'Redeem'**
  String get rewards_redeemButton;

  /// No description provided for @rewards_yourTripsThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Your trips this month'**
  String get rewards_yourTripsThisMonth;

  /// No description provided for @rewards_fromSource.
  ///
  /// In en, this message translates to:
  /// **'From {source}'**
  String rewards_fromSource(String source);

  /// No description provided for @rewards_convertedTitle.
  ///
  /// In en, this message translates to:
  /// **'Converted'**
  String get rewards_convertedTitle;

  /// No description provided for @rewards_convertedBody.
  ///
  /// In en, this message translates to:
  /// **'Your green points were added to your Rewards balance.'**
  String get rewards_convertedBody;

  /// No description provided for @rewards_doneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get rewards_doneButton;

  /// No description provided for @rewards_costLabel.
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get rewards_costLabel;

  /// No description provided for @rewards_pointsSuffix.
  ///
  /// In en, this message translates to:
  /// **'{points} points'**
  String rewards_pointsSuffix(String points);

  /// No description provided for @rewards_redeemedTitle.
  ///
  /// In en, this message translates to:
  /// **'Redeemed'**
  String get rewards_redeemedTitle;

  /// No description provided for @rewards_showCodeAt.
  ///
  /// In en, this message translates to:
  /// **'Show this code at {place}'**
  String rewards_showCodeAt(String place);

  /// No description provided for @rewards_pageTitle.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewards_pageTitle;

  /// No description provided for @childSafety_lastUpdateLabel.
  ///
  /// In en, this message translates to:
  /// **'Last update'**
  String get childSafety_lastUpdateLabel;

  /// No description provided for @childSafety_closeAlertButton.
  ///
  /// In en, this message translates to:
  /// **'Close alert'**
  String get childSafety_closeAlertButton;

  /// No description provided for @rewards_silverVsGold.
  ///
  /// In en, this message translates to:
  /// **'Silver vs. Gold'**
  String get rewards_silverVsGold;

  /// No description provided for @childAlert_activeTitle.
  ///
  /// In en, this message translates to:
  /// **'Child Safety Alert'**
  String get childAlert_activeTitle;

  /// No description provided for @childAlert_activeMetaTriggeredAt.
  ///
  /// In en, this message translates to:
  /// **'Triggered at '**
  String get childAlert_activeMetaTriggeredAt;

  /// No description provided for @childAlert_activeMetaTime.
  ///
  /// In en, this message translates to:
  /// **'4:52 PM'**
  String get childAlert_activeMetaTime;

  /// No description provided for @childAlert_metaSourceSep.
  ///
  /// In en, this message translates to:
  /// **' · Source: '**
  String get childAlert_metaSourceSep;

  /// No description provided for @childAlert_metaSource.
  ///
  /// In en, this message translates to:
  /// **'Safe Zone Monitor'**
  String get childAlert_metaSource;

  /// No description provided for @childAlert_activeGuidanceBold.
  ///
  /// In en, this message translates to:
  /// **'Stay calm.'**
  String get childAlert_activeGuidanceBold;

  /// No description provided for @childAlert_activeGuidanceRest.
  ///
  /// In en, this message translates to:
  /// **' Follow the recommended steps to locate your child safely.'**
  String get childAlert_activeGuidanceRest;

  /// No description provided for @childAlert_foundTitle.
  ///
  /// In en, this message translates to:
  /// **'Child Found'**
  String get childAlert_foundTitle;

  /// No description provided for @childAlert_foundMetaConfirmedAt.
  ///
  /// In en, this message translates to:
  /// **'Confirmed at '**
  String get childAlert_foundMetaConfirmedAt;

  /// No description provided for @childAlert_foundMetaTime.
  ///
  /// In en, this message translates to:
  /// **'4:57 PM'**
  String get childAlert_foundMetaTime;

  /// No description provided for @childAlert_foundGuidanceBold.
  ///
  /// In en, this message translates to:
  /// **'Great news.'**
  String get childAlert_foundGuidanceBold;

  /// No description provided for @childAlert_foundGuidanceRest.
  ///
  /// In en, this message translates to:
  /// **' Child 1 has been located and is safe. You can close this alert whenever you\'re ready.'**
  String get childAlert_foundGuidanceRest;

  /// No description provided for @childAlert_resolvedTitle.
  ///
  /// In en, this message translates to:
  /// **'Alert Resolved'**
  String get childAlert_resolvedTitle;

  /// No description provided for @childAlert_resolvedMetaClosedAt.
  ///
  /// In en, this message translates to:
  /// **'Closed at '**
  String get childAlert_resolvedMetaClosedAt;

  /// No description provided for @childAlert_resolvedMetaTime.
  ///
  /// In en, this message translates to:
  /// **'4:58 PM'**
  String get childAlert_resolvedMetaTime;

  /// No description provided for @childAlert_resolvedMetaReviewedBySep.
  ///
  /// In en, this message translates to:
  /// **' · Reviewed by '**
  String get childAlert_resolvedMetaReviewedBySep;

  /// No description provided for @childAlert_resolvedMetaReviewedBy.
  ///
  /// In en, this message translates to:
  /// **'Stadium Safety Team'**
  String get childAlert_resolvedMetaReviewedBy;

  /// No description provided for @childAlert_resolvedGuidance.
  ///
  /// In en, this message translates to:
  /// **'This alert has been closed and archived. Reach out to Family Safety anytime if you have questions.'**
  String get childAlert_resolvedGuidance;

  /// No description provided for @childAlert_unavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Location Unavailable'**
  String get childAlert_unavailableTitle;

  /// No description provided for @childAlert_unavailableMetaLastSignal.
  ///
  /// In en, this message translates to:
  /// **'Last signal '**
  String get childAlert_unavailableMetaLastSignal;

  /// No description provided for @childAlert_unavailableGuidanceBold.
  ///
  /// In en, this message translates to:
  /// **'Signal lost, not lost hope.'**
  String get childAlert_unavailableGuidanceBold;

  /// No description provided for @childAlert_unavailableGuidanceRest.
  ///
  /// In en, this message translates to:
  /// **' Contact Emergency Support — stadium staff can locate Child 1 using venue cameras.'**
  String get childAlert_unavailableGuidanceRest;

  /// No description provided for @childAlertSticky_activeStatusLine.
  ///
  /// In en, this message translates to:
  /// **'Left Safe Zone near Gate C'**
  String get childAlertSticky_activeStatusLine;

  /// No description provided for @childAlertSticky_connectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get childAlertSticky_connectedLabel;

  /// No description provided for @childAlertSticky_lastKnownLocLabel.
  ///
  /// In en, this message translates to:
  /// **'Last known location'**
  String get childAlertSticky_lastKnownLocLabel;

  /// No description provided for @childAlertSticky_outerConcourseValue.
  ///
  /// In en, this message translates to:
  /// **'Outer Concourse, near Gate C'**
  String get childAlertSticky_outerConcourseValue;

  /// No description provided for @childAlertSticky_activeLocTime.
  ///
  /// In en, this message translates to:
  /// **'38s ago'**
  String get childAlertSticky_activeLocTime;

  /// No description provided for @childAlertSticky_foundStatusLine.
  ///
  /// In en, this message translates to:
  /// **'Back inside Safe Zone, with a guardian nearby'**
  String get childAlertSticky_foundStatusLine;

  /// No description provided for @childAlertSticky_currentLocLabel.
  ///
  /// In en, this message translates to:
  /// **'Current location'**
  String get childAlertSticky_currentLocLabel;

  /// No description provided for @childAlertSticky_foundLocValue.
  ///
  /// In en, this message translates to:
  /// **'Gate C, Reunification Point'**
  String get childAlertSticky_foundLocValue;

  /// No description provided for @childAlertSticky_foundLocTime.
  ///
  /// In en, this message translates to:
  /// **'5s ago'**
  String get childAlertSticky_foundLocTime;

  /// No description provided for @childAlertSticky_unavailableStatusLine.
  ///
  /// In en, this message translates to:
  /// **'Signal lost near Gate C'**
  String get childAlertSticky_unavailableStatusLine;

  /// No description provided for @childAlertSticky_disconnectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get childAlertSticky_disconnectedLabel;

  /// No description provided for @childAlertSticky_unavailableLocTime.
  ///
  /// In en, this message translates to:
  /// **'6 min ago'**
  String get childAlertSticky_unavailableLocTime;

  /// No description provided for @sosHome_allSystemsNormal.
  ///
  /// In en, this message translates to:
  /// **'All systems normal'**
  String get sosHome_allSystemsNormal;

  /// No description provided for @sosHome_title.
  ///
  /// In en, this message translates to:
  /// **'Emergency assistance'**
  String get sosHome_title;

  /// No description provided for @sosHome_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Help is one press away. Your location is shared automatically the moment you request help.'**
  String get sosHome_subtitle;

  /// No description provided for @sosHome_holdPrefix.
  ///
  /// In en, this message translates to:
  /// **'Press and hold '**
  String get sosHome_holdPrefix;

  /// No description provided for @sosHome_holdInstructions.
  ///
  /// In en, this message translates to:
  /// **'for {seconds} seconds to alert emergency teams.\nThis is not a false-alarm risk — release anytime to cancel.'**
  String sosHome_holdInstructions(String seconds);

  /// No description provided for @sosHome_servicesLabel.
  ///
  /// In en, this message translates to:
  /// **'Emergency services'**
  String get sosHome_servicesLabel;

  /// No description provided for @sosHome_locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Your location'**
  String get sosHome_locationLabel;

  /// No description provided for @sosHome_contactsLabel.
  ///
  /// In en, this message translates to:
  /// **'Emergency contacts'**
  String get sosHome_contactsLabel;

  /// No description provided for @sosHome_detectedLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Detected location'**
  String get sosHome_detectedLocationLabel;

  /// No description provided for @sosHome_locationValue.
  ///
  /// In en, this message translates to:
  /// **'Section 214, Gate 5 concourse'**
  String get sosHome_locationValue;

  /// No description provided for @sosHome_gpsAccuracy.
  ///
  /// In en, this message translates to:
  /// **'±15m'**
  String get sosHome_gpsAccuracy;

  /// No description provided for @sosHome_shareLiveLocation.
  ///
  /// In en, this message translates to:
  /// **'Share live location'**
  String get sosHome_shareLiveLocation;

  /// No description provided for @sosHome_shareSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Visible to responders while active'**
  String get sosHome_shareSubtitle;

  /// No description provided for @sosHome_serviceNamePolice.
  ///
  /// In en, this message translates to:
  /// **'Police'**
  String get sosHome_serviceNamePolice;

  /// No description provided for @sosHome_serviceNameAmbulance.
  ///
  /// In en, this message translates to:
  /// **'Ambulance'**
  String get sosHome_serviceNameAmbulance;

  /// No description provided for @sosHome_serviceNameCivilDefense.
  ///
  /// In en, this message translates to:
  /// **'Civil Defense'**
  String get sosHome_serviceNameCivilDefense;

  /// No description provided for @sosHome_serviceNameMedical.
  ///
  /// In en, this message translates to:
  /// **'Medical emergency'**
  String get sosHome_serviceNameMedical;

  /// No description provided for @sosHome_serviceNameChildSafety.
  ///
  /// In en, this message translates to:
  /// **'Child safety'**
  String get sosHome_serviceNameChildSafety;

  /// No description provided for @sosHome_serviceNameLostPerson.
  ///
  /// In en, this message translates to:
  /// **'Lost person'**
  String get sosHome_serviceNameLostPerson;

  /// No description provided for @sosHome_contact1Name.
  ///
  /// In en, this message translates to:
  /// **'Stadium Operations Center'**
  String get sosHome_contact1Name;

  /// No description provided for @sosHome_contact1Role.
  ///
  /// In en, this message translates to:
  /// **'24/7 control room'**
  String get sosHome_contact1Role;

  /// No description provided for @sosHome_contact2Name.
  ///
  /// In en, this message translates to:
  /// **'Medical response team'**
  String get sosHome_contact2Name;

  /// No description provided for @sosHome_contact2Role.
  ///
  /// In en, this message translates to:
  /// **'On-site paramedics'**
  String get sosHome_contact2Role;

  /// No description provided for @sosHome_contact3Name.
  ///
  /// In en, this message translates to:
  /// **'Emergency contact'**
  String get sosHome_contact3Name;

  /// No description provided for @sosHome_contact3Role.
  ///
  /// In en, this message translates to:
  /// **'Personal — added by you'**
  String get sosHome_contact3Role;

  /// No description provided for @sosHome_settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'SOS settings'**
  String get sosHome_settingsTitle;

  /// No description provided for @sosHome_holdLabel.
  ///
  /// In en, this message translates to:
  /// **'HOLD {seconds} SEC'**
  String sosHome_holdLabel(String seconds);

  /// No description provided for @findCar_startWalkback.
  ///
  /// In en, this message translates to:
  /// **'START WALKBACK GUIDANCE'**
  String get findCar_startWalkback;

  /// No description provided for @findCar_activeLocatorLabel.
  ///
  /// In en, this message translates to:
  /// **'Active Parking Locator'**
  String get findCar_activeLocatorLabel;

  /// No description provided for @findCar_zoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Zone B · Row 12 · Gate 2'**
  String get findCar_zoneLabel;

  /// No description provided for @findCar_savedAgo.
  ///
  /// In en, this message translates to:
  /// **'Saved 3 hours ago'**
  String get findCar_savedAgo;

  /// No description provided for @findCar_etaMinutes.
  ///
  /// In en, this message translates to:
  /// **'3 min'**
  String get findCar_etaMinutes;

  /// No description provided for @findCar_distance.
  ///
  /// In en, this message translates to:
  /// **'196m left'**
  String get findCar_distance;

  /// No description provided for @findCar_savedSlotLabel.
  ///
  /// In en, this message translates to:
  /// **'SAVED PARKING SLOT'**
  String get findCar_savedSlotLabel;

  /// No description provided for @findCar_compassTracking.
  ///
  /// In en, this message translates to:
  /// **'COMPASS TRACKING'**
  String get findCar_compassTracking;

  /// No description provided for @evac_title.
  ///
  /// In en, this message translates to:
  /// **'Evacuation Simulation'**
  String get evac_title;

  /// No description provided for @evac_heading.
  ///
  /// In en, this message translates to:
  /// **'Emergency Evacuation'**
  String get evac_heading;

  /// No description provided for @evac_instructions.
  ///
  /// In en, this message translates to:
  /// **'Follow the nearest exit route. Stay calm and move quickly to the assembly point.'**
  String get evac_instructions;

  /// No description provided for @evac_disclaimer.
  ///
  /// In en, this message translates to:
  /// **'This is a simulation. In a real emergency, follow official instructions.'**
  String get evac_disclaimer;

  /// No description provided for @evac_exitButton.
  ///
  /// In en, this message translates to:
  /// **'Exit Simulation'**
  String get evac_exitButton;

  /// No description provided for @createGroup_title.
  ///
  /// In en, this message translates to:
  /// **'Create a group'**
  String get createGroup_title;

  /// No description provided for @createGroup_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the group type first.'**
  String get createGroup_subtitle;

  /// No description provided for @createGroup_familyTitle.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get createGroup_familyTitle;

  /// No description provided for @createGroup_familySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Child safety features'**
  String get createGroup_familySubtitle;

  /// No description provided for @createGroup_groupTitle.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get createGroup_groupTitle;

  /// No description provided for @createGroup_groupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Friends / general group'**
  String get createGroup_groupSubtitle;

  /// No description provided for @createGroup_phoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get createGroup_phoneTitle;

  /// No description provided for @createGroup_mobileLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get createGroup_mobileLabel;

  /// No description provided for @createGroup_mobilePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'+962 7 9XXX XXXX'**
  String get createGroup_mobilePlaceholder;

  /// No description provided for @createGroup_nationalIdTitle.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get createGroup_nationalIdTitle;

  /// No description provided for @createGroup_otpTitle.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get createGroup_otpTitle;

  /// No description provided for @createGroup_otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code.'**
  String get createGroup_otpSubtitle;

  /// No description provided for @createGroup_finishButton.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get createGroup_finishButton;

  /// No description provided for @createGroup_defaultFamilyName.
  ///
  /// In en, this message translates to:
  /// **'New family'**
  String get createGroup_defaultFamilyName;

  /// No description provided for @createGroup_defaultGroupName.
  ///
  /// In en, this message translates to:
  /// **'New group'**
  String get createGroup_defaultGroupName;

  /// No description provided for @childSafety_moderateSeverity.
  ///
  /// In en, this message translates to:
  /// **'MODERATE SEVERITY'**
  String get childSafety_moderateSeverity;

  /// No description provided for @rewards_completedToday.
  ///
  /// In en, this message translates to:
  /// **'Completed today'**
  String get rewards_completedToday;

  /// No description provided for @rewards_missionPointsPlus.
  ///
  /// In en, this message translates to:
  /// **'+{points} points'**
  String rewards_missionPointsPlus(String points);

  /// No description provided for @rewards_missionPointsPlusPts.
  ///
  /// In en, this message translates to:
  /// **'+{points} pts'**
  String rewards_missionPointsPlusPts(String points);

  /// No description provided for @rewards_healthDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'General information, not a reflection of your personal health status.'**
  String get rewards_healthDisclaimer;

  /// No description provided for @rewards_convertNote.
  ///
  /// In en, this message translates to:
  /// **'Converted points move to your Rewards balance and reset your green progress.'**
  String get rewards_convertNote;

  /// No description provided for @rewards_reachToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Reach {points} points to unlock'**
  String rewards_reachToUnlock(String points);

  /// No description provided for @childSafety_brandLabel.
  ///
  /// In en, this message translates to:
  /// **'AXN Smart City'**
  String get childSafety_brandLabel;

  /// No description provided for @childSafety_pageTitle.
  ///
  /// In en, this message translates to:
  /// **'Child Safety'**
  String get childSafety_pageTitle;

  /// No description provided for @childSafety_pageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep your family connected during your visit.'**
  String get childSafety_pageSubtitle;

  /// No description provided for @childSafety_childInitials.
  ///
  /// In en, this message translates to:
  /// **'C1'**
  String get childSafety_childInitials;

  /// No description provided for @childSafety_childName.
  ///
  /// In en, this message translates to:
  /// **'Child 1'**
  String get childSafety_childName;

  /// No description provided for @childSafety_ageGroup.
  ///
  /// In en, this message translates to:
  /// **'Age 8–12'**
  String get childSafety_ageGroup;

  /// No description provided for @childSafety_locationSectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Live location'**
  String get childSafety_locationSectionLabel;

  /// No description provided for @childSafety_zoneSectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Safety zone'**
  String get childSafety_zoneSectionLabel;

  /// No description provided for @childSafety_zoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Allowed area · North Stand & Concourse'**
  String get childSafety_zoneTitle;

  /// No description provided for @childSafety_activitySectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get childSafety_activitySectionLabel;

  /// No description provided for @childSafety_lastSeenLabel.
  ///
  /// In en, this message translates to:
  /// **'Last seen'**
  String get childSafety_lastSeenLabel;

  /// No description provided for @childSafety_checkInLabel.
  ///
  /// In en, this message translates to:
  /// **'Check-in status'**
  String get childSafety_checkInLabel;

  /// No description provided for @childSafety_actionsSectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get childSafety_actionsSectionLabel;

  /// No description provided for @childSafety_callChildLabel.
  ///
  /// In en, this message translates to:
  /// **'Call Child'**
  String get childSafety_callChildLabel;

  /// No description provided for @childSafety_locateChildLabel.
  ///
  /// In en, this message translates to:
  /// **'Locate Child'**
  String get childSafety_locateChildLabel;

  /// No description provided for @childSafety_checkInRequestLabel.
  ///
  /// In en, this message translates to:
  /// **'Send Check-in Request'**
  String get childSafety_checkInRequestLabel;

  /// No description provided for @childSafety_emergencyAlertLabel.
  ///
  /// In en, this message translates to:
  /// **'Emergency Alert'**
  String get childSafety_emergencyAlertLabel;

  /// No description provided for @childSafety_timeline1Location.
  ///
  /// In en, this message translates to:
  /// **'Concourse B, Section 14'**
  String get childSafety_timeline1Location;

  /// No description provided for @childSafety_timeline1Time.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get childSafety_timeline1Time;

  /// No description provided for @childSafety_timeline2Location.
  ///
  /// In en, this message translates to:
  /// **'Food Court, North Stand'**
  String get childSafety_timeline2Location;

  /// No description provided for @childSafety_timeline2Time.
  ///
  /// In en, this message translates to:
  /// **'14 min ago'**
  String get childSafety_timeline2Time;

  /// No description provided for @childSafety_timeline3Location.
  ///
  /// In en, this message translates to:
  /// **'Entered via Gate C'**
  String get childSafety_timeline3Location;

  /// No description provided for @childSafety_timeline3Time.
  ///
  /// In en, this message translates to:
  /// **'52 min ago'**
  String get childSafety_timeline3Time;

  /// No description provided for @childSafety_normalStatusText.
  ///
  /// In en, this message translates to:
  /// **'Safe and Connected'**
  String get childSafety_normalStatusText;

  /// No description provided for @childSafety_normalStatusSub.
  ///
  /// In en, this message translates to:
  /// **'Updated just now'**
  String get childSafety_normalStatusSub;

  /// No description provided for @childSafety_normalLocationValue.
  ///
  /// In en, this message translates to:
  /// **'Section 14, Concourse B'**
  String get childSafety_normalLocationValue;

  /// No description provided for @childSafety_normalLocationTime.
  ///
  /// In en, this message translates to:
  /// **'12s ago'**
  String get childSafety_normalLocationTime;

  /// No description provided for @childSafety_normalZoneStatusText.
  ///
  /// In en, this message translates to:
  /// **'Inside Safe Zone'**
  String get childSafety_normalZoneStatusText;

  /// No description provided for @childSafety_normalZoneSub.
  ///
  /// In en, this message translates to:
  /// **'You\'ll be notified if Child 1 leaves this area.'**
  String get childSafety_normalZoneSub;

  /// No description provided for @childSafety_normalLastSeen.
  ///
  /// In en, this message translates to:
  /// **'12 seconds ago'**
  String get childSafety_normalLastSeen;

  /// No description provided for @childSafety_normalCheckInText.
  ///
  /// In en, this message translates to:
  /// **'Checked in · 5 min ago'**
  String get childSafety_normalCheckInText;

  /// No description provided for @childSafety_warningConnLabel.
  ///
  /// In en, this message translates to:
  /// **'Connected · weak signal'**
  String get childSafety_warningConnLabel;

  /// No description provided for @childSafety_warningStatusText.
  ///
  /// In en, this message translates to:
  /// **'Left Safe Zone'**
  String get childSafety_warningStatusText;

  /// No description provided for @childSafety_warningStatusSub.
  ///
  /// In en, this message translates to:
  /// **'Updated 1 min ago'**
  String get childSafety_warningStatusSub;

  /// No description provided for @childSafety_warningLocationValue.
  ///
  /// In en, this message translates to:
  /// **'Near Gate C, Outer Concourse'**
  String get childSafety_warningLocationValue;

  /// No description provided for @childSafety_warningLocationTime.
  ///
  /// In en, this message translates to:
  /// **'1 min ago'**
  String get childSafety_warningLocationTime;

  /// No description provided for @childSafety_warningZoneSub.
  ///
  /// In en, this message translates to:
  /// **'Child 1 is 40m outside the allowed area near Gate C.'**
  String get childSafety_warningZoneSub;

  /// No description provided for @childSafety_warningLastSeen.
  ///
  /// In en, this message translates to:
  /// **'1 minute ago'**
  String get childSafety_warningLastSeen;

  /// No description provided for @childSafety_warningCheckInText.
  ///
  /// In en, this message translates to:
  /// **'Check-in requested · awaiting reply'**
  String get childSafety_warningCheckInText;

  /// No description provided for @childSafety_offlineStatusText.
  ///
  /// In en, this message translates to:
  /// **'Device Offline'**
  String get childSafety_offlineStatusText;

  /// No description provided for @childSafety_offlineStatusSub.
  ///
  /// In en, this message translates to:
  /// **'Last seen 18 min ago'**
  String get childSafety_offlineStatusSub;

  /// No description provided for @childSafety_offlineLocationValue.
  ///
  /// In en, this message translates to:
  /// **'Last known: Concourse B'**
  String get childSafety_offlineLocationValue;

  /// No description provided for @childSafety_offlineLocationTime.
  ///
  /// In en, this message translates to:
  /// **'18 min ago'**
  String get childSafety_offlineLocationTime;

  /// No description provided for @childSafety_offlineZoneStatusText.
  ///
  /// In en, this message translates to:
  /// **'Location unavailable'**
  String get childSafety_offlineZoneStatusText;

  /// No description provided for @childSafety_offlineZoneSub.
  ///
  /// In en, this message translates to:
  /// **'Reconnecting — showing the last known position.'**
  String get childSafety_offlineZoneSub;

  /// No description provided for @childSafety_offlineLastSeen.
  ///
  /// In en, this message translates to:
  /// **'18 minutes ago'**
  String get childSafety_offlineLastSeen;

  /// No description provided for @childSafety_offlineCheckInText.
  ///
  /// In en, this message translates to:
  /// **'Unavailable while offline'**
  String get childSafety_offlineCheckInText;

  /// No description provided for @childSafety_summaryAlertTriggered.
  ///
  /// In en, this message translates to:
  /// **'Alert triggered'**
  String get childSafety_summaryAlertTriggered;

  /// No description provided for @childSafety_summaryResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get childSafety_summaryResolved;

  /// No description provided for @childSafety_summaryDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get childSafety_summaryDuration;

  /// No description provided for @childSafety_summaryOutcome.
  ///
  /// In en, this message translates to:
  /// **'Outcome'**
  String get childSafety_summaryOutcome;

  /// No description provided for @childSafety_summaryDurationValue.
  ///
  /// In en, this message translates to:
  /// **'6 minutes'**
  String get childSafety_summaryDurationValue;

  /// No description provided for @childSafety_summaryOutcomeValue.
  ///
  /// In en, this message translates to:
  /// **'Reunited at Gate C'**
  String get childSafety_summaryOutcomeValue;

  /// No description provided for @childSafety_recommendedActionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Recommended actions'**
  String get childSafety_recommendedActionsLabel;

  /// No description provided for @childSafety_navigateToLocation.
  ///
  /// In en, this message translates to:
  /// **'Navigate to Location'**
  String get childSafety_navigateToLocation;

  /// No description provided for @childSafety_shareLocation.
  ///
  /// In en, this message translates to:
  /// **'Share Location'**
  String get childSafety_shareLocation;

  /// No description provided for @childSafety_contactEmergencySupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Emergency Support'**
  String get childSafety_contactEmergencySupport;

  /// No description provided for @childSafety_alertSummaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Alert summary'**
  String get childSafety_alertSummaryLabel;

  /// No description provided for @childAlert_locationSectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get childAlert_locationSectionLabel;

  /// No description provided for @trip_stop1Title.
  ///
  /// In en, this message translates to:
  /// **'Fan Zone Warm-up'**
  String get trip_stop1Title;

  /// No description provided for @trip_stop1Sub.
  ///
  /// In en, this message translates to:
  /// **'Jersey meet-up · 6 min walk'**
  String get trip_stop1Sub;

  /// No description provided for @trip_stop2Title.
  ///
  /// In en, this message translates to:
  /// **'Jordan vs Spain'**
  String get trip_stop2Title;

  /// No description provided for @trip_stop2Sub.
  ///
  /// In en, this message translates to:
  /// **'Kickoff · Public screening'**
  String get trip_stop2Sub;

  /// No description provided for @trip_stop2Note.
  ///
  /// In en, this message translates to:
  /// **'Leave home by 5:40 — roads near the stadium fill up fast before kickoff.'**
  String get trip_stop2Note;

  /// No description provided for @trip_stop3Title.
  ///
  /// In en, this message translates to:
  /// **'Riverside Art Walk'**
  String get trip_stop3Title;

  /// No description provided for @trip_stop3Sub.
  ///
  /// In en, this message translates to:
  /// **'Live sketching · 10 min walk'**
  String get trip_stop3Sub;

  /// No description provided for @trip_stop4Title.
  ///
  /// In en, this message translates to:
  /// **'Quiet Garden Lounge'**
  String get trip_stop4Title;

  /// No description provided for @trip_stop4Sub.
  ///
  /// In en, this message translates to:
  /// **'Seated · 5 min walk'**
  String get trip_stop4Sub;

  /// No description provided for @rewards_ga1Label.
  ///
  /// In en, this message translates to:
  /// **'Walked instead of driving'**
  String get rewards_ga1Label;

  /// No description provided for @rewards_ga1Source.
  ///
  /// In en, this message translates to:
  /// **'Live Map'**
  String get rewards_ga1Source;

  /// No description provided for @rewards_ga2Label.
  ///
  /// In en, this message translates to:
  /// **'Used shared transport'**
  String get rewards_ga2Label;

  /// No description provided for @rewards_ga3Label.
  ///
  /// In en, this message translates to:
  /// **'Skipped a private car trip'**
  String get rewards_ga3Label;

  /// No description provided for @rewards_ga3Source.
  ///
  /// In en, this message translates to:
  /// **'Smart Parking Sync'**
  String get rewards_ga3Source;

  /// No description provided for @rewards_greenInfoFact.
  ///
  /// In en, this message translates to:
  /// **'Walking short distances is generally linked to improved mood.'**
  String get rewards_greenInfoFact;

  /// No description provided for @rewards_m1Label.
  ///
  /// In en, this message translates to:
  /// **'Report a violation'**
  String get rewards_m1Label;

  /// No description provided for @rewards_m2Label.
  ///
  /// In en, this message translates to:
  /// **'Keep a 7-day streak'**
  String get rewards_m2Label;

  /// No description provided for @rewards_m3Label.
  ///
  /// In en, this message translates to:
  /// **'Refer a friend'**
  String get rewards_m3Label;

  /// No description provided for @rewards_m4Label.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile'**
  String get rewards_m4Label;

  /// No description provided for @rewards_r1Title.
  ///
  /// In en, this message translates to:
  /// **'Free coffee'**
  String get rewards_r1Title;

  /// No description provided for @rewards_r1Desc.
  ///
  /// In en, this message translates to:
  /// **'One free hot or cold drink, any size, at participating cafés.'**
  String get rewards_r1Desc;

  /// No description provided for @rewards_r2Title.
  ///
  /// In en, this message translates to:
  /// **'Priority parking spot'**
  String get rewards_r2Title;

  /// No description provided for @rewards_r2Desc.
  ///
  /// In en, this message translates to:
  /// **'Reserved parking for a full day at participating downtown lots.'**
  String get rewards_r2Desc;

  /// No description provided for @rewards_r3Title.
  ///
  /// In en, this message translates to:
  /// **'Gallery pass'**
  String get rewards_r3Title;

  /// No description provided for @rewards_r3Desc.
  ///
  /// In en, this message translates to:
  /// **'Full-day entry for two to the National Gallery\'s current exhibition.'**
  String get rewards_r3Desc;

  /// No description provided for @rewards_v1Title.
  ///
  /// In en, this message translates to:
  /// **'Free Drink'**
  String get rewards_v1Title;

  /// No description provided for @rewards_v1Desc.
  ///
  /// In en, this message translates to:
  /// **'One free hot or cold beverage.'**
  String get rewards_v1Desc;

  /// No description provided for @rewards_v1Expiry.
  ///
  /// In en, this message translates to:
  /// **'Expires 15 Aug'**
  String get rewards_v1Expiry;

  /// No description provided for @rewards_v2Title.
  ///
  /// In en, this message translates to:
  /// **'20% Merch Discount'**
  String get rewards_v2Title;

  /// No description provided for @rewards_v2Desc.
  ///
  /// In en, this message translates to:
  /// **'Off official team merchandise.'**
  String get rewards_v2Desc;

  /// No description provided for @rewards_v2Expiry.
  ///
  /// In en, this message translates to:
  /// **'Expires 30 Sep'**
  String get rewards_v2Expiry;

  /// No description provided for @rewards_v3Title.
  ///
  /// In en, this message translates to:
  /// **'Food Combo'**
  String get rewards_v3Title;

  /// No description provided for @rewards_v3Desc.
  ///
  /// In en, this message translates to:
  /// **'Combo meal at the food court.'**
  String get rewards_v3Desc;

  /// No description provided for @rewards_v3Expiry.
  ///
  /// In en, this message translates to:
  /// **'Expires 10 Oct'**
  String get rewards_v3Expiry;

  /// No description provided for @rewards_boardRankLabel.
  ///
  /// In en, this message translates to:
  /// **'You\'re #3 in AMRA'**
  String get rewards_boardRankLabel;

  /// No description provided for @rewards_boardSubLabel.
  ///
  /// In en, this message translates to:
  /// **'260 points to reach #2'**
  String get rewards_boardSubLabel;

  /// No description provided for @rewards_leaderboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get rewards_leaderboardTitle;

  /// No description provided for @rewards_leaderboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Amman, this month'**
  String get rewards_leaderboardSubtitle;

  /// No description provided for @rewards_h1Label.
  ///
  /// In en, this message translates to:
  /// **'Reported a violation'**
  String get rewards_h1Label;

  /// No description provided for @rewards_h2Label.
  ///
  /// In en, this message translates to:
  /// **'Daily streak bonus'**
  String get rewards_h2Label;

  /// No description provided for @rewards_h3Label.
  ///
  /// In en, this message translates to:
  /// **'Redeemed: Free coffee'**
  String get rewards_h3Label;

  /// No description provided for @rewards_h4Label.
  ///
  /// In en, this message translates to:
  /// **'Referred a friend'**
  String get rewards_h4Label;

  /// No description provided for @rewards_todayLabel.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get rewards_todayLabel;

  /// No description provided for @rewards_yesterdayLabel.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get rewards_yesterdayLabel;

  /// No description provided for @rewards_daysAgoLabel.
  ///
  /// In en, this message translates to:
  /// **'3 days ago'**
  String get rewards_daysAgoLabel;

  /// No description provided for @rewards_matchAttendance.
  ///
  /// In en, this message translates to:
  /// **'Match Attendance'**
  String get rewards_matchAttendance;

  /// No description provided for @rewards_qrCheckIn.
  ///
  /// In en, this message translates to:
  /// **'QR Check-in'**
  String get rewards_qrCheckIn;

  /// No description provided for @rewards_convertedGreenPoints.
  ///
  /// In en, this message translates to:
  /// **'Converted Green points'**
  String get rewards_convertedGreenPoints;

  /// No description provided for @rewards_recommendationCopy.
  ///
  /// In en, this message translates to:
  /// **'You have enough points to redeem a Free Drink Coupon.'**
  String get rewards_recommendationCopy;

  /// No description provided for @rewards_achievementTitle.
  ///
  /// In en, this message translates to:
  /// **'Stadium Explorer'**
  String get rewards_achievementTitle;

  /// No description provided for @rewards_achievementSub.
  ///
  /// In en, this message translates to:
  /// **'Visited every stadium zone during your visit.'**
  String get rewards_achievementSub;

  /// No description provided for @rewards_greenLevelSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Green level'**
  String get rewards_greenLevelSheetTitle;

  /// No description provided for @rewards_greenLevelSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Based on your trips across the app'**
  String get rewards_greenLevelSheetSubtitle;

  /// No description provided for @rewards_historySheetTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get rewards_historySheetTitle;

  /// No description provided for @rewards_historySheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Every point, tracked.'**
  String get rewards_historySheetSubtitle;

  /// No description provided for @rewards_missionsSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Missions'**
  String get rewards_missionsSheetTitle;

  /// No description provided for @rewards_missionsSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Simple actions that keep you compliant — and earn points.'**
  String get rewards_missionsSheetSubtitle;

  /// No description provided for @rewards_pointMultiplier.
  ///
  /// In en, this message translates to:
  /// **'Point multiplier'**
  String get rewards_pointMultiplier;

  /// No description provided for @rewards_monthlyBonusReward.
  ///
  /// In en, this message translates to:
  /// **'Monthly bonus reward'**
  String get rewards_monthlyBonusReward;

  /// No description provided for @rewards_prioritySupport.
  ///
  /// In en, this message translates to:
  /// **'Priority support'**
  String get rewards_prioritySupport;

  /// No description provided for @rewards_freeReward.
  ///
  /// In en, this message translates to:
  /// **'Free reward'**
  String get rewards_freeReward;

  /// No description provided for @rewards_included.
  ///
  /// In en, this message translates to:
  /// **'Included'**
  String get rewards_included;

  /// No description provided for @rewards_availableLocations.
  ///
  /// In en, this message translates to:
  /// **'Available at 6 locations in Amman'**
  String get rewards_availableLocations;

  /// No description provided for @rewards_valid30Days.
  ///
  /// In en, this message translates to:
  /// **'Valid 30 days'**
  String get rewards_valid30Days;

  /// No description provided for @rewards_earnMorePoints.
  ///
  /// In en, this message translates to:
  /// **'Earn more points'**
  String get rewards_earnMorePoints;

  /// No description provided for @rewards_recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get rewards_recentActivity;

  /// No description provided for @rewards_yourVouchers.
  ///
  /// In en, this message translates to:
  /// **'Your Vouchers'**
  String get rewards_yourVouchers;

  /// No description provided for @rewards_redeemYourPoints.
  ///
  /// In en, this message translates to:
  /// **'Redeem your points'**
  String get rewards_redeemYourPoints;

  /// No description provided for @rewards_levelAware.
  ///
  /// In en, this message translates to:
  /// **'Aware'**
  String get rewards_levelAware;

  /// No description provided for @rewards_levelActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get rewards_levelActive;

  /// No description provided for @rewards_levelGreenGuardian.
  ///
  /// In en, this message translates to:
  /// **'Green Guardian'**
  String get rewards_levelGreenGuardian;

  /// No description provided for @rewards_lbName1.
  ///
  /// In en, this message translates to:
  /// **'Lina M.'**
  String get rewards_lbName1;

  /// No description provided for @rewards_lbName2.
  ///
  /// In en, this message translates to:
  /// **'Omar T.'**
  String get rewards_lbName2;

  /// No description provided for @rewards_lbName3.
  ///
  /// In en, this message translates to:
  /// **'Sara K.'**
  String get rewards_lbName3;

  /// No description provided for @rewards_lbName4.
  ///
  /// In en, this message translates to:
  /// **'Yousef A.'**
  String get rewards_lbName4;

  /// No description provided for @rewards_greeting.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get rewards_greeting;

  /// No description provided for @rewards_goldTierLabel.
  ///
  /// In en, this message translates to:
  /// **'Gold tier'**
  String get rewards_goldTierLabel;

  /// No description provided for @rewards_silverMemberName.
  ///
  /// In en, this message translates to:
  /// **'Silver Member'**
  String get rewards_silverMemberName;

  /// No description provided for @rewards_goldMemberName.
  ///
  /// In en, this message translates to:
  /// **'Gold Member'**
  String get rewards_goldMemberName;

  /// No description provided for @rewards_pointsLockedSuffix.
  ///
  /// In en, this message translates to:
  /// **'{points} points{locked}'**
  String rewards_pointsLockedSuffix(String locked, String points);

  /// No description provided for @rewards_lockedSuffix.
  ///
  /// In en, this message translates to:
  /// **' · locked'**
  String get rewards_lockedSuffix;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
