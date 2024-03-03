// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bacon_bringer/ui/home/view_model/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bacon_bringer/main.dart';

import 'util.dart';

void main() {
  test('Counter increment on home page', () {
    const testTitle = "title";
    final HomePageViewModel viewModel =
        HomePageViewModel(TestNotifier(), testTitle);
    expect(viewModel.counter, '0');
    viewModel.incrementCounter();
    expect(viewModel.counter, '1');
  });

  testWidgets('can get title on home page', (WidgetTester tester) async {
    const testTitle = "Bacon Bringer";
    await tester.pumpWidget(const BaconBringerApp());
    expect(find.text(testTitle), findsOneWidget);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BaconBringerApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
