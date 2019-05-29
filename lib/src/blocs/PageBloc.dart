import 'package:bloc/bloc.dart';
import 'package:lg_controller/src/states_events/PageActions.dart';

class PageBloc extends Bloc<PageEvent, PageState> {

  @override
  PageState get initialState => TutorialState();

  @override
  Stream<PageState> mapEventToState(PageEvent event) async* {
    switch (event) {
      case PageEvent.HOME:
        yield HomeState();
        break;
      case PageEvent.POI:
        yield POIState();
        break;
      case PageEvent.GUIDE:
        yield GuideState();
        break;
      case PageEvent.OVERLAY:
        yield OverState();
        break;
      case PageEvent.PROFILE:
        yield ProfileState();
        break;
      case PageEvent.TOUR:
        yield TourState();
        break;
      case PageEvent.SETTINGS:
        yield SettingsState();
        break;
      case PageEvent.ADDITIONAL:
        yield SettingsState();
        break;
    }
  }
}