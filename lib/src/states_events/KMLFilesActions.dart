import 'package:equatable/equatable.dart';
import 'package:lg_controller/src/models/KMLData.dart';

abstract class KMLFilesEvent extends Equatable {}

class GET_FILES extends KMLFilesEvent {}

abstract class KMLFilesState {}

class UninitializedState extends KMLFilesState {}

class ErrorState extends KMLFilesState {}

class LoadingState extends KMLFilesState {}

class LoadedState extends KMLFilesState {
  List<KMLData> data;

  LoadedState(this.data);
}
