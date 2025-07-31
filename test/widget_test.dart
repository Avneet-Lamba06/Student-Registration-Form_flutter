// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:student_registration_app/main.dart';
// Ensure that main.dart defines a class named MyApp and it is exported.

void main() {
  testWidgets('StudentApp renders registration form', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(StudentApp());

    // Verify that the registration form fields are present
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Age'), findsOneWidget);
    expect(find.text('Contact'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
  });
}
