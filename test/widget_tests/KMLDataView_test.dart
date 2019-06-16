import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/ui/KMLDataView.dart';

void main() {
  testWidgets('Auxillary menu component check', (WidgetTester tester) async {
    Widget root = new KMLDataView(KMLData(title: "test", desc: "test2"));
    await tester.pumpWidget(new Material(child: new MaterialApp(home: root)));

    await tester.pumpAndSettle();

    expect(find.text("test"), findsOneWidget);
    expect(find.text("test2"), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byIcon(IconData(0xe5cd, fontFamily: 'MaterialIcons')),
        findsOneWidget);
  });
}
