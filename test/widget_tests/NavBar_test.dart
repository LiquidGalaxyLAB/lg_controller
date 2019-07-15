import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lg_controller/src/blocs/NavBarBloc.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/menu/POINavBarMenu.dart';
import 'package:lg_controller/src/ui/NavBar.dart';

void main() {
  for (var ic in POINavBarMenu.values()) {
    testWidgets('Nav menu bar ' + ic.title + ' component check',
        (WidgetTester tester) async {
      Widget root = BlocProviderTree(
        blocProviders: [
          BlocProvider<NavBarBloc>(bloc: new NavBarBloc()),
        ],
        child: new NavBar(MainMenu.POI),
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
      for (var ic_tap in POINavBarMenu.values()) {
        RawMaterialButton option =
            find.byType(RawMaterialButton).evaluate().toList()[i].widget;
        await tester.tap(find.byWidget(option));
        await tester.pumpAndSettle();
        Text selected = option.child;
        expect(selected.style.fontSize, testTheme().textTheme.body2.fontSize);
        int j = 0;
        for (var ic_plain in POINavBarMenu.values()) {
          if (ic_tap != ic_plain) {
            RawMaterialButton unselect =
                find.byType(RawMaterialButton).evaluate().toList()[0].widget;
            Text selected = unselect.child;
            expect(
                selected.style.fontSize, testTheme().textTheme.body1.fontSize);
          }
          j = j + 1;
        }
        i = i + 1;
      }
    });
  }
}

checkAll() {
  for (var ic in POINavBarMenu.values()) {
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
          fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
