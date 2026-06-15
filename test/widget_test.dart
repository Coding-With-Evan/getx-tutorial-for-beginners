import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:getx_tutorial/main.dart';

void main() {
  tearDown(Get.reset);

  testWidgets('GetX tutorial demo increments the reactive counter', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GetXDemoApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('GetX Tutorial Demo'), findsOneWidget);

    await tester.tap(find.byKey(const Key('incrementCounterButton')));
    await tester.pump();

    final counterText = tester.widget<Text>(
      find.byKey(const Key('counterText')),
    );
    expect(counterText.data, '1');
  });

  testWidgets('Cart updates through a Get.find dependency', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GetXDemoApp());

    await tester.scrollUntilVisible(
      find.text('Cart items: 0'),
      400,
      scrollable: find.byType(Scrollable),
    );
    expect(find.text('Cart items: 0'), findsOneWidget);

    await tester.tap(find.widgetWithIcon(IconButton, Icons.add).first);
    await tester.pump();

    expect(find.text('Cart items: 1'), findsOneWidget);
    expect(find.text(r'Total: $9.00'), findsOneWidget);
  });

  testWidgets('Named route receives arguments', (WidgetTester tester) async {
    await tester.pumpWidget(const GetXDemoApp());

    await tester.scrollUntilVisible(
      find.byKey(const Key('openDetailsButton')),
      400,
      scrollable: find.byType(Scrollable),
    );
    await tester.tap(find.byKey(const Key('openDetailsButton')));
    await tester.pumpAndSettle();

    expect(find.text('GetX Named Routes'), findsOneWidget);
    expect(
      find.text('This screen received data using Get.arguments.'),
      findsOneWidget,
    );
  });
}
