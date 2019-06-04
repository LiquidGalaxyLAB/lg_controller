import 'package:bloc/bloc.dart';
import 'package:lg_controller/src/gdrive/FileRequests.dart';
import 'package:lg_controller/src/menu/NavBarMenu.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/states_events/KMLFilesActions.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class KMLFilesBloc extends Bloc<KMLFilesEvent, KMLFilesState> {
  @override
  KMLFilesState get initialState => UninitializedState();
  final fileRequests = FileRequests();

  @override
  Stream<KMLFilesState> mapEventToState(KMLFilesEvent event) async* {
    if (event is GET_FILES) {
      yield LoadingState();
      Map<String, List<KMLData>> data = await getData();
      if (data != null) {
        yield LoadedState(data);
      }
      data = await fileRequests.getPOIFiles();
      if (data != null) {
        yield LoadedState(data);
        saveData(data);
      }
    }
  }

  Future<void> saveData(Map<String, List<KMLData>> data) async {
    for (var ic in NavBarMenu.values()) {
      await insertInTable(ic.title, data[ic.title]);
    }
  }

  insertInTable(String key, value) async {
    final Database db = await createDatabase('modules' + key);
    for (var mod in value) {
      await db.insert(
        'modules' + key,
        mod.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<Database> createDatabase(String title) async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'modules_database' + title + '.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE " +
              title +
              "(id INTEGER PRIMARY KEY, title TEXT UNIQUE, desc TEXT UNIQUE)",
        );
      },
      version: 1,
    );
    return database;
  }

  Future<Map<String, List<KMLData>>> getData() async {
    Map<String, List<KMLData>> segData = new Map<String, List<KMLData>>();
    for (var ic in NavBarMenu.values()) {
      segData.addAll({ic.title: new List<KMLData>()});
    }
    for (var ic in NavBarMenu.values()) {
      segData[ic.title].addAll(await getValues(ic.title));
    }
    return segData;
  }

  Future<List<KMLData>> getValues(String key) async {
    Database db = await createDatabase('modules' + key);
    List<Map<String, dynamic>> maps = await db.query('modules' + key);
    if (maps == null) return [];
    return List.generate(maps.length, (i) {
      return KMLData(maps[i]['title'], maps[i]['desc']);
    });
  }
}
