import 'package:lg_controller/src/blocs/KMLFilesBloc.dart';
import 'package:lg_controller/src/gdrive/FileRequests.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/resources/SQLDatabase.dart';
import 'package:lg_controller/src/states_events/KMLFilesActions.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockFileRequests extends Mock implements FileRequests {}

class MockSQLDatabase extends Mock implements SQLDatabase {}

main() {
  group('fetchPost', () {
    MockFileRequests client_fr = MockFileRequests();
    MockSQLDatabase client_sql = MockSQLDatabase();

    test('Checks initial state value', () async {
      KMLFilesBloc bloc = KMLFilesBloc(client_fr, client_sql, MainMenu.POI);
      expect(bloc.initialState, UninitializedState());
    });

    test('Checks emitting initial state', () {
      KMLFilesBloc bloc = KMLFilesBloc(client_fr, client_sql, MainMenu.POI);
      expect(bloc.state, emitsInOrder([UninitializedState()]));
    });

    test('Checks Loading state', () {
      KMLFilesBloc bloc = KMLFilesBloc(client_fr, client_sql, MainMenu.POI);
      when(client_fr.getFiles(MainMenu.POI)).thenAnswer((_) async => null);
      when(client_sql.getData(MainMenu.POI)).thenAnswer((_) async => null);
      bloc.dispatch(GET_FILES());
      expect(bloc.state, emitsInOrder([UninitializedState(), LoadingState()]));
    });

    test('Drive returns null and local storage returns value', () {
      KMLFilesBloc bloc = KMLFilesBloc(client_fr, client_sql, MainMenu.POI);
      when(client_fr.getFiles(MainMenu.POI)).thenAnswer((_) async => null);
      when(client_sql.getData(MainMenu.POI)).thenAnswer((_) async => Map());
      bloc.dispatch(GET_FILES());
      verifyInOrder(
          [client_sql.getData(MainMenu.POI), client_fr.getFiles(MainMenu.POI)]);
      expect(
          bloc.state,
          emitsInOrder(
              [UninitializedState(), LoadingState(), LoadedState(Map())]));
    });

    test('Drive returns value and local storage returns null', () {
      KMLFilesBloc bloc = KMLFilesBloc(client_fr, client_sql, MainMenu.POI);
      when(client_fr.getFiles(MainMenu.POI)).thenAnswer((_) async => Map());
      when(client_sql.getData(MainMenu.POI)).thenAnswer((_) async => null);
      bloc.dispatch(GET_FILES());
      verifyInOrder(
          [client_sql.getData(MainMenu.POI), client_fr.getFiles(MainMenu.POI)]);
      expect(
          bloc.state,
          emitsInOrder(
              [UninitializedState(), LoadingState(), LoadedState(Map())]));
    });
    test('Drive returns value and local storage returns value', () {
      KMLFilesBloc bloc = KMLFilesBloc(client_fr, client_sql, MainMenu.POI);
      when(client_fr.getFiles(MainMenu.POI)).thenAnswer((_) async => Map());
      when(client_sql.getData(MainMenu.POI)).thenAnswer((_) async => Map());
      bloc.dispatch(GET_FILES());
      verifyInOrder(
          [client_sql.getData(MainMenu.POI), client_fr.getFiles(MainMenu.POI)]);
      expect(
          bloc.state,
          emitsInOrder(
              [UninitializedState(), LoadingState(), LoadedState(Map())]));
    });

    test('Dispose call', () {
      KMLFilesBloc bloc = KMLFilesBloc(client_fr, client_sql, MainMenu.POI);
      bloc.dispose();
      expect(bloc.state, emitsInOrder([]));
    });
  });
}
