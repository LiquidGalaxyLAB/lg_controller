import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/blocs/NavBarBloc.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/menu/POINavBarMenu.dart';
import 'package:lg_controller/src/menu/TourNavBarMenu.dart';
import 'package:lg_controller/src/states_events/NavBarActions.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// Nav menu bar widget.
class NavBar extends StatelessWidget {
  /// State of currently open page/screen.
  final MainMenu pagestate;

  NavBar(this.pagestate);

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: getHeader(context),
      ),
    );
  }

  ///Get header for the Nav Bar.
  List<Widget> getHeader(context) {
    List<Widget> list = new List<Widget>();
    list.add(
      SizedBox(
        height: 24 + 24 * 0.5 * (SizeScaling.getWidthScaling() - 1),
      ),
    );
    list.add(
      Text("CATEGORIES : ", style: Theme.of(context).textTheme.body2),
    );
    list.add(
      SizedBox(
        height: 12 + 12 * 0.5 * (SizeScaling.getWidthScaling() - 1),
      ),
    );
    list.add(Divider(color: Colors.white70));
    list.add(
      SizedBox(
        height: 16 + 16 * 0.5 * (SizeScaling.getWidthScaling() - 1),
      ),
    );
    list.add(
      Expanded(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: getLabels(context),
            ),
          ),
        ),
      ),
    );
    return list;
  }

  /// Get list of options of nav bar menu.
  List<Widget> getLabels(context) {
    List<Widget> list = new List<Widget>();
    List labels = [];
    if (pagestate == MainMenu.TOURS)
      labels = TourNavBarMenu.values();
    else if (pagestate == MainMenu.POI) labels = POINavBarMenu.values();
    for (var ic in labels) {
      list.add(
        Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => labelSelected(ic, context),
              child: Container(
                padding: EdgeInsets.all(8),
                child: BlocBuilder<NavBarEvent, NavBarState>(
                  bloc: BlocProvider.of<NavBarBloc>(context),
                  builder: (BuildContext context, NavBarState state) {
                    if (ic.title.compareTo(state.toString()) == 0) {
                      return Text(ic.title,
                          style: Theme.of(context).textTheme.body2);
                    } else {
                      return Text(ic.title,
                          style: Theme.of(context).textTheme.body1);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );
      list.add(
        SizedBox(
          height: 16 * 0.5 * (SizeScaling.getHeightScaling() - 1),
        ),
      );
    }
    return list;
  }

  /// Initiate action when a tab of nav bar menu is selected.
  labelSelected(var ic, context) {
    if (pagestate == MainMenu.TOURS)
      switch (ic) {
        case TourNavBarMenu.RECENTLY_VIEWED:
          {
            BlocProvider.of<NavBarBloc>(context).dispatch(RECENTLY());
          }
          break;
        case TourNavBarMenu.CATEGORY_6:
          {
            BlocProvider.of<NavBarBloc>(context).dispatch(CATEGORY_6());
          }
          break;
        case TourNavBarMenu.CATEGORY_7:
          {
            BlocProvider.of<NavBarBloc>(context).dispatch(CATEGORY_7());
          }
          break;
        case TourNavBarMenu.CATEGORY_8:
          {
            BlocProvider.of<NavBarBloc>(context).dispatch(CATEGORY_8());
          }
          break;
        case TourNavBarMenu.CATEGORY_9:
          {
            BlocProvider.of<NavBarBloc>(context).dispatch(CATEGORY_9());
          }
          break;
        case TourNavBarMenu.CATEGORY_10:
          {
            BlocProvider.of<NavBarBloc>(context).dispatch(CATEGORY_10());
          }
          break;
        default:
          {}
      }
    else if (pagestate == MainMenu.POI)
      switch (ic) {
        case POINavBarMenu.RECENTLY_VIEWED:
          {
            BlocProvider.of<NavBarBloc>(context).dispatch(RECENTLY());
          }
          break;
        case POINavBarMenu.CATEGORY_1:
          {
            BlocProvider.of<NavBarBloc>(context).dispatch(CATEGORY_1());
          }
          break;
        case POINavBarMenu.CATEGORY_2:
          {
            BlocProvider.of<NavBarBloc>(context).dispatch(CATEGORY_2());
          }
          break;
        case POINavBarMenu.CATEGORY_3:
          {
            BlocProvider.of<NavBarBloc>(context).dispatch(CATEGORY_3());
          }
          break;
        case POINavBarMenu.CATEGORY_4:
          {
            BlocProvider.of<NavBarBloc>(context).dispatch(CATEGORY_4());
          }
          break;
        case POINavBarMenu.CATEGORY_5:
          {
            BlocProvider.of<NavBarBloc>(context).dispatch(CATEGORY_5());
          }
          break;
        default:
          {}
      }
  }
}
