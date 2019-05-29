enum PageEvent { HOME, POI, GUIDE, OVERLAY, PROFILE, SETTINGS, TOUR, ADDITIONAL }

abstract class PageState {}

class HomeState extends PageState {}

class POIState extends PageState {}

class GuideState extends PageState {}

class OverState extends PageState {}

class ProfileState extends PageState {}

class SettingsState extends PageState {}

class TourState extends PageState {}

class TutorialState extends PageState {}