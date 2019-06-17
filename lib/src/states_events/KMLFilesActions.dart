import 'package:equatable/equatable.dart';
import 'package:lg_controller/src/models/KMLData.dart';

/// Bloc events for loading module data.
abstract class KMLFilesEvent extends Equatable {}

/// Event to get module data.
class GET_FILES extends KMLFilesEvent {}

/// Bloc states for loading module data.
abstract class KMLFilesState extends Equatable {}

/// Initial state.
class UninitializedState extends KMLFilesState {}

/// State when error has occured.
class ErrorState extends KMLFilesState {}

/// State for loading data in background.
class LoadingState extends KMLFilesState {}

/// State of completion of retrieving data.
class LoadedState extends KMLFilesState {
  /// Map of all the module data sorted according to categories.
  Map<String, List<KMLData>> data;

  LoadedState(this.data);
}
