import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lg_controller/src/ui/SearchBar.dart';

void main() {
  SearchStates state = SearchStates.INIT;
  testWidgets('Search bar component check', (WidgetTester tester) async {
    Widget root = Container(
        child: new SearchBar(
            () => state = SearchStates.INIT,
            (search) => state = SearchStates.SEARCH,
            (search) => state = SearchStates.COMPLETE));
    await tester.pumpWidget(new Material(child: new MaterialApp(home: root)));

    await tester.pumpAndSettle();
    checkInitState(state);
  });

  testWidgets('Search bar component check with data',
      (WidgetTester tester) async {
    Widget root = Container(
        child: new SearchBar(
            () => state = SearchStates.INIT,
            (search) => state = SearchStates.SEARCH,
            (search) => state = SearchStates.COMPLETE));
    await tester.pumpWidget(new Material(child: new MaterialApp(home: root)));

    await tester.pumpAndSettle();
    checkInitState(state);

    EditableText x = find
        .descendant(
            of: find.byType(SearchBar), matching: find.byType(EditableText))
        .evaluate()
        .toList()[0]
        .widget;
    await tester.showKeyboard(find.byWidget(x));
    await tester.enterText(find.byWidget(x), "test");
    await tester.pumpAndSettle();
    checkEnteredState(state);

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();
    checkInitState(state);
  });
  testWidgets('Search bar component check with input action',
      (WidgetTester tester) async {
    Widget root = Container(
        child: new SearchBar(
            () => state = SearchStates.INIT,
            (search) => state = SearchStates.SEARCH,
            (search) => state = SearchStates.COMPLETE));
    await tester.pumpWidget(new Material(child: new MaterialApp(home: root)));

    await tester.pumpAndSettle();
    checkInitState(state);
    EditableText x = find
        .descendant(
            of: find.byType(SearchBar), matching: find.byType(EditableText))
        .evaluate()
        .toList()[0]
        .widget;

    await tester.showKeyboard(find.byWidget(x));
    await tester.enterText(find.byWidget(x), "");
    await tester.pumpAndSettle();
    checkInitState(state);

    await tester.showKeyboard(find.byWidget(x));
    await tester.enterText(find.byWidget(x), "test");
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    checkCompletedState(state);
  });
}

checkInitState(SearchStates state) {
  expect(find.byType(SearchBar), findsOneWidget);
  expect(find.byType(Text), findsOneWidget);
  expect(find.byType(ClearOption), findsOneWidget);
  expect(find.byType(IconButton), findsNothing);
  Text x = find
      .descendant(of: find.byType(SearchBar), matching: find.byType(Text))
      .evaluate()
      .toList()[0]
      .widget;
  expect(x.data, "Search..");
  expect(state, SearchStates.INIT);
}

checkEnteredState(SearchStates state) {
  expect(find.byType(SearchBar), findsOneWidget);
  expect(find.byType(Text), findsOneWidget);
  expect(find.byType(ClearOption), findsOneWidget);
  expect(find.byType(IconButton), findsOneWidget);
  EditableText x = find
      .descendant(
          of: find.byType(SearchBar), matching: find.byType(EditableText))
      .evaluate()
      .toList()[0]
      .widget;
  expect(x.controller.text, "test");
  expect(state, SearchStates.SEARCH);
}

checkCompletedState(SearchStates state) {
  expect(find.byType(SearchBar), findsOneWidget);
  expect(find.byType(Text), findsOneWidget);
  expect(find.byType(ClearOption), findsOneWidget);
  expect(find.byType(IconButton), findsOneWidget);
  EditableText x = find
      .descendant(
          of: find.byType(SearchBar), matching: find.byType(EditableText))
      .evaluate()
      .toList()[0]
      .widget;
  expect(x.controller.text, "test");
  expect(state, SearchStates.COMPLETE);
}

enum SearchStates { INIT, SEARCH, COMPLETE }
