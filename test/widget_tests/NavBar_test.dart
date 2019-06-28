import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lg_controller/src/blocs/NavBarBloc.dart';
import 'package:lg_controller/src/menu/NavBarMenu.dart';
import 'package:lg_controller/src/ui/NavBar.dart';

void main() {
  for (var ic in NavBarMenu.values()) {
    testWidgets('Nav menu bar ' + ic.title + ' component check',
        (WidgetTester tester) async {
      Widget root = BlocProviderTree(
        blocProviders: [
          BlocProvider<NavBarBloc>(bloc: new NavBarBloc()),
        ],
        child: new NavBar(),
      );
      await tester.pumpWidget(
          new Material(child: new MaterialApp(theme: testTheme(), home: root)));

      await tester.pumpAndSettle();

      checkAll();
      expect(find.text("CATEGORIES : "), findsOneWidget);
      expect(find.byType(Divider), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      Column col = find.byType(Column).evaluate().toList()[1].widget;
      expect(col.children.length, 12);
      int i = 0;
      for (var ic_tap in NavBarMenu.values()) {
        GestureDetector option = (col.children[i] as Column).children[0];
        await tester.tap(find.byWidget(option));
        await tester.pumpAndSettle();
        Text selected = find
            .descendant(of: find.byWidget(option), matching: find.byType(Text))
            .evaluate()
            .toList()[0]
            .widget;
        expect(selected.style.fontSize, testTheme().textTheme.body2.fontSize);
        int j = 0;
        for (var ic_plain in NavBarMenu.values()) {
          if (ic_tap != ic_plain) {
            GestureDetector unselect = (col.children[j] as Column).children[0];
            Text selected = find
                .descendant(
                    of: find.byWidget(unselect), matching: find.byType(Text))
                .evaluate()
                .toList()[0]
                .widget;
            expect(
                selected.style.fontSize, testTheme().textTheme.body1.fontSize);
          }
          j=j+2;
        }
        i=i+2;
      }
    });
  }
}

checkAll() {
  for (var ic in NavBarMenu.values()) {
    expect(find.text(ic.title), findsOneWidget);
  }
}

ThemeData testTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    cardColor: Colors.white,
    iconTheme: new IconThemeData(
      color: Colors.white,
      opacity: 1.0,
    ),
    fontFamily: 'RobotoMono',
    textTheme: TextTheme(
      headline: TextStyle(
          fontSize: 34, color: Colors.white, fontWeight: FontWeight.bold),
      title: TextStyle(
          fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold),
      body1: TextStyle(fontSize: 12, color: Colors.white),
      body2: TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
