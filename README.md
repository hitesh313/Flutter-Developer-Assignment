# Oriflame Smart Post — Flutter Developer Assignment

A Flutter build of the **Oriflame "Smart Posts" feature** from the Brandie
take-home assignment: an AI assistant that builds a ready-to-share,
reel-style product post — complete with a suggested caption, referral
link, trending song, and one-tap sharing to social apps.

Built directly against the Figma screenshots shared for this assignment
(the "Smart Posts Feature" file), including the later annotation pass
covering paging behaviour, tab structure, theming, and local storage.

## The flow

1. **Building Smart Posts** — an animated checklist while the AI puts
   the post together. Follows the device's light/dark setting
   automatically (see Theming below) — this is the exact frame the
   Figma file designs for both modes.
2. **Smart Post feed** — a full-bleed, reel-style card. A ~2 second
   skeleton placeholder shows first, then the real post fades in. You
   can then swipe through the 3 posts vertically and, from any post,
   swipe horizontally to switch to Library / Communities / Share&Win
   (only Smart Post has a real design, so those show a "You're on the
   ___ page" placeholder — tap the tab or swipe back to return). See
   **Paging** below for how the swiping itself works.
3. **Edit Caption** — tapping the caption opens a full-screen editor
   that grabs the keyboard immediately; Save only lights up once the
   text actually changes. Edits are saved locally and survive an app
   restart.
4. **Quick share** — tapping a destination icon runs the 4-step
   progress sequence from the Figma loading panel, then a brief
   "Opening Instagram…"-style hand-off before closing.

## Paging: one step per swipe

Both the horizontal tab switch and the vertical post scroll are driven
by one reusable widget, `OneAtATimePager` (`lib/widgets/one_at_a_time_pager.dart`).
It measures a swipe only at the moment the gesture ends and advances
**exactly one index**, regardless of how fast or far the finger moved —
a hard, fast fling still only moves one post/tab, not several. A short
lock while the transition animates means a rapid string of swipes gets
processed one at a time instead of all firing at once. The same
controller (`OneAtATimePagerController`) also lets a tap — e.g. on a
tab label — jump directly to an index outside of a swipe.

## Theming: follows the device automatically

`MaterialApp` is configured with `themeMode: ThemeMode.system`, plus a
`light` and `dark` `ThemeData` in `lib/theme/app_theme.dart` — there's no
manual switch anywhere. If the phone/simulator is in dark mode, the app
opens in dark mode; toggling system dark mode while the app is open
updates it live, no restart needed. To test this in a simulator: iOS
Simulator → Settings → Developer → Dark Appearance; Android emulator →
Settings → Display → Dark theme.

Only the app's own **chrome** (nav bars, backgrounds, the caption
editor, the building-loader screen, tab placeholders, skeletons) shifts
between light and dark, via `AppPalette` / `paletteOf(context)`. Content
drawn **on top of a post's photo** (the "Ready to share" badge, caption
text, quick-share icons) stays white-on-scrim in both modes — this
matches how photo content behaves in real social apps (an Instagram
photo doesn't invert when your phone switches to dark mode; only the
surrounding app UI does), and the Figma file itself doesn't show a
dark variant of the photo card, only of the loader screen.

## Local storage

`lib/services/caption_storage_service.dart` wraps `shared_preferences`
to persist two things between app runs:
- any caption you've edited, per post
- which post you were last viewing, so re-opening the app resumes there

Nothing else is persisted — everything else in the demo is intentionally
ephemeral, per the brief's steer toward hardcoded data over real backend
work.

## Getting started

```bash
git clone https://github.com/hitesh313/Flutter-Developer-Assignment.git
cd Flutter-Developer-Assignment
flutter pub get
flutter run
```

## Project structure

```
lib/
├── main.dart                          # Entry point, ThemeMode.system wiring
├── theme/
│   └── app_theme.dart                 # Brand colors, AppPalette (light/dark), text styles
├── models/
│   └── smart_post.dart                # SmartPost, QuickShareApp
├── data/
│   └── demo_data.dart                 # The 3 hardcoded posts + step copy
├── services/
│   └── caption_storage_service.dart   # shared_preferences wrapper
├── widgets/
│   ├── one_at_a_time_pager.dart       # Reusable single-step swipe pager (both axes)
│   ├── top_nav_bar.dart               # Assistant / logo / camera + interactive tabs
│   ├── bottom_nav_bar.dart
│   ├── badges_and_dots.dart           # "Ready to share" badge, page dots
│   ├── post_page.dart                 # One full-bleed post (photo + overlays)
│   ├── product_overlay_card.dart      # Delayed-fade-in product card
│   ├── caption_block.dart             # Song line, caption, See more
│   ├── quick_share_row.dart
│   ├── share_progress_dialog.dart     # 4-step share sequence + hand-off
│   ├── skeleton_box.dart              # Reusable shimmer primitive
│   └── skeleton_post_card.dart        # Post-shaped skeleton built from it
└── screens/
    ├── building_smart_posts_screen.dart  # Animated checklist loader
    ├── root_shell.dart                   # Top/bottom nav + horizontal tab pager
    ├── smart_post_feed.dart              # Skeleton + vertical post pager + persistence
    ├── placeholder_tab_page.dart         # Library / Communities / Share&Win stand-in
    └── edit_caption_screen.dart          # Full-screen caption editor
```

## Assumptions & decisions

- **No real photography exists for this demo**, so each post uses a
  gradient placeholder with a hero icon instead of the actual product
  photo. Swap in real images by replacing the background `Container` in
  `post_page.dart` with an `Image` / `DecorationImage`.
- **Post copy is exactly what's in the Figma frames** — the three posts
  (Giordani Gold Lipstick / Eclat Amour / WonderLash Mascara), their
  captions, hashtags, referral codes, and recommended songs are pulled
  straight from the screenshots, not invented.
- **"Show 3 posts, user can scroll like reels"** → vertical swipe within
  Smart Post. **Horizontal swipe** was my interpretation for moving
  between the top-level Smart Post / Library / Communities / Share&Win
  tabs, since the Figma only fully designs Smart Post — the other three
  needed *something* to show.
- **Product card tap and "Quick share" tap** both show a snackbar /
  hand-off animation instead of a real deep link or share intent, since
  there's no real store or social API to hand off to in a demo.
- **"Quick share to" icons**: the row shows two Instagram-style and two
  Facebook-style icons side by side — read as separate Feed/Story
  destinations for each rather than duplicates.
- **Caption edit gating**: Save stays visually disabled until the text
  differs from the original, per the annotation "Enable Save button
  when a change is made."

## What I'd do differently with more time

- Swap placeholder gradients for the real product photography.
- Wire the share icons to real `share_plus` intents instead of a demo
  snackbar.
- Add haptic feedback on the product card reveal and share completion.
- Persist which top-level tab the user was on too, not just the post.
