import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/blocs/FreezeBloc.dart';
import 'package:lg_controller/src/blocs/PointBloc.dart';
import 'package:lg_controller/src/menu/OverlayMenu.dart';
import 'package:lg_controller/src/menu/POINavBarMenu.dart';
import 'package:lg_controller/src/models/OverlayData.dart';
import 'package:lg_controller/src/resources/SQLDatabase.dart';
import 'package:lg_controller/src/states_events/OverlayActions.dart';
import 'package:lg_controller/src/states_events/PointActions.dart';
import 'package:lg_controller/src/ui/AttributeDialog.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';
import 'package:toast/toast.dart';

/// overlay menu bar widget.
class OverlayMenuBar extends StatelessWidget {
  /// Current selected menu.
  OverlayMenu selected;

  OverlayMenuBar();

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Card(
          elevation: 4,
          child: BlocBuilder<PointEvent, PointState>(
              bloc: BlocProvider.of<PointBloc>(context),
              builder: (BuildContext context, PointState state) {
                return BlocBuilder<OverlayEvent, OverlaysState>(
                    bloc: BlocProvider.of<FreezeBloc>(context),
                    builder: (BuildContext context, OverlaysState state) {
                      if (state is FrozenState)
                        selected = state.menu;
                      else if (state is UnfrozenState)
                        selected = OverlayMenu.PAN;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: getIcons(context),
                      );
                    });
              }),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.white70),
    );
  }

  /// Get icons for the overlay menu options.
  List<Widget> getIcons(context) {
    List<Widget> list = new List<Widget>();
    for (var ic in OverlayMenu.values()) {
      list.add(
        Expanded(
          flex: 10,
          child: (ic == OverlayMenu.POLYGON)
              ? GestureDetector(
                  onLongPress: () => showDialog(
                      context: context,
                      builder: (BuildContext context2) {
                        return AttributeDialog();
                      }),
                  child: IconButton(
                    iconSize:
                        24 + 24 * 0.5 * (SizeScaling.getWidthScaling() - 1),
                    key: Key('OverlayMenu_items_' + ic.title),
                    icon: ic.icon,
                    color: (selected == ic) ? Colors.teal : Colors.black54,
                    onPressed: () => iconSelected(ic, context),
                  ),
                )
              : IconButton(
                  iconSize: 24 + 24 * 0.5 * (SizeScaling.getWidthScaling() - 1),
                  key: Key('OverlayMenu_items_' + ic.title),
                  icon: ic.icon,
                  color: (selected == ic) ? Colors.teal : Colors.black54,
                  onPressed: () => iconSelected(ic, context),
                  tooltip: ic.title,
                ),
        ),
      );

      list.add(
        Expanded(
          flex: 5,
          child: SizedBox(
            height: 5,
          ),
        ),
      );
    }
    return list;
  }

  /// Initiate overlay menu event for [ic] selected.
  iconSelected(OverlayMenu ic, context) {
    switch (ic) {
      case OverlayMenu.LINE:
        {
          BlocProvider.of<FreezeBloc>(context)
              .dispatch(FREEZE(OverlayMenu.LINE));
        }
        break;
      case OverlayMenu.POLYGON:
        {
          BlocProvider.of<FreezeBloc>(context)
              .dispatch(FREEZE(OverlayMenu.POLYGON));
        }
        break;
      case OverlayMenu.ROUND_TEMP:
        {
          BlocProvider.of<FreezeBloc>(context)
              .dispatch(FREEZE(OverlayMenu.ROUND_TEMP));
        }
        break;
      case OverlayMenu.IMAGE:
        {
          BlocProvider.of<FreezeBloc>(context)
              .dispatch(FREEZE(OverlayMenu.IMAGE));
        }
        break;
      case OverlayMenu.PAN:
        {
          BlocProvider.of<FreezeBloc>(context).dispatch(UNFREEZE(null));
        }
        break;
      case OverlayMenu.SAVE:
        {
          OverlayData data = OverlayData.fromKMLData(
              BlocProvider.of<FreezeBloc>(context).data);
          data.itemData = BlocProvider.of<PointBloc>(context).data;
          BlocProvider.of<FreezeBloc>(context).dispatch(UNFREEZE(null));
          onSaveInitiate(context, data);
        }
        break;
      default:
        {}
    }
  }

  /// Save the [data] passed.
  onSave(context, OverlayData data, String title, String desc, String url) {
    try {
      if (title != null && title.compareTo("") != 0)
        data.title = title;
      else
        data.title = "Default Title";
      if (desc != null && desc.compareTo("") != 0)
        data.desc = desc;
      else
        data.desc = "Default Desc";
      if (url != null)
        data.imageUrl = url;
      else
        data.imageUrl = "";

      List<OverlayData> list = List();
      list.add(data);
      SQLDatabase().insertInTable(POINavBarMenu.PRIVATE_1.title, list);
      Navigator.of(context).pop();
      Toast.show(
        'KML successfully saved in your private directory.',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
    } catch (e) {
      Toast.show(
        'Some error occured. Please try again.',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
    }
  }

  /// Initiate save action.
  onSaveInitiate(context, OverlayData data) {
    final FocusNode desc_node = FocusNode();
    final FocusNode url_node = FocusNode();
    String title = "Default Title";
    String desc = "Default Desc";
    String url = "";
    final TextEditingController title_controller =
        TextEditingController(text: title);
    final TextEditingController desc_controller =
        TextEditingController(text: desc);
    final TextEditingController url_controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter the name of module to be saved.',
              style: Theme.of(context).textTheme.title),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: Theme.of(context).textTheme.title),
            ),
            FlatButton(
              onPressed: () => onSave(context, data, title, desc, url),
              child: Text('Save', style: Theme.of(context).textTheme.title),
            ),
          ],
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextField(
                  controller: title_controller,
                  onSubmitted: (value) {
                    title = value;
                    FocusScope.of(context).requestFocus(desc_node);
                  },
                  onChanged: (value) {
                    title = value;
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autocorrect: true,
                  decoration: new InputDecoration(
                    labelText: "Title..",
                  ),
                  maxLines: 1,
                  style: Theme.of(context).textTheme.title,
                ),
                Padding(padding: EdgeInsets.all(4.0)),
                TextField(
                  controller: desc_controller,
                  focusNode: desc_node,
                  onSubmitted: (value) {
                    desc = value;
                    FocusScope.of(context).requestFocus(url_node);
                  },
                  onChanged: (value) {
                    desc = value;
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autocorrect: true,
                  decoration: new InputDecoration(
                    labelText: "Description..",
                  ),
                  maxLines: 3,
                  style: Theme.of(context).textTheme.title,
                ),
                TextField(
                  controller: url_controller,
                  focusNode: url_node,
                  onSubmitted: (value) {
                    url = value;
                  },
                  onChanged: (value) {
                    url = value;
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autocorrect: true,
                  decoration: new InputDecoration(
                    labelText: "Image URL",
                  ),
                  maxLines: 1,
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
