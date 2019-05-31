import 'package:flutter/material.dart';
import 'package:lg_controller/src/ui/SearchBar.dart';
import 'package:lg_controller/src/ui/NavigationView.dart';
import 'package:lg_controller/src/ui/KMLDataView.dart';
import 'package:lg_controller/src/models/KMLData.dart';

class HomeContent extends StatelessWidget {

  KMLData data;
  HomeContent(this.data);

  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SearchBar(),
              (data!=null)?KMLDataView(data):Container(),
              Expanded(child: NavigationView(),),
            ]
        )

    );
  }
}