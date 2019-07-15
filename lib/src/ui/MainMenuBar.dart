import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/blocs/PageBloc.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/states_events/PageActions.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// Main menu bar widget.
class MainMenuBar extends StatelessWidget {
  /// Main menu bar selected state.
  final MainMenu state;

  MainMenuBar(this.state);

  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: getLabels(context),
      ),
    );
  }

  /// Get list of tabs of main menu.
  List<Widget> getLabels(context) {
    List<Widget> list = new List<Widget>();
    for (var ic in MainMenu.values()) {
      list.add(
        Column(
          children: <Widget>[
            Hero(
              tag: "tab_" + ic.title,
              child: GestureDetector(
                onTap: () => labelSelected(ic, context),
                child: Container(
                    child: RawMaterialButton(
                  onPressed: () => labelSelected(ic, context),
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(
                      minHeight: 28,
                      minWidth: 48 + 32 * (SizeScaling.getWidthScaling() - 1)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child:
                      Text(ic.title, style: Theme.of(context).textTheme.body1),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                )),
              ),
            ),
            state == ic
                ? Hero(
                    tag: "tab_underline",
                    child: Container(
                      color: Colors.white,
                      width: 40,
                      height: 1.0,
                    ),
                  )
                : Container()
          ],
        ),
      );
    }
    return list;
  }

  /// Initiate action when a tab of main menu is selected.
  labelSelected(MainMenu ic, context) {
    switch (ic) {
      case MainMenu.HOME:
        {
          BlocProvider.of<PageBloc>(context).dispatch(HOME(null));
        }
        break;
      case MainMenu.TOURS:
        {
          BlocProvider.of<PageBloc>(context).dispatch(TOUR());
        }
        break;
      case MainMenu.POI:
        {
          BlocProvider.of<PageBloc>(context).dispatch(POI());
        }
        break;
      case MainMenu.GUIDE:
        {
          BlocProvider.of<PageBloc>(context).dispatch(GUIDE());
        }
        break;
      case MainMenu.OVERLAY:
        {
          BlocProvider.of<PageBloc>(context).dispatch(OVERLAY());
        }
        break;
      default:
        {}
    }
  }
}
