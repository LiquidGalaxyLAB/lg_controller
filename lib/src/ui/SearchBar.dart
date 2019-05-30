import 'package:flutter/material.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/ui/MainMenuBar.dart';
import 'package:lg_controller/src/ui/AuxillaryMenuBar.dart';
import 'package:lg_controller/src/ui/AppTitle.dart';
import 'package:lg_controller/src/models/KMLData.dart';

class SearchBar extends StatelessWidget {

  TextEditingController controller = TextEditingController();

  Widget build(BuildContext context) {
    controller.addListener(() {
      //TODO: Add prediction dropdown.
    });
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: SizedBox(height: 42,width:240,
        child: Card(color: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            child:Center(
            child:TextField(
            controller: controller,
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(new FocusNode());
                //TODO: Add search operation.
              },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            autocorrect: true,
            decoration: new InputDecoration.collapsed(
                hintText: "Search..",
                hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black54),
            ),
            maxLines: 1,
            style: Theme
                .of(context)
                .textTheme
                .title,
          ),),),
        ),
      ),
    );
  }

}