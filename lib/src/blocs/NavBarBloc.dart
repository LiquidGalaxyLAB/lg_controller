import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/states_events/NavBarActions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {

  @override
  NavBarState get initialState => RecentlyState();

  @override
  Stream<NavBarState> mapEventToState(NavBarEvent event) async* {
    if (event is RECENTLY) {
      yield RecentlyState();
    } else if (event is SEARCH) {
      yield SearchState();
    } else if (event is CATEGORY_1)
      yield Category_1_State();
    else if (event is CATEGORY_2)
      yield Category_2_State();
    else if (event is CATEGORY_3)
      yield Category_3_State();
    else if (event is CATEGORY_4)
      yield Category_4_State();
    else if (event is CATEGORY_5)
      yield Category_5_State();
  }
}
