import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:playground/app/app.dart';

void main() {
  testWidgets('theme switch toggles without late initialization errors', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Profile Page'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}
