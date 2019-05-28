import 'package:flutter/material.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/ui/MainMenuBar.dart';
import 'package:lg_controller/src/ui/AuxillaryMenuBar.dart';
import 'package:lg_controller/src/ui/AppTitle.dart';

class TitleBar extends StatelessWidget {

  MainMenu state;
  TitleBar(this.state);

  Widget build(BuildContext context) {
    return Container(
        padding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
        child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(flex: 12,child:AppTitle()),
                  Expanded(flex: 2,child:SizedBox(width: 5,)),
                  Expanded(flex: 20,child:MainMenuBar(state)),
                  Expanded(flex: 2,child:SizedBox(width: 5,)),
                  Expanded(flex: 8,child:AuxillaryMenuBar()),
                ],
              ),
            ]
        )

    );
  }
}