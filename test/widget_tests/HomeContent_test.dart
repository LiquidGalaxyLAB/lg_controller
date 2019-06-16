import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/ui/HomeContent.dart';
import 'package:lg_controller/src/ui/KMLDataView.dart';
import 'package:lg_controller/src/ui/NavigationView.dart';
import 'package:lg_controller/src/ui/SearchBar.dart';

void main() {
  testWidgets('Home content component check with test data',
      (WidgetTester tester) async {
    Widget root = new HomeContent(KMLData(
        title: "test",
        desc: "test2",
        latitude: 0,
        longitude: 0,
        bearing: 0,
        zoom: 0,
        tilt: 0));
    await tester.pumpWidget(new Material(child: new MaterialApp(home: root)));

    await tester.pumpAndSettle();

    expect(find.byType(SearchBar), findsOneWidget);
    expect(find.byType(KMLDataView), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(NavigationView), findsOneWidget);
  });
  testWidgets('Home content component check with null',
      (WidgetTester tester) async {
    Widget root = new HomeContent(null);
    await tester.pumpWidget(new Material(child: new MaterialApp(home: root)));

    await tester.pumpAndSettle();

    expect(find.byType(SearchBar), findsOneWidget);
    expect(find.byType(KMLDataView), findsNothing);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(NavigationView), findsOneWidget);
  });
}
