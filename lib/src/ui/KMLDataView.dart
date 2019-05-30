import 'package:flutter/material.dart';
import 'package:lg_controller/src/ui/SearchBar.dart';
import 'package:lg_controller/src/models/KMLData.dart';

class KMLDataView extends StatelessWidget {

  KMLData data;
  KMLDataView(this.data);

  Widget build(BuildContext context) {
    return Container(
        padding: new EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
        child:SizedBox(height: 80, width: 300,
          child:Card(child:Text(data.title,style:Theme
              .of(context)
              .textTheme
              .title,),color:Colors.white),),
    );
  }
}