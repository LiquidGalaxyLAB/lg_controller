import 'package:googleapis/drive/v2.dart' as drive;
import 'package:lg_controller/src/gdrive/FileRequests.dart';
import 'package:lg_controller/src/menu/NavBarMenu.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockDriveApi extends Mock implements drive.DriveApi {}

class MockFileResApi extends Mock implements drive.FilesResourceApi {}

main() {
  group('fetchPost', () {
    FileRequests fr = FileRequests();

    test('Test null error', () async {
      MockDriveApi client_dr = MockDriveApi();
      when(client_dr.files).thenReturn(null);

      expect(await fr.searchFiles(client_dr, null, null), null);
    });

    test('Tests no value', () async {
      MockDriveApi client_dr = MockDriveApi();
      MockFileResApi client_fra = MockFileResApi();
      when(client_fra.list()).thenAnswer((_) async => null);

      expect(await fr.searchFiles(client_dr, null, null), null);
    });

    test('Tests empty data', () async {
      MockDriveApi client_dr = MockDriveApi();
      MockFileResApi client_fra = MockFileResApi();

      drive.FileList fileList = new drive.FileList();
      fileList.items = List();
      fileList.items.add(new drive.File());
      fileList.nextPageToken = null;

      when(client_dr.files).thenReturn(client_fra);
      when(client_fra.list(q: "test", pageToken: null, maxResults: 1))
          .thenAnswer((_) async => fileList);

      expect(await fr.searchFiles(client_dr, 1, "test"), fileList.items);

      verify(client_dr.files).called(1);
      verify(client_fra.list(q: "test", pageToken: null, maxResults: 1))
          .called(1);
    });

    test('Tests with data', () async {
      MockDriveApi client_dr = MockDriveApi();
      MockFileResApi client_fra = MockFileResApi();
      drive.FileList fileList = new drive.FileList();
      fileList.items = List();
      drive.File file = new drive.File();
      String desc =
          "{\"data\": \"{\\\"title\\\": \\\"POI3\\\", \\\"desc\\\": \\\"desc3\\\", \\\"latitude\\\": 0.0, \\\"longitude\\\": 0.0, \\\"bearing\\\": 0.0, \\\"zoom\\\": 0.0, \\\"tilt\\\": 0.0}\", \"category\": \"Category_1\"}";
      file.description = desc;
      fileList.items.add(file);
      fileList.nextPageToken = null;
      Map<String, List<KMLData>> test = Map();
      for (var ic in NavBarMenu.values()) {
        test.addAll({ic.title: new List<KMLData>()});
      }
      test.addAll({
        "Category_1": new List.of({
          new KMLData(
              title: "POI3",
              desc: "desc3",
              latitude: 0,
              longitude: 0,
              bearing: 0,
              zoom: 0,
              tilt: 0)
        })
      });

      when(client_dr.files).thenReturn(client_fra);
      when(client_fra.list(q: anyNamed('q'), pageToken: null, maxResults: 1))
          .thenAnswer((_) async => fileList);

      expect(fileList.items.length, 1);
      expect(await fr.searchFiles(client_dr, 1, "test"), fileList.items);
      expect(await fr.decodeFiles(fileList.items), test);
    });
  });
}
