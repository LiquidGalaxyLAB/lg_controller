import 'package:bloc/bloc.dart';
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
      yield SearchState(await database.getSearchData(event.searchText));
    } else if (event is CATEGORY_1)
      yield Category_1_State();
    else if (event is CATEGORY_2)
      yield Category_2_State();
    else if (event is CATEGORY_3)
      yield Category_3_State();
    else if (event is CATEGORY_4)
      yield Category_4_State();
    else if (event is CATEGORY_5) yield Category_5_State();
  }
}
