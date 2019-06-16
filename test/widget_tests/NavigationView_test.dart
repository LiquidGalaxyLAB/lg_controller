import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/ui/NavigationView.dart';

void main() {
  testWidgets('Navigation view without data component check',
      (WidgetTester tester) async {
    Widget root = new NavigationView(null);
    await tester.pumpWidget(new Material(child: new MaterialApp(home: root)));

    expect(find.byType(NavigationView), findsOneWidget);
    expect(find.byType(GoogleMap), findsOneWidget);

    GoogleMap x = find
        .descendant(
            of: find.byType(NavigationView), matching: find.byType(GoogleMap))
        .evaluate()
        .toList()[0]
        .widget;

    expect(x.mapType, MapType.satellite);
    expect(x.markers.toList().length, 0);
  });

  testWidgets('Navigation view with data component check',
      (WidgetTester tester) async {
    Widget root = new NavigationView(new KMLData(
        title: "Default",
        desc: "default",
        latitude: 0,
        longitude: 0,
        bearing: 0,
        zoom: 0,
        tilt: 0));
    await tester.pumpWidget(new Material(child: new MaterialApp(home: root)));

    expect(find.byType(NavigationView), findsOneWidget);
    expect(find.byType(GoogleMap), findsOneWidget);

    GoogleMap x = find
        .descendant(
            of: find.byType(NavigationView), matching: find.byType(GoogleMap))
        .evaluate()
        .toList()[0]
        .widget;

    expect(x.mapType, MapType.satellite);
    expect(x.markers.toList().length, 1);
  });
}
