// This is a basic Flutter widget test for Quiz Iradat app.

import 'package:flutter_test/flutter_test.dart';

import 'package:quiz_iradat/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app starts with the onboarding screen.
    // We expect to find the Quiz Iradat title
    expect(find.text('Welcome to Quiz Iradat'), findsOneWidget);
  });
}
