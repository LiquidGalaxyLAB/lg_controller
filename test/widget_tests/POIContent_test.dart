import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lg_controller/src/blocs/KMLFilesBloc.dart';
import 'package:lg_controller/src/blocs/NavBarBloc.dart';
import 'package:lg_controller/src/gdrive/FileRequests.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/resources/SQLDatabase.dart';
import 'package:lg_controller/src/ui/KMLGridContent.dart';

void main() {
  testWidgets('POI Content component check', (WidgetTester tester) async {
    KMLFilesBloc kml_files_bloc =
        new KMLFilesBloc(FileRequests(), SQLDatabase(), MainMenu.POI);
    Widget root = BlocProviderTree(
      blocProviders: [
        BlocProvider<NavBarBloc>(bloc: new NavBarBloc()),
        BlocProvider<KMLFilesBloc>(bloc: kml_files_bloc),
      ],
      child: new KMLGridContent(),
    );
    await tester.pumpWidget(new Material(child: new MaterialApp(home: root)));

    expect(find.byType(GridContent), findsOneWidget);
    Text x = find.byType(Text).evaluate().toList()[0].widget;
    expect(x.data, "Uninitialized..");
    expect(find.byType(GridView), findsNothing);
    await tester.pumpAndSettle();
    x = find.byType(Text).evaluate().toList()[0].widget;
    expect(x.data, "Loading..");
    expect(find.byType(GridView), findsNothing);
  });
}
