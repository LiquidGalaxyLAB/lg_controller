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
        height: 20 + 20 * 0.5 * (SizeScaling.getWidthScaling() - 1),
      ),
    );
    list.add(
      Text("CATEGORIES : ", style: Theme.of(context).textTheme.body2),
    );
    list.add(
      SizedBox(
        height: 8 + 8 * 0.5 * (SizeScaling.getWidthScaling() - 1),
      ),
    );
    list.add(Divider(color: Colors.white70));
    list.add(
      SizedBox(
        height: 8 + 8 * (SizeScaling.getWidthScaling() - 1),
      ),
    );
    list.add(
      Expanded(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
        Container(
          child: BlocBuilder<NavBarEvent, NavBarState>(
            bloc: BlocProvider.of<NavBarBloc>(context),
            builder: (BuildContext context, NavBarState state) {
              if (ic.title.compareTo(state.toString()) == 0) {
                return RawMaterialButton(
                  onPressed: () => labelSelected(ic, context),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  constraints: BoxConstraints(
                      minHeight: 36,
                      minWidth: 88 + 44 * (SizeScaling.getWidthScaling() - 1)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child:
                      Text(ic.title, style: Theme.of(context).textTheme.body2),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                );
              } else {
                return RawMaterialButton(
                  onPressed: () => labelSelected(ic, context),
                  child:
                      Text(ic.title, style: Theme.of(context).textTheme.body1),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  constraints: BoxConstraints(
                      minHeight: 36,
                      minWidth: 88 + 44 * (SizeScaling.getWidthScaling() - 1)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                );
              }
            },
          ),
        ),
      );
      list.add(
        SizedBox(
          height: (SizeScaling.getWidthScaling() < 1)
              ? 0
              : 28 * (SizeScaling.getWidthScaling() - 1),
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
        case TourNavBarMenu.PRIVATE_2:
          {
            BlocProvider.of<NavBarBloc>(context).dispatch(PRIVATE_2());
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
        case POINavBarMenu.PRIVATE_1:
          {
            BlocProvider.of<NavBarBloc>(context).dispatch(PRIVATE_1());
          }
          break;
        default:
          {}
      }
  }
}
