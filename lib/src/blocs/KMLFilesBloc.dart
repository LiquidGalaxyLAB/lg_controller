import 'package:bloc/bloc.dart';
import 'package:lg_controller/src/gdrive/FileRequests.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/resources/SQLDatabase.dart';
import 'package:lg_controller/src/states_events/KMLFilesActions.dart';

/// Bloc structure for handling KML data.
class KMLFilesBloc extends Bloc<KMLFilesEvent, KMLFilesState> {
  /// State of currently open page/screen.
  final MainMenu pagestate;

  /// Initial state of [KMLFilesBloc].
  @override
  KMLFilesState get initialState => UninitializedState();

  /// Instance of [FileRequests] to get KML data from Google Drive.
  final FileRequests fileRequests;

  /// Instance of [SQLDatabase] to get KML data from local storage.
  final SQLDatabase database;

  KMLFilesBloc(this.fileRequests, this.database, this.pagestate);

  @override
  Stream<KMLFilesState> mapEventToState(KMLFilesEvent event) async* {
    if (event is GET_FILES) {
      Map<String, List<KMLData>> data;
      yield LoadingState();
      try {
        data = await database.getData(pagestate);
      } catch (e) {
        print(e);
      }
      print(data);
      if (data != null) {
        yield LoadedState(data);
      }
      Map<String, List<KMLData>> dataNetwork =
          await fileRequests.getFiles(pagestate);
      if (data != null && data.containsKey("Recently_Viewed"))
        dataNetwork["Recently_Viewed"] = data["Recently_Viewed"];
      if (data != null && data.containsKey("Private"))
        dataNetwork["Private"] = data["Private"];
      print(dataNetwork);
      if (dataNetwork != null) {
        yield LoadingState();
        yield LoadedState(dataNetwork);
        await database.saveData(dataNetwork, pagestate);
      }
    }
  }
}
