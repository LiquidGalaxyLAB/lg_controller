import 'dart:math';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image/image.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:lg_controller/src/menu/OverlayMenu.dart';
import 'package:lg_controller/src/models/OverlayItem.dart';
import 'package:lg_controller/src/models/PlacemarkData.dart';
import 'package:lg_controller/src/models/PointData.dart';
import 'package:lg_controller/src/models/LineData.dart';
import 'package:lg_controller/src/models/PolygonData.dart';
import 'package:lg_controller/src/models/ImageData.dart';
import 'package:lg_controller/src/states_events/PointActions.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Bloc structure for handling point touch actions.
class PointBloc extends Bloc<PointEvent, PointState> {
  @override
  PointState get initialState => UninitializedState([]);

  PointBloc();

  /// Instance of a list of [OverlayItem] to store the overlays.
  final List<OverlayItem> data = [];

  /// To store have finished [OverlayItem].
  OverlayItem temp;

  @override
  Stream<PointState> mapEventToState(PointEvent event) async* {
    if (event is TAP_EVENT) {
      if (event.menu == OverlayMenu.ROUND_TEMP) {
        Random rnd = Random();
        String id = String.fromCharCodes(
            List<int>.generate(10, (i) => (97 + rnd.nextInt(26))));

        data.add(
            PlacemarkData(PointData(event.point, 0), id, "Default", "Def"));
        yield CompletedState();
      } else if (event.menu == OverlayMenu.LINE) {
        if (temp == null) {
          Random rnd = Random();
          String id = String.fromCharCodes(
              List<int>.generate(10, (i) => (97 + rnd.nextInt(26))));
          temp = LineData(id, "Default", "Def");
          (temp as LineData).setPoint(
            PointData(event.point, 0),
          );
          yield ProcessingState(temp);
        } else {
          (temp as LineData).setPoint(
            PointData(event.point, 0),
          );
          data.add(temp);
          yield CompletedState();
        }
      } else if (event.menu == OverlayMenu.IMAGE) {
        Random rnd = Random();
        String id = String.fromCharCodes(
            List<int>.generate(10, (i) => (97 + rnd.nextInt(26))));

        File image = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 400, maxHeight: 400);
        if(image!=null)
          {
            List<int> thumbnail = encodePng(copyResize(decodeImage(await image.readAsBytes()),width: 80,height: 80));
            data.add(
                ImageData(PointData(event.point, 0), id, "Default", "Def", await image.readAsBytes(), thumbnail));
          }
        yield CompletedState();
      }
      else if (event.menu == OverlayMenu.POLYGON) {
        if (temp == null) {
          Random rnd = Random();
          String id = String.fromCharCodes(
              List<int>.generate(10, (i) => (97 + rnd.nextInt(26))));
          temp = PolygonData(id, "Default", "Def", await getPolygonVertexCount());
          (temp as PolygonData).setPoint(
            PointData(event.point, 0),
          );
          yield ProcessingState(temp);
        } else {
          (temp as PolygonData).setPoint(
            PointData(event.point, 0),
          );
          yield UninitializedState(data);
          yield ProcessingState(temp);
        }
        if((temp as PolygonData).complete) {
          data.add(temp);
          yield CompletedState();
        }
      }
      else {
        yield UninitializedState(data);
      }
    } else if (event is CLEAR_EVENT) {
      temp = null;
      yield UninitializedState(data);
    } else if (event is MODIFY_EVENT) {
      temp = null;
      yield CompletedState();
    }
  }
  Future<int> getPolygonVertexCount() async {
    final prefs = await SharedPreferences.getInstance();
    final vertex = prefs.getInt('PolygonVertex') ?? 3;
    return vertex;
  }
}
