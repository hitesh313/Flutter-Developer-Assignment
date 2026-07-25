# Quick Share — Flutter Developer Assignment

A single-page Flutter UI for quickly sharing a post: preview the content,
tap contacts to send it to directly, pick an app to share via, or copy
the link. Built for the Brandie Flutter Developer take-home assignment.

## ⚠️ Important note on the Figma reference

This build was **not** created by viewing the actual Figma file — the
design tool used to generate this repo could not open the linked Figma
project (it requires an authenticated, JS-rendered session). Instead,
this is a from-scratch interpretation of a "Quick Share" feature based
on the feature name and common share-sheet patterns.

**Before you submit, compare this against the real Figma file** at
https://www.figma.com/design/pba5xdsRMWFWWtxThfAnnw/Quick-share-feature
and adjust colors, spacing, copy, and layout to match. Treat this repo
as a strong structural starting point, not a pixel-accurate implementation.

## Getting started

```bash
git clone https://github.com/hitesh313/Flutter-Developer-Assignment.git
cd Flutter-Developer-Assignment
flutter pub get
flutter run
```

No backend or API setup needed — everything renders from hardcoded data
in `lib/data/demo_data.dart`.

## Project structure

```
lib/
├── main.dart                    # App entry point, theme wiring
├── theme/
│   └── app_theme.dart           # Colors, spacing, text styles, ThemeData
├── models/
│   └── share_models.dart        # ShareContact, ShareDestination, SharePost
├── data/
│   └── demo_data.dart           # Hardcoded demo content (no backend/API)
├── widgets/
│   ├── post_preview_card.dart   # Preview of the post being shared
│   ├── contact_avatar.dart      # Selectable contact avatar + online dot
│   ├── destination_tile.dart    # App icon tile in the share grid
│   └── copy_link_row.dart       # Copy-link pill with tap feedback
└── screens/
    └── quick_share_screen.dart  # Assembles the single-page UI
```

Separation of concerns: theming, data models, hardcoded content, and UI
widgets each live in their own layer, and `quick_share_screen.dart` only
composes widgets — no inline styling or business logic buried in the
widget tree.

## Assumptions & decisions made

- **Content**: no real post/social data existed, so `data/demo_data.dart`
  hardcodes one sample post, 6 contacts, and 6 share destinations —
  matching the brief's suggestion to skip backend work and demo with
  static values.
- **Interaction model**: tapping a contact avatar toggles a selection
  state (checkmark badge) rather than sharing immediately, so multiple
  people can be picked before confirming — this felt like the more
  realistic "quick share" flow. The bottom button is disabled until at
  least one contact is selected.
- **Destination taps**: tapping a "Share via" app or the send button
  shows a snackbar instead of actually invoking a share intent, since
  there's no real content to hand off to another app in a demo build.
- **Copy link**: tapping "Copy" writes to the real clipboard
  (`Clipboard.setData`) and shows brief "Copied" feedback — a small
  UX touch not specified in the brief.
- **Responsiveness**: the content column is constrained to a max width
  of 480px on wide screens (tablet/web) and centered, so the layout
  doesn't stretch awkwardly on larger viewports while still filling
  phone-width screens edge to edge.

## What I'd do differently with more time

- Pull the real Figma frame and match exact spacing, corner radii, and
  color values instead of the placeholder palette used here.
- Add a search bar to filter contacts.
- Animate the bottom sheet entrance if this is dropped into a modal
  presentation instead of a full screen.
