import 'package:equatable/equatable.dart';
import 'package:lg_controller/src/models/KMLData.dart';

/// Bloc events for Nav bar.
abstract class NavBarEvent extends Equatable {}

/// Recently viewed event.
class RECENTLY extends NavBarEvent {}

/// Search bar event.
class SEARCH extends NavBarEvent {
  /// Text for search query.
  String searchText;

  SEARCH(this.searchText);
}

/// Category_1 event.
class CATEGORY_1 extends NavBarEvent {}

/// Category_2 event.
class CATEGORY_2 extends NavBarEvent {}

/// Category_3 event.
class CATEGORY_3 extends NavBarEvent {}

/// Category_4 event.
class CATEGORY_4 extends NavBarEvent {}

/// Category_5 event.
class CATEGORY_5 extends NavBarEvent {}

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

/// Category_5 state.
class Category_5_State extends NavBarState {
  @override
  String toString() => 'Category_5';
}
