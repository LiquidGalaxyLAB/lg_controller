import 'package:bloc/bloc.dart';
import 'package:lg_controller/src/states_events/PageActions.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  @override
  PageState get initialState => HomeState();

  @override
  Stream<PageState> mapEventToState(PageEvent event) async* {
    switch (event) {
      case PageEvent.HOME:
        yield HomeState();
        break;
      case PageEvent.POI:
        yield POIState();
        break;
    }
  }
}