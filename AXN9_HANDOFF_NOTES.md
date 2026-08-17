# AXN9 — Localization completion handoff notes

Continuation of AXN8_2 / AXN9. This pass closed out every remaining
hardcoded-text gap found across the app after a full multi-line-aware
sweep of all 54 Dart files.

## What this pass added (on top of the previous AXN9 pass)

- `safty_dev_screen.dart` — localized the entire `ChildSafetyData` class
  (58 strings: profile card, live location, safety zone, activity
  timeline, quick actions, resolved-alert summary, recommended-actions
  grid) plus one leftover "Location" section label. Converted from
  `static const` fields to methods taking a translator function.
- `find_my_car_screen.dart` — was missing the `AppScope` import entirely;
  localized all 9 strings (title, walkback button, saved-slot card,
  compass tracking) and fixed its back arrow to mirror in RTL.
- `evacuation_screen.dart` — was missing `AppScope`; localized all 5
  strings.
- `create_group_flow_screen.dart` — was missing `AppScope`; localized 13
  strings (group-type picker, phone/ID/OTP steps) plus the 2 default
  group-name strings written into new group records.
- `sos_screen.dart` (the main press-and-hold SOS screen — separate from
  the confirmation screen done in the previous pass) — was missing
  `AppScope` entirely; localized all 27 strings (header, 6 service
  names, 3 emergency contacts, location card, settings sheet).
- `rewards_screen.dart` — the big one. Localized the *entire*
  `RewardsData` mock-content model: green achievements, missions,
  redeemable rewards, vouchers, leaderboard names, history/recent
  activity entries, tier-comparison table, section headers, sheet
  titles, greeting text, tier labels — about 90 strings in total across
  two passes. Converted a dozen `static const` fields/lists into methods
  taking a translator function, and updated every call site.

## Full ARB key count

711 keys, EN and AR fully symmetric. Every key has a matching
`AppLocalizations` getter (abstract + en + ar) and an `I18n.t()` switch
case — verified by script after every batch, zero gaps at the end.

## Final full-repo sweep result

A multi-line-aware regex sweep across all 54 `.dart` files for any
remaining `Text('...')`, `label:`, `title:`, `subtitle:`, `hintText:`,
`placeholder:` string literals returns only:
- Pure numeric/interpolated values with no translatable words
  (`'$points'`, `'${entry.points}'`, `'${achievement.count}×'`, compass
  heading degrees) — correct to leave as-is, satisfies the "Latin
  numerals" requirement automatically.
- `trip_screen.dart`'s `CategoryDef.label` field and the initial
  `const` fallback values in its `_stops` list — both intentionally
  left as literal English fallbacks; the actual rendered values come
  from `labelKey`/a `didChangeDependencies` translation pass
  respectively, confirmed by tracing every call site.
- Brand lockups left untranslated on purpose, consistent across the
  app: "AXN", "AXN SAFETY", "AMRA EXCHANGE NEXUS", "SOS", "OTP", "GPS".

## Verified again in this pass (no changes needed)

- Balance check (braces/parens/brackets) on every one of the 54 Dart
  files — all clean.
- Language persistence, first-launch device-locale detection, and the
  Settings-screen language switch — unchanged, already correct.
- Fonts (El Messiri / IBM Plex Sans Arabic / IBM Plex Mono) — unchanged,
  already correct.

## Could not verify in this environment

Still true from the previous notes: no Flutter SDK or network access
here, so `flutter analyze`, `flutter pub get`, `flutter gen-l10n`,
`flutter test`, and any actual on-device RTL/text-overflow check could
not be run. All verification in this pass was static: ARB/getter/switch
cross-referencing via script, and brace/paren/bracket balance checks.

**Before shipping, run `flutter analyze` and `flutter gen-l10n`, and do
a manual pass through each screen in both languages** — especially the
text-length/overflow review, which genuinely can't be judged without
rendering the UI.
