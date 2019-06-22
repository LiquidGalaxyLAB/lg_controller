import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/blocs/NavBarBloc.dart';
import 'package:lg_controller/src/menu/NavBarMenu.dart';
import 'package:lg_controller/src/states_events/NavBarActions.dart';

/// Nav menu bar widget.
class NavBar extends StatelessWidget {

  NavBar();

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
        height: 24,
      ),
    );
    list.add(
      Text("CATEGORIES : ", style: Theme.of(context).textTheme.body2),
    );
    list.add(
      SizedBox(
        height: 12,
      ),
    );
    list.add(Divider(color: Colors.white70));
    list.add(
      SizedBox(
        height: 16,
      ),
    );
    list.add(Expanded(child:Container(child:SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: getLabels(context),
      ),),),),);
    return list;
  }
  /// Get list of options of nav bar menu.
  List<Widget> getLabels(context) {
    List<Widget> list = new List<Widget>();
    for (var ic in NavBarMenu.values()) {
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
    }
    return list;
  }

  /// Initiate action when a tab of nav bar menu is selected.
  labelSelected(NavBarMenu ic, context) {
    switch (ic) {
      case NavBarMenu.RECENTLY_VIEWED:
        {
          BlocProvider.of<NavBarBloc>(context).dispatch(RECENTLY());
        }
        break;
      case NavBarMenu.CATEGORY_1:
        {
          BlocProvider.of<NavBarBloc>(context).dispatch(CATEGORY_1());
        }
        break;
      case NavBarMenu.CATEGORY_2:
        {
          BlocProvider.of<NavBarBloc>(context).dispatch(CATEGORY_2());
        }
        break;
      case NavBarMenu.CATEGORY_3:
        {
          BlocProvider.of<NavBarBloc>(context).dispatch(CATEGORY_3());
        }
        break;
      case NavBarMenu.CATEGORY_4:
        {
          BlocProvider.of<NavBarBloc>(context).dispatch(CATEGORY_4());
        }
        break;
      case NavBarMenu.CATEGORY_5:
        {
          BlocProvider.of<NavBarBloc>(context).dispatch(CATEGORY_5());
        }
        break;
      default:
        {}
    }
  }
}
