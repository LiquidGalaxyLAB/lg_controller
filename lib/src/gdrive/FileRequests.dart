import 'dart:async';
import 'dart:convert';

import 'package:googleapis/drive/v2.dart' as drive;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:lg_controller/src/models/KMLData.dart';

class FileRequests {
  final _credentials = new auth.ServiceAccountCredentials.fromJson(r'''
  
  ''');
  final scopes = [drive.DriveApi.DriveScope];

  Future<List<KMLData>> getPOIFiles() async {
    var client = await authorizeUser();
    if (client == null) return null;
    var api = new drive.DriveApi(client);
    var query =
        "mimeType = 'application/vnd.google-earth.kml+xml' and '1Gs-KiheWHACyUtYtvGZma8xsBX6r1iTJ' in parents";
    List<drive.File> files =
        await searchFiles(api, 24, query).catchError((error) {
      print('An error occured: ' + (error.toString()));
      return [];
    }).whenComplete(() {
      client.close();
    });
    return decodeFiles(files);
  }

  Future<List<KMLData>> decodeFiles(files) async {
    List<KMLData> d=new List<KMLData>();
    for (var file in files) {
      print(
          ' - ${file.mimeType} ${file.title} ${KMLData.fromJson(jsonDecode(file.description)).title} ${file.id} ');
      d.add(new KMLData.fromJson(jsonDecode(file.description)));
    }
    return d;
  }

  Future<auth.AuthClient> authorizeUser() async {
    var client = await auth
        .clientViaServiceAccount(_credentials, scopes)
        .catchError((error) {
      print("An unknown error occured: $error");
      return null;
    });
    return client;
  }

  Future<List<drive.File>> searchFiles(
      drive.DriveApi api, int max, String query) async {
    List<drive.File> docs = [];
    Future<List<drive.File>> next(String token) {
      return api.files
          .list(q: query, pageToken: token, maxResults: max)
          .then((results) {
        docs.addAll(results.items);
        if (docs.length < max && results.nextPageToken != null) {
          return next(results.nextPageToken);
        }
        return docs;
      });
    }

    return next(null);
  }
}
