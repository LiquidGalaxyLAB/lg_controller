import 'package:flutter/material.dart';
import 'package:lg_controller/src/menu/AuxillaryMenu.dart';

class AuxillaryMenuBar extends StatelessWidget {

  Widget build(BuildContext context) {
    return Container(
        child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: getIcons(),
              ),
    );
  }
  List<Widget> getIcons()
  {
    List<Widget> list = new List<Widget>();
    for(var ic in AuxillaryMenu.values()){
      list.add(
          Expanded(flex: 10,child:IconButton(
            icon: ic.icon,
            tooltip: ic.title,
            onPressed: iconSelected(ic),
          )
      ),);
      list.add(Expanded(flex: 5,child:SizedBox(width: 5,)));
    }
    return list;
  }
  iconSelected(AuxillaryMenu ic)
  {
    switch(ic)
    {
      case AuxillaryMenu.PROFILE:
        {}
        break;
      case AuxillaryMenu.SETTINGS:
        {}
        break;
      case AuxillaryMenu.ADDITIONAL:
        {}
        break;
      default:
        {}
    }
  }
}