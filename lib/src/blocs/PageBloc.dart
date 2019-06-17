import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/states_events/PageActions.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Bloc structure for handling page transitions.
class PageBloc extends Bloc<PageEvent, PageState> {
  /// Initial state of [PageBloc].
  @override
  PageState get initialState => TutorialState();

  @override
  Stream<PageState> mapEventToState(PageEvent event) async* {
    if (event is HOME) {
      yield HomeState(event.data);
      if (event.data == null) {
        event.data = await getKMLData();
        yield HomeState(event.data);
      } else {
        saveKMLData(event.data);
      }
    } else if (event is CLEARDATA) {
      clearKMLData();
      yield HomeState(null);
    } else if (event is POI)
      yield POIState();
    else if (event is GUIDE)
      yield GuideState();
    else if (event is OVERLAY)
      yield OverState();
    else if (event is PROFILE)
      yield ProfileState();
    else if (event is TOUR)
      yield TourState();
    else if (event is SETTINGS)
      yield SettingsState();
    else if (event is ADDITIONAL) yield SettingsState();
  }

  /// To save the KML data of the current module.
  void saveKMLData(KMLData data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('KMLData', jsonEncode(data));
  }

  /// To clear the KML data of the current module.
  void clearKMLData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('KMLData');
  }

  /// To fetch the KML data of the current module from shared preferences.
  Future<KMLData> getKMLData() async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString('KMLData') ?? '';
    if ((dataString.compareTo('')) == 0) {
      return null;
    }
    Map userMap = jsonDecode(dataString);
    var data = new KMLData.fromJson(userMap);
    return data;
  }
}
