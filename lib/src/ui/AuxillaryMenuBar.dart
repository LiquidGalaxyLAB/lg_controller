import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/blocs/PageBloc.dart';
import 'package:lg_controller/src/menu/AuxillaryMenu.dart';
import 'package:lg_controller/src/states_events/PageActions.dart';

/// auxillary menu bar widget.
class AuxillaryMenuBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: getIcons(context),
      ),
    );
  }

  /// Get icons for the auxillary menu options.
  List<Widget> getIcons(context) {
    List<Widget> list = new List<Widget>();
    for (var ic in AuxillaryMenu.values()) {
      list.add(
        Expanded(
          flex: 10,
          child: IconButton(
            key: Key('AuxillaryMenu_items_' + ic.title),
            icon: ic.icon,
            tooltip: ic.title,
            onPressed: () => iconSelected(ic, context),
          ),
        ),
      );
      list.add(
        Expanded(
          flex: 5,
          child: SizedBox(
            width: 5,
          ),
        ),
      );
    }
    return list;
  }

  /// Initiate page event for [ic] selected.
  iconSelected(AuxillaryMenu ic, context) {
    switch (ic) {
      case AuxillaryMenu.PROFILE:
        {
          BlocProvider.of<PageBloc>(context).dispatch(PROFILE());
        }
        break;
      case AuxillaryMenu.SETTINGS:
        {
          BlocProvider.of<PageBloc>(context).dispatch(SETTINGS());
        }
        break;
      case AuxillaryMenu.ADDITIONAL:
        {
          BlocProvider.of<PageBloc>(context).dispatch(ADDITIONAL());
        }
        break;
      default:
        {}
    }
  }
}
