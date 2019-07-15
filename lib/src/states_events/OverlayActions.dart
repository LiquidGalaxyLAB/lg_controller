import 'package:equatable/equatable.dart';
import 'package:lg_controller/src/menu/OverlayMenu.dart';
import 'package:lg_controller/src/models/KMLData.dart';

/// Bloc events for handling map events.
abstract class OverlayEvent extends Equatable {}

/// Event to freeze map.
class FREEZE extends OverlayEvent {
  /// Currently selected overlay tool.
  OverlayMenu menu;

  FREEZE(this.menu);
}

/// Event to unfreeze map.
class UNFREEZE extends OverlayEvent {
  /// Data of current camera position.
  KMLData data;

  UNFREEZE(this.data);
}

/// Bloc states for handling map events.
abstract class OverlaysState extends Equatable {}

/// State for freezed map.
class FrozenState extends OverlaysState {
  /// Currently selected overlay tool.
  OverlayMenu menu;

  FrozenState(this.menu);
}

/// Initial state.
class UnfrozenState extends OverlaysState {}
