import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/blocs/PageBloc.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/resources/SQLDatabase.dart';
import 'package:lg_controller/src/states_events/NavBarActions.dart';
import 'package:lg_controller/src/states_events/PageActions.dart';
import 'package:lg_controller/src/utils/Images.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// Show details of KMLData modules.
class KMLModuleView extends StatelessWidget {
  /// Data of currently running KML module.
  final KMLData data;

  /// Current Nav bar state.
  final NavBarState state;

  KMLModuleView(this.state, this.data);

  /// To update selection of a module.
  final database = SQLDatabase();

  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: SizedBox(
        height: 60 * SizeScaling.getHeightScaling(),
        width: 100 * SizeScaling.getWidthScaling(),
        child: Hero(
          tag: 'KML_View_Card' + data.getTitle() + data.getDesc(),
          child: GestureDetector(
            onTap: () => moduleSelected(context),
            child: Card(
              color: Colors.white70,
              child: Container(
                padding:
                    new EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: (data.imageUrl != null) ? data.imageUrl : "",
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                            maxRadius: 24 * SizeScaling.getWidthScaling(),
                            backgroundColor: Colors.transparent,
                            backgroundImage: imageProvider,
                          ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Image(image: Images.APP_LOGO),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 6.0 +
                              6 * 0.5 * (SizeScaling.getWidthScaling() - 1)),
                    ),
                    Flexible(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data.getTitle(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14 +
                                      14 *
                                          0.8 *
                                          (SizeScaling.getWidthScaling() - 1),
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data.getDesc(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 10 +
                                      10 *
                                          0.8 *
                                          (SizeScaling.getWidthScaling() - 1),
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Select KML module.
  moduleSelected(context) {
    database.updateViewed(state.toString(), data);
    BlocProvider.of<PageBloc>(context).dispatch(HOME(data));
  }
}
