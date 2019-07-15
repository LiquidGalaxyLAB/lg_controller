import 'package:flutter/material.dart';
import 'package:lg_controller/src/menu/FlyToMenu.dart';
import 'package:lg_controller/src/osc/ModuleType.dart';
import 'package:lg_controller/src/osc/OSCActions.dart';
import 'package:lg_controller/src/utils/Images.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// App title widget.
class AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Tooltip(
        message: "Fly To",
        child: Column(children: <Widget>[
          Hero(
            tag: "app_title",
            child: GestureDetector(
              onTap: () => onFlyTo(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 12 * SizeScaling.getWidthScaling(),
                    backgroundColor: Colors.transparent,
                    backgroundImage: Images.APP_LOGO,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.0),
                  ),
                  RawMaterialButton(
                    onPressed: () => onFlyTo(context),
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    constraints: BoxConstraints(
                        minHeight: 28,
                        minWidth:
                            88 + 32 * (SizeScaling.getWidthScaling() - 1)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Text('LG Controller',
                        style: Theme.of(context).textTheme.body2),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  /// Show dialog with Fly to options.
  onFlyTo(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 300 * SizeScaling.getWidthScaling(),
            height: 80 * SizeScaling.getWidthScaling(),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: getIcons(context),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Get icons for the Fly to options.
  List<Widget> getIcons(context) {
    List<Widget> list = new List<Widget>();
    for (var ic in FlyToMenu.values()) {
      list.add(
        GestureDetector(
          key: Key('AppTitle_items_' + ic.title),
          onTap: () {
            iconSelected(ic);
            Navigator.of(context).pop();
          },
          child: CircleAvatar(
            maxRadius: 30 * SizeScaling.getWidthScaling(),
            minRadius: 24 * SizeScaling.getWidthScaling(),
            backgroundColor: Colors.transparent,
            backgroundImage: ic.image,
          ),
        ),
      );
      list.add(Padding(padding: EdgeInsets.all(8)));
    }
    list.removeLast();
    return list;
  }

  /// Initiate OSC action for the [ic] option selected.
  iconSelected(FlyToMenu ic) {
    switch (ic) {
      case FlyToMenu.EARTH:
        {
          OSCActions().sendModule(ModuleType.FLYTO, ic.title);
        }
        break;
      case FlyToMenu.MARS:
        {
          OSCActions().sendModule(ModuleType.FLYTO, ic.title);
        }
        break;
      case FlyToMenu.MOON:
        {
          OSCActions().sendModule(ModuleType.FLYTO, ic.title);
        }
        break;
      case FlyToMenu.SKY:
        {
          OSCActions().sendModule(ModuleType.FLYTO, ic.title);
        }
        break;
      default:
        {}
    }
  }
}
