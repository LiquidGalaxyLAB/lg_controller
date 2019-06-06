import 'package:equatable/equatable.dart';
import 'package:lg_controller/src/models/KMLData.dart';

abstract class NavBarEvent extends Equatable {}

class RECENTLY extends NavBarEvent {}

class SEARCH extends NavBarEvent {
  String searchText;

  SEARCH(this.searchText);
}

class CATEGORY_1 extends NavBarEvent {}

class CATEGORY_2 extends NavBarEvent {}

class CATEGORY_3 extends NavBarEvent {}

class CATEGORY_4 extends NavBarEvent {}

class CATEGORY_5 extends NavBarEvent {}

abstract class NavBarState {}

class RecentlyState extends NavBarState {
  @override
  String toString() => 'Recently_Viewed';
}

class SearchState extends NavBarState {
  List<KMLData> searchData;

  SearchState(this.searchData);

  @override
  String toString() => 'Search';
}

class Category_1_State extends NavBarState {
  @override
  String toString() => 'Category_1';
}

class Category_2_State extends NavBarState {
  @override
  String toString() => 'Category_2';
}

class Category_3_State extends NavBarState {
  @override
  String toString() => 'Category_3';
}

class Category_4_State extends NavBarState {
  @override
  String toString() => 'Category_4';
}

class Category_5_State extends NavBarState {
  @override
  String toString() => 'Category_5';
}
