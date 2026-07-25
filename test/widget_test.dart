// Smoke test: the app should start on the "Building Smart Posts" loader
// and show its title and first checklist step immediately.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:assignment/main.dart';

void main() {
  testWidgets('App boots into the Building Smart Posts loader', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const QuickShareApp());
    await tester.pump();

    expect(find.textContaining('Building personalised'), findsOneWidget);
    expect(find.text('Preparing popular content for you'), findsOneWidget);
  });
}
