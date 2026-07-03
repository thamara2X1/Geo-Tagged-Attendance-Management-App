// Smoke test for the Geo-Tagged Attendance app.
//
// Verifies the Home screen renders with the employee name and both
// attendance action buttons in their correct initial state.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:geo_attendance_app/main.dart';
import 'package:geo_attendance_app/utils/constants.dart';

void main() {
  testWidgets('Home screen renders name and attendance buttons',
      (WidgetTester tester) async {
    // MyApp uses Riverpod, so it must be wrapped in a ProviderScope.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Employee name is shown.
    expect(find.text(AppConstants.employeeName), findsOneWidget);

    // Both action buttons are present.
    expect(find.text('Check In'), findsOneWidget);
    expect(find.text('Check Out'), findsOneWidget);

    // Initial status is "Checked Out".
    expect(find.text('Checked Out'), findsOneWidget);
  });
}