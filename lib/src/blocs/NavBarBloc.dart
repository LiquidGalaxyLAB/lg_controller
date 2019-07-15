import 'package:bloc/bloc.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/resources/SQLDatabase.dart';
import 'package:lg_controller/src/screens/POIPage.dart';
import 'package:lg_controller/src/states_events/NavBarActions.dart';

/// Bloc structure for handling Nav Bar on [POIPage].
class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  /// Initial state of [NavBarBloc].
  @override
  NavBarState get initialState => RecentlyState();

  /// Instance of [SQLDatabase] to get KML data from local storage.
  final database = SQLDatabase();

  @override
  Stream<NavBarState> mapEventToState(NavBarEvent event) async* {
    if (event is RECENTLY) {
      yield RecentlyState();
    } else if (event is SEARCH) {
      if (event.pagestate == MainMenu.POI)
        yield SearchState(await database.getSearchPOIData(event.searchText));
      else if (event.pagestate == MainMenu.TOURS)
        yield SearchState(await database.getSearchTourData(event.searchText));
    } else if (event is CATEGORY_1)
      yield Category_1_State();
    else if (event is CATEGORY_2)
      yield Category_2_State();
    else if (event is CATEGORY_3)
      yield Category_3_State();
    else if (event is CATEGORY_4)
      yield Category_4_State();
    else if (event is PRIVATE_1)
      yield Private_1_State();
    else if (event is CATEGORY_6)
      yield Category_6_State();
    else if (event is CATEGORY_7)
      yield Category_7_State();
    else if (event is CATEGORY_8)
      yield Category_8_State();
    else if (event is CATEGORY_9)
      yield Category_9_State();
    else if (event is PRIVATE_2) yield Private_2_State();
  }
}
