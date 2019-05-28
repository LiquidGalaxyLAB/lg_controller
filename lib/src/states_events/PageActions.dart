enum PageEvent { HOME, POI }

abstract class PageState {}

class HomeState extends PageState {}

class POIState extends PageState {}