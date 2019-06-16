import 'package:bloc/bloc.dart';
import 'package:lg_controller/src/gdrive/FileRequests.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/resources/SQLDatabase.dart';
import 'package:lg_controller/src/states_events/KMLFilesActions.dart';

class KMLFilesBloc extends Bloc<KMLFilesEvent, KMLFilesState> {
  @override
  KMLFilesState get initialState => UninitializedState();
  final FileRequests fileRequests;
  final SQLDatabase database;

  KMLFilesBloc(this.fileRequests, this.database);

  @override
  Stream<KMLFilesState> mapEventToState(KMLFilesEvent event) async* {
    if (event is GET_FILES) {
      yield LoadingState();
      Map<String, List<KMLData>> data = await database.getData();
      if (data != null) {
        yield LoadedState(data);
      }
      Map<String, List<KMLData>> dataNetwork = await fileRequests.getPOIFiles();
      if (data != null && data.containsKey("Recently_Viewed"))
        dataNetwork["Recently_Viewed"] = data["Recently_Viewed"];
      if (dataNetwork != null) {
        yield LoadedState(dataNetwork);
        database.saveData(dataNetwork);
      }
    }
  }
}
