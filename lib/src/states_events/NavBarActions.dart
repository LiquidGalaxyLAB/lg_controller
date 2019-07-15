import 'package:equatable/equatable.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/models/KMLData.dart';

/// Bloc events for Nav bar.
abstract class NavBarEvent extends Equatable {}

/// Recently viewed event.
class RECENTLY extends NavBarEvent {}

/// Search bar event.
class SEARCH extends NavBarEvent {
  /// Text for search query.
  String searchText;

  /// State of currently open page/screen.
  final MainMenu pagestate;

  SEARCH(this.searchText, this.pagestate);
}

/// Category_1 event.
class CATEGORY_1 extends NavBarEvent {}

/// Category_2 event.
class CATEGORY_2 extends NavBarEvent {}

/// Category_3 event.
class CATEGORY_3 extends NavBarEvent {}

/// Category_4 event.
class CATEGORY_4 extends NavBarEvent {}

/// Private_1 event.
class PRIVATE_1 extends NavBarEvent {}

/// Category_6 event.
class CATEGORY_6 extends NavBarEvent {}

/// Category_7 event.
class CATEGORY_7 extends NavBarEvent {}

/// Category_8 event.
class CATEGORY_8 extends NavBarEvent {}

/// Category_9 event.
class CATEGORY_9 extends NavBarEvent {}

/// Private_10 event.
class PRIVATE_2 extends NavBarEvent {}

/// Bloc states for Nav bar.
abstract class NavBarState {}

/// Recently viewed state.
class RecentlyState extends NavBarState {
  @override
  String toString() => 'Recently_Viewed';
}

/// Search bar state.
class SearchState extends NavBarState {
  /// Data for the search query result.
  List<KMLData> searchData;

  SearchState(this.searchData);

  @override
  String toString() => 'Search';
}

/// Category_1 state.
class Category_1_State extends NavBarState {
  @override
  String toString() => 'Category_1';
}

/// Category_2 state.
class Category_2_State extends NavBarState {
  @override
  String toString() => 'Category_2';
}

/// Category_3 state.
class Category_3_State extends NavBarState {
  @override
  String toString() => 'Category_3';
}

/// Category_4 state.
class Category_4_State extends NavBarState {
  @override
  String toString() => 'Category_4';
}

/// Private_1 state.
class Private_1_State extends NavBarState {
  @override
  String toString() => 'Private';
}

/// Category_6 state.
class Category_6_State extends NavBarState {
  @override
  String toString() => 'Category_6';
}

/// Category_7 state.
class Category_7_State extends NavBarState {
  @override
  String toString() => 'Category_7';
}

/// Category_8 state.
class Category_8_State extends NavBarState {
  @override
  String toString() => 'Category_8';
}

/// Category_9 state.
class Category_9_State extends NavBarState {
  @override
  String toString() => 'Category_9';
}

/// Private_2 state.
class Private_2_State extends NavBarState {
  @override
  String toString() => 'Private';
}
