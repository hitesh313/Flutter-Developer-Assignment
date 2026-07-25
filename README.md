# Oriflame Smart Post — Flutter Developer Assignment

A Flutter build of the **Oriflame "Smart Posts" feature** from the Brandie
take-home assignment: an AI assistant that builds a ready-to-share,
reel-style product post — complete with a suggested caption, referral
link, trending song, and one-tap sharing to social apps.

This version was built directly against the actual Figma screenshots you
shared (the "Smart Posts Feature" file) — not a guess.

## The flow

1. **Building Smart Posts** — an animated checklist ("Preparing popular
   content for you", "Crafting a caption...", etc.) while the AI puts
   the post together. The Figma file shows this in both light and dark
   variants, so there's a toggle in the corner to preview both.
2. **Smart Post feed** — a full-bleed, reel-style card you can swipe
   through vertically (3 posts, "1 of 3" / "2 of 3" / "3 of 3"), each
   with:
   - Creator avatar + "Ready to share" badge
   - A product card that **fades in ~3 seconds** after the post is
     viewed (per the Figma annotation) and is tappable
   - A recommended-song line
   - An AI "Caption suggestion" with hashtags, referral code/link, and
     a collapsible "See more"
   - A "Quick share to" row (Instagram feed/story, Facebook feed/story,
     Messenger, TikTok)
3. **Edit Caption** — tapping the caption opens a full-screen editor
   that grabs the keyboard immediately; **Save only lights up once the
   text actually changes**, matching the Figma annotation.
4. **Quick share** — tapping a destination icon runs the 4-step
   progress sequence from the Figma loading panel ("Generating your
   sales link" → "Copying the caption to clipboard" → "Saving the
   content to your profile" → "Preparing the content for social
   media"), then a brief "Opening Instagram…"-style hand-off before
   closing.

## Getting started

```bash
git clone https://github.com/hitesh313/Flutter-Developer-Assignment.git
cd Flutter-Developer-Assignment
flutter pub get
flutter run
```

Everything runs on hardcoded demo data in `lib/data/demo_data.dart` — no
backend, per the brief.

## Project structure

```
lib/
├── main.dart                          # Entry point, launches the loader
├── theme/
│   └── app_theme.dart                 # Colors, spacing, text styles
├── models/
│   └── smart_post.dart                # SmartPost, QuickShareApp
├── data/
│   └── demo_data.dart                 # The 3 hardcoded posts + step copy
├── widgets/
│   ├── top_nav_bar.dart               # Assistant / Oriflame logo / camera + tabs
│   ├── bottom_nav_bar.dart
│   ├── badges_and_dots.dart           # "Ready to share" badge, page dots
│   ├── product_overlay_card.dart      # Delayed-fade-in product card
│   ├── caption_block.dart             # Song line, caption, See more
│   ├── quick_share_row.dart
│   └── share_progress_dialog.dart     # 4-step share sequence + hand-off
└── screens/
    ├── building_smart_posts_screen.dart  # Animated checklist loader
    ├── smart_post_screen.dart            # Main swipeable feed
    └── edit_caption_screen.dart          # Full-screen caption editor
```

## Assumptions & decisions

- **No real photography exists for this demo**, so each post uses a
  gradient placeholder with a hero icon instead of the actual product
  photo. Swap in real images by replacing the `Container` in
  `_PostPage`'s background with an `Image` / `DecorationImage`.
- **Post copy is exactly what's in the Figma frames** — the three posts
  (Giordani Gold Lipstick / Eclat Amour / WonderLash Mascara), their
  captions, hashtags, referral codes, and recommended songs are pulled
  straight from the screenshots, not invented.
- **Swipe direction**: the Figma note says "user can scroll like
  reels", so the feed is a vertical `PageView`, matching short-form
  video conventions rather than a horizontal carousel.
- **Product card tap and "Quick share" tap** both show a snackbar /
  hand-off animation instead of a real deep link or share intent,
  since there's no real store or social API to hand off to in a demo.
- **"Quick share to" icons**: the Figma row shows two Instagram-style
  icons and two Facebook-style icons side by side, which reads as
  separate Feed/Story destinations for each — I labelled them
  accordingly (`Instagram Feed` / `Instagram Story`, etc.) rather than
  guessing they were duplicates.
- **Caption edit gating**: Save stays visually disabled until the text
  differs from the original, per the annotation "Enable Save button
  when a change is made."

## What I'd do differently with more time

- Swap placeholder gradients for the real product photography.
- Persist edited captions per-post across app restarts.
- Add haptic feedback on the product card reveal and share completion.
- Wire the share icons to real `share_plus` intents instead of a demo
  snackbar.
