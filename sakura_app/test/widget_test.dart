// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:sakura_app/app.dart';
import 'package:sakura_app/features/onboarding/presentation/screens/phone_login_screen.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const OnboardingApp());

    // Verify that the first screen of the onboarding is rendered.
    // This is a placeholder test.
    expect(find.byType(PhoneLoginScreen), findsOneWidget);
  });
}
