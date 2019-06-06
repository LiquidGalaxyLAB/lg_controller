import 'package:bloc/bloc.dart';
import 'package:lg_controller/src/gdrive/FileRequests.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/resources/SQLDatabase.dart';
import 'package:lg_controller/src/states_events/KMLFilesActions.dart';

class KMLFilesBloc extends Bloc<KMLFilesEvent, KMLFilesState> {
  @override
  KMLFilesState get initialState => UninitializedState();
  final fileRequests = FileRequests();
  final database = SQLDatabase();

  @override
  Stream<KMLFilesState> mapEventToState(KMLFilesEvent event) async* {
    if (event is GET_FILES) {
      yield LoadingState();
      Map<String, List<KMLData>> data = await database.getData();
      if (data != null) {
        yield LoadedState(data);
      }
      data = await fileRequests.getPOIFiles();
      if (data != null) {
        yield LoadedState(data);
        database.saveData(data);
      }
    }
  }
}
