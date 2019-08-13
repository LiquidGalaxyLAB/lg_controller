import 'dart:io';
import 'package:image/image.dart';

import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/menu/POINavBarMenu.dart';
import 'package:lg_controller/src/menu/TourNavBarMenu.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/models/OverlayData.dart';
import 'package:lg_controller/src/models/ImageData.dart';
import 'package:lg_controller/src/models/POIData.dart';
import 'package:lg_controller/src/models/TourData.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

/// To handle all functionalities with SQL databse for storing module data.
class SQLDatabase {
  /// Maximum number of elements in the recents screen.
  static const int RECENT_SIZE = 12;

  /// To save module data in the respective tables according to its category.
  Future<void> saveData(
      Map<String, List<KMLData>> data, MainMenu pagestate) async {
    List items = [];
    if (pagestate == MainMenu.POI)
      items = POINavBarMenu.values();
    else if (pagestate == MainMenu.TOURS) items = TourNavBarMenu.values();
    for (var ic in items) {
      if (ic.title.compareTo(POINavBarMenu.RECENTLY_VIEWED.title) == 0 ||
          ic.title.compareTo(POINavBarMenu.PRIVATE_1.title) == 0) continue;
      await insertInTable(ic.title, data[ic.title]);
    }
  }

  /// To insert [value] in the table denoted by [key].
  insertInTable(String key, value) async {
    final Database db = await createDatabase(key);
    for (var mod in value) {
      Map val = mod.toDatabaseMap();
      if (mod is POIData)
        val = (mod as POIData).toDatabaseMap();
      else if (mod is TourData)
        val = (mod as TourData).toDatabaseMap();
      else if (mod is OverlayData) {
        val = (mod as OverlayData).toDatabaseMap();
        for (var img in mod.itemData)
          if (img is ImageData)
            await File((await getApplicationDocumentsDirectory()).path +
                    "/" +
                    img.title +
                    ".png")
                .writeAsBytes(img.thumbnail);
        await db.insert(
          'modules' + key,
          val,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        return;
      }
      await db.insert(
        'modules' + key,
        val,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  /// To create database and table if it doesn't exist denoted by [title]. Returns null if [title] is not an allowed value.
  Future<Database> createDatabase(String title) async {
    if (title.compareTo(POINavBarMenu.PRIVATE_1.title) == 0) {
      title = 'modules' + title;
      final Future<Database> database = openDatabase(
        join(await getDatabasesPath(), 'modules_database' + title + '.db'),
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE " +
                title +
                "(id INTEGER PRIMARY KEY, title TEXT UNIQUE, desc TEXT UNIQUE, imageUrl TEXT, count INTEGER, latitude REAL, longitude REAL, bearing REAL, zoom REAL, tilt REAL, itemData TEXT)",
          );
        },
        version: 1,
      );
      return database;
    } else if (List.generate(POINavBarMenu.values().length, (i) {
      return POINavBarMenu.values()[i].title;
    }).contains(title)) {
      title = 'modules' + title;
      final Future<Database> database = openDatabase(
        join(await getDatabasesPath(), 'modules_database' + title + '.db'),
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE " +
                title +
                "(id INTEGER PRIMARY KEY, title TEXT UNIQUE, desc TEXT UNIQUE, imageUrl TEXT, count INTEGER, latitude REAL, longitude REAL, bearing REAL, zoom REAL, tilt REAL)",
          );
        },
        version: 1,
      );
      return database;
    } else if (List.generate(TourNavBarMenu.values().length, (i) {
      return TourNavBarMenu.values()[i].title;
    }).contains(title)) {
      title = 'modules' + title;
      final Future<Database> database = openDatabase(
        join(await getDatabasesPath(), 'modules_database' + title + '.db'),
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE " +
                title +
                "(id INTEGER PRIMARY KEY, title TEXT UNIQUE, desc TEXT UNIQUE, imageUrl TEXT, count INTEGER, latitude REAL, longitude REAL, bearing REAL, zoom REAL, tilt REAL, fileID TEXT)",
          );
        },
        version: 1,
      );
      return database;
    } else
      return null;
  }

  /// To retrieve the stored module data.
  Future<Map<String, List<KMLData>>> getData(MainMenu pagestate) async {
    Map<String, List<KMLData>> segData = new Map<String, List<KMLData>>();
    List items = [];
    if (pagestate == MainMenu.POI)
      items = POINavBarMenu.values();
    else if (pagestate == MainMenu.TOURS) items = TourNavBarMenu.values();
    for (var ic in items) {
      segData.addAll({ic.title: new List<KMLData>()});
    }
    for (var ic in items) {
      if (ic.title.compareTo(POINavBarMenu.RECENTLY_VIEWED.title) == 0 ||
          ic.title.compareTo(POINavBarMenu.PRIVATE_1.title) == 0) continue;
      segData[ic.title].addAll(await getValues(ic.title, pagestate));
    }
    List<KMLData> recent = await getRecent(pagestate);
    if (recent != null) segData["Recently_Viewed"].addAll(recent);
    List<OverlayData> privateData = await getPrivate();
    if (privateData != null && pagestate == MainMenu.POI)
      segData[POINavBarMenu.PRIVATE_1.title].addAll(privateData);
    return segData;
  }

  /// To retrieve the stored module data from table denoted by [key].
  Future<List<KMLData>> getValues(String key, MainMenu pagestate) async {
    Database db = await createDatabase(key);
    List<Map<String, dynamic>> maps = await db.query('modules' + key);
    if (maps == null) return [];
    return List.generate(maps.length, (i) {
      if (pagestate == MainMenu.POI)
        return POIData.fromDatabaseMap(maps[i]);
      else if (pagestate == MainMenu.TOURS)
        return TourData.fromDatabaseMap(maps[i]);
    });
  }

  /// To retrieve the private data.
  Future<List<OverlayData>> getPrivate() async {
    Database db = await createDatabase(POINavBarMenu.PRIVATE_1.title);
    List<Map<String, dynamic>> maps =
        await db.query('modules' + POINavBarMenu.PRIVATE_1.title);
    if (maps == null) return [];
    List<OverlayData> listData = List.generate(maps.length, (i) {
      return OverlayData.fromDatabaseMap(maps[i]);
    });
    for (OverlayData data in listData)
      for (var img in data.itemData)
        if (img is ImageData) {
          (img as ImageData).image = await File(
                  (await getApplicationDocumentsDirectory()).path +
                      "/" +
                      img.title +
                      ".png")
              .readAsBytes();
          img.thumbnail = encodePng(copyResize(
              decodeImage((img as ImageData).image),
              width: 80,
              height: 80));
        }
    return listData;
  }

  /// To retrieve the recents data from all tables.
  Future<List<KMLData>> getRecent(MainMenu pagestate) async {
    List<KMLData> recent = new List<KMLData>();
    List items = [];
    if (pagestate == MainMenu.POI)
      items = POINavBarMenu.values();
    else if (pagestate == MainMenu.TOURS) items = TourNavBarMenu.values();
    for (var ic in items) {
      if (ic.title.compareTo(POINavBarMenu.RECENTLY_VIEWED.title) == 0)
        continue;
      Database db = await createDatabase(ic.title);
      List<Map<String, dynamic>> maps = await db
          .rawQuery('SELECT * FROM modules' + ic.title + ' WHERE count > 0');
      if (maps == null) return [];
      for (int i = 0; i < maps.length; i++) {
        if (pagestate == MainMenu.POI)
          addInOrder(recent, POIData.fromDatabaseMap(maps[i]));
        else if (pagestate == MainMenu.TOURS)
          addInOrder(recent, TourData.fromDatabaseMap(maps[i]));
      }
    }
    return recent;
  }

  /// To add recents data in sorted order.
  addInOrder(List<KMLData> recent, KMLData data) {
    if (recent.length < RECENT_SIZE)
      recent.add(data);
    else {
      int i = RECENT_SIZE - 1;
      while (i > 0 && recent.elementAt(i - 1).count < data.count) {
        i--;
        recent[i] = recent[i - 1];
      }
      if (recent.elementAt(i).count < data.count) recent[i] = data;
    }
  }

  /// To update the [data.count] value of the module to denote no. of times it has been viewed.
  updateViewed(String key, KMLData data) async {
    if (key.compareTo(POINavBarMenu.RECENTLY_VIEWED.title) == 0) return;
    Database db = await createDatabase(key);
    if (db == null) return;
    await db.rawUpdate(
        'UPDATE modules' + key + ' SET count = count+1 WHERE title = ?',
        [data.getTitle()]).catchError((error) {});
  }

  /// To return search results in POI modules according to given [searchText].
  Future<List<KMLData>> getSearchPOIData(String searchText) async {
    List<KMLData> result = new List<KMLData>();
    for (var ic in POINavBarMenu.values()) {
      if (ic.title.compareTo(POINavBarMenu.RECENTLY_VIEWED.title) == 0)
        continue;
      List<Map<String, dynamic>> maps =
          await getSearchResult(ic.title, searchText);
      result.addAll(List.generate(maps.length, (i) {
        if (maps[i].containsKey('itemData'))
          return OverlayData.fromDatabaseMap(maps[i]);
        else
          return POIData.fromDatabaseMap(maps[i]);
      }));
    }
    return result;
  }

  /// To return search results in tour modules according to given [searchText].
  Future<List<KMLData>> getSearchTourData(String searchText) async {
    List<KMLData> result = new List<KMLData>();
    for (var ic in TourNavBarMenu.values()) {
      if (ic.title.compareTo(TourNavBarMenu.RECENTLY_VIEWED.title) == 0)
        continue;
      List<Map<String, dynamic>> maps =
          await getSearchResult(ic.title, searchText);
      result.addAll(List.generate(maps.length, (i) {
        return TourData.fromDatabaseMap(maps[i]);
      }));
    }
    return result;
  }

  /// To return search results according to given [searchText] from database denoted by [key].
  Future<List<Map<String, dynamic>>> getSearchResult(
      String key, String searchText) async {
    Database db = await createDatabase(key);
    List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM modules' +
            key +
            ' WHERE title LIKE \'%' +
            searchText +
            '%\'');
    if (maps == null) return [];
    return maps;
  }
}
