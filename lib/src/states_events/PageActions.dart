import 'package:equatable/equatable.dart';
import 'package:lg_controller/src/models/KMLData.dart';

abstract class PageEvent extends Equatable{}

class HOME extends PageEvent{
  KMLData data;
  HOME(this.data);
}
class CLEARDATA extends PageEvent{}
class POI extends PageEvent{}
class GUIDE extends PageEvent{}
class OVERLAY extends PageEvent{}
class PROFILE extends PageEvent{}
class SETTINGS extends PageEvent{}
class TOUR extends PageEvent{}
class ADDITIONAL extends PageEvent{}

abstract class PageState {}

class HomeState extends PageState {
  KMLData data;
  HomeState(this.data);
}

class POIState extends PageState {}

class GuideState extends PageState {}

class OverState extends PageState {}

class ProfileState extends PageState {}

class SettingsState extends PageState {}

class TourState extends PageState {}

class TutorialState extends PageState {}