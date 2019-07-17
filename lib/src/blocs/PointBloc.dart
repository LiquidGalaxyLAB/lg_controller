import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:lg_controller/src/menu/OverlayMenu.dart';
import 'package:lg_controller/src/models/OverlayItem.dart';
import 'package:lg_controller/src/models/PlacemarkData.dart';
import 'package:lg_controller/src/states_events/PointActions.dart';

/// Bloc structure for handling point touch actions.
class PointBloc extends Bloc<PointEvent, PointState> {
  @override
  PointState get initialState => UninitializedState([]);

  PointBloc();

  /// Instance of a list of [OverlayItem] to store the overlays.
  final List<OverlayItem> data = [];

  @override
  Stream<PointState> mapEventToState(PointEvent event) async* {
    if (event is TAP_EVENT) {
      if (event.menu == OverlayMenu.ROUND_TEMP) {
        Random rnd = Random();
        String id = String.fromCharCodes(
            List<int>.generate(10, (i) => (97 + rnd.nextInt(26))));

        data.add(PlacemarkData(event.point, id, "Default", "Def", 0));
        yield CompletedState();
      } else {
        yield UninitializedState(data);
      }
    } else if (event is CLEAR_EVENT) {
      yield UninitializedState(data);
    } else if (event is MODIFY_EVENT) {
      yield CompletedState();
      yield UninitializedState(data);
    }
  }
}
