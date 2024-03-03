// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:bacon_bringer/main.dart';

void main() {
  testWidgets('ホーム画面でタイトルが表示されていること', (WidgetTester tester) async {
    const testTitle = "Bacon Bringer";
    await tester.pumpWidget(const BaconBringerApp());
    expect(find.text(testTitle), findsOneWidget);
  });

  testWidgets('ホーム画面で月間収支概要が表示されていること', (WidgetTester tester) async {
    await tester.pumpWidget(const BaconBringerApp());
    expect(find.text("合計"), findsOneWidget);
    expect(find.text("100000"), findsOneWidget);
  });
}
