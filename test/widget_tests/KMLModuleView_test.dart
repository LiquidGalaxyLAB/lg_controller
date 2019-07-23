import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/states_events/NavBarActions.dart';
import 'package:lg_controller/src/ui/KMLModuleView.dart';

void main() {
  testWidgets('KML module view component check', (WidgetTester tester) async {
    Widget root = new KMLModuleView(
        RecentlyState(), KMLData(title: "test", desc: "test2"));
    await tester.pumpWidget(new Material(child: new MaterialApp(home: root)));

    expect(find.text("test"), findsOneWidget);
    expect(find.text("test2"), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(
        find.descendant(
            of: find.byWidget(root), matching: find.byType(GestureDetector)),
        findsOneWidget);
  });
}
