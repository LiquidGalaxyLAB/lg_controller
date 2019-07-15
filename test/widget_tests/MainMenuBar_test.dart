import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/ui/MainMenuBar.dart';

void main() {
  for (var ic in MainMenu.values()) {
    testWidgets('Main menu bar ' + ic.title + ' component check',
        (WidgetTester tester) async {
      Widget root = new MainMenuBar(ic);
      await tester.pumpWidget(new Material(child: new MaterialApp(home: root)));

      await tester.pumpAndSettle();

      checkAll();

      Row row = find.byType(Row).evaluate().toList()[0].widget;
      expect(row.children.length, 5);
      int i = 0;
      for (var ic2 in MainMenu.values()) {
        Column c = row.children[i];
        expect(
            find.descendant(
                of: find.byWidget(c), matching: find.byType(Container)),
            findsNWidgets(3));
        if (ic2 == ic)
          checkUnderline(c);
        else
          checkNoUnderline(c);
        i++;
      }
    });
  }
}

checkAll() {
  for (var ic in MainMenu.values()) {
    expect(find.text(ic.title), findsOneWidget);
  }
}

checkUnderline(Column c) {
  expect(find.descendant(of: find.byWidget(c), matching: find.byType(Hero)),
      findsNWidgets(2));
  Container underline = (c.children[1] as Hero).child;
  expect((underline.decoration as BoxDecoration).color, Colors.white);
}

checkNoUnderline(Column c) {
  expect(find.descendant(of: find.byWidget(c), matching: find.byType(Hero)),
      findsOneWidget);
}
