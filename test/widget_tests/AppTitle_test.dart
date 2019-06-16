import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lg_controller/src/menu/FlyToMenu.dart';
import 'package:lg_controller/src/ui/AppTitle.dart';

void main() {
  testWidgets('App title component check', (WidgetTester tester) async {
    Widget root = new AppTitle();
    await tester.pumpWidget(new MaterialApp(home: root));

    initialState();

    await tester.longPress(find.byWidget(root));
    await tester.pump();
    expect(find.text('Fly To'), findsOneWidget);
    await tester.pump();
    initialState();

    for (var ic in FlyToMenu.values()) {
      await tester.tap(find.text('LG Controller'));
      await tester.pumpAndSettle();
      expect(find.byType(CircleAvatar), findsNWidgets(5));
      await tester.tap(find.descendant(
          of: find.byType(AlertDialog),
          matching: find.byKey(Key('AppTitle_items_' + ic.title))));
      await tester.pumpAndSettle();
      initialState();
    }
  });
}

initialState() {
  expect(find.text('LG Controller'), findsOneWidget);
  expect(find.byTooltip('Fly To'), findsOneWidget);
  expect(find.byType(CircleAvatar), findsOneWidget);
}
