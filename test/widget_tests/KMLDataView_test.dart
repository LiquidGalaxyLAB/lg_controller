import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/ui/KMLDataView.dart';

void main() {
  testWidgets('KML data view component check', (WidgetTester tester) async {
    Widget root = new KMLDataView(KMLData(title: "test", desc: "test2", imageUrl: null));
    await tester.pumpWidget(new Material(child: new MaterialApp(home: root)));

    expect(find.text("test"), findsOneWidget);
    expect(find.text("test2"), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byIcon(IconData(0xe5cd, fontFamily: 'MaterialIcons')),
        findsOneWidget);
  });
}
