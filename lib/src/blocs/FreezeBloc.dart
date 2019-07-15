import 'package:bloc/bloc.dart';
import 'package:lg_controller/src/blocs/PointBloc.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/states_events/OverlayActions.dart';
import 'package:lg_controller/src/states_events/PointActions.dart';

/// Bloc structure for handling freezing actions.
class FreezeBloc extends Bloc<OverlayEvent, OverlaysState> {
  /// Initial state of [FreezeBloc].
  @override
  OverlaysState get initialState => UnfrozenState();

  /// Instance of [PointBloc] to dispatch necessary events.
  PointBloc pointbloc;

  /// Instance of [KMLData] to store KML data for the overlay feature.
  KMLData data = new KMLData(
      title: "Default",
      desc: "Default",
      latitude: 0,
      longitude: 0,
      bearing: 0,
      zoom: 0,
      tilt: 0);

  FreezeBloc(this.pointbloc);

  @override
  Stream<OverlaysState> mapEventToState(OverlayEvent event) async* {
    if (event is FREEZE) {
      yield UnfrozenState();
      yield FrozenState(event.menu);
    } else if (event is UNFREEZE) {
      if (event.data != null) data = event.data;
      pointbloc.dispatch(CLEAR_EVENT());
      yield UnfrozenState();
    }
  }
}
