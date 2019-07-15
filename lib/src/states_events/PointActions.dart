import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_controller/src/menu/OverlayMenu.dart';
import 'package:lg_controller/src/models/OverlayItem.dart';

/// Bloc events for handling tap gestures.
abstract class PointEvent extends Equatable {}

/// Event for registering tap gesture.
class TAP_EVENT extends PointEvent {
  /// Coordinates of tap gesture.
  LatLng point;

  /// Currently selected overlay tool.
  OverlayMenu menu;

  TAP_EVENT(this.point, this.menu);
}

/// Event for clearing tap gesture.
class CLEAR_EVENT extends PointEvent {}

/// Bloc states for handling tap gestures.
abstract class PointState extends Equatable {}

/// Initial state.
class UninitializedState extends PointState {
  /// Data of the previous overlay features.
  List<OverlayItem> data;

  UninitializedState(this.data);
}

/// State when error has occured.
class ErrorState extends PointState {}

/// State for processing data in background.
class ProcessingState extends PointState {
  /// Data of the overlay feature.
  OverlayItem data;

  ProcessingState(this.data);
}

/// State of completion of drawing overlay feature.
class CompletedState extends PointState {
  /// Data of the overlay feature.
  OverlayItem data;

  CompletedState(this.data);
}
