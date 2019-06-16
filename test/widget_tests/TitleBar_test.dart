import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/ui/AppTitle.dart';
import 'package:lg_controller/src/ui/AuxillaryMenuBar.dart';
import 'package:lg_controller/src/ui/MainMenuBar.dart';
import 'package:lg_controller/src/ui/TitleBar.dart';

void main() {
  for (var ic in MainMenu.values()) {
    testWidgets('Title bar component check', (WidgetTester tester) async {
      Widget root = new TitleBar(ic);

      await tester.pumpWidget(
          new Material(child: new MaterialApp(theme: testTheme(), home: root)));
      await tester.pumpAndSettle();

      expect(find.byType(AppTitle), findsOneWidget);
      expect(find.byType(MainMenuBar), findsOneWidget);
      expect(find.byType(AuxillaryMenuBar), findsOneWidget);
    });
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
      body1: TextStyle(fontSize: 10, color: Colors.white),
      body2: TextStyle(
          fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
