import 'package:flutter/material.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';

class MainMenuBar extends StatelessWidget {

  MainMenu state;
  MainMenuBar(this.state);

  Widget build(BuildContext context) {
    return Container(
            child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: getLabels(context),
              ),
            );
  }
  List<Widget> getLabels(context)
  {
    List<Widget> list = new List<Widget>();
    for(var ic in MainMenu.values()){
      list.add(
          Column(
            children: <Widget>[
              GestureDetector(
              onTap: () {labelSelected(ic);},
          child:Container(
              child:
              Text(ic.title, style: Theme
                .of(context)
                .textTheme
                .body1),
          ),),
          state==ic?Hero(tag:"tab_underline",child:Container(color: Colors.white,width: 40,height: 1.0,),):Container()
          ]
        ),
      );
    }
    return list;
  }
  labelSelected(MainMenu ic)
  {
    switch(ic)
    {
      case MainMenu.HOME:
        {}
        break;
      case MainMenu.TOURS:
        {}
        break;
      case MainMenu.POI:
        {}
        break;
      case MainMenu.GUIDE:
        {}
        break;
      case MainMenu.OVERLAY:
        {}
        break;
      default:
        {}
    }
  }
}