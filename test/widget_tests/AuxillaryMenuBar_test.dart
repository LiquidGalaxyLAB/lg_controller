import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lg_controller/src/menu/AuxillaryMenu.dart';
import 'package:lg_controller/src/ui/AuxillaryMenuBar.dart';

void main() {
  testWidgets('Auxillary menu component check', (WidgetTester tester) async {
    Widget root = new AuxillaryMenuBar();
    await tester.pumpWidget(new Material(child: new MaterialApp(home: root)));

    await tester.pumpAndSettle();

    for (var ic in AuxillaryMenu.values()) {
      expect(
          find.byKey(Key('AuxillaryMenu_items_' + ic.title)), findsOneWidget);
      expect(find.byTooltip(ic.title), findsOneWidget);
    }
  });
}
