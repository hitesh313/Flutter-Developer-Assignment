// Basic smoke test for the Quick Share screen.
//
// Verifies the screen renders its core sections and that selecting a
// contact enables the bottom "Send" button.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:assignment/main.dart';

void main() {
  testWidgets('Quick Share screen renders and contact selection enables send', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const QuickShareApp());

    // Core sections are present.
    expect(find.text('Share'), findsOneWidget);
    expect(find.text('Quick share to'), findsOneWidget);
    expect(find.text('Share via'), findsOneWidget);
    expect(find.text('Or copy link'), findsOneWidget);

    // Send button starts disabled with a prompt label.
    expect(find.text('Select contacts to send'), findsOneWidget);

    // Tapping the first contact avatar selects it and updates the button.
    await tester.tap(find.text('Aarav'));
    await tester.pump();

    expect(find.text('Send to 1 selected'), findsOneWidget);
  });
}
