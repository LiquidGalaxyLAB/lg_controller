import 'package:flutter/material.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/utils/Images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/states_events/PageActions.dart';
import 'package:lg_controller/src/blocs/PageBloc.dart';

class KMLModuleView extends StatelessWidget {

  KMLData data;
  KMLModuleView(this.data);

  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child:SizedBox(height: 60, width: 100,
        child:Hero(
          tag:'KML_View_Card'+data.getTitle()+data.getDesc(),
          child:GestureDetector(
            onTap: () => moduleSelected(context),
            child:Card(
            color: Colors.white70,
            child: Container(
              padding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 16,
                    backgroundColor: Colors.transparent,
                    backgroundImage: Images.APP_LOGO,
                  ),
                  Padding(padding: EdgeInsets.only(left: 6.0)),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(data.getTitle(),style: TextStyle(
                            fontSize: 14, color: Colors.black54, fontWeight: FontWeight.bold),),
                        Text(data.getDesc(), overflow:TextOverflow.ellipsis,maxLines: 2,style:TextStyle(
                            fontSize: 10, color: Colors.black54, fontWeight: FontWeight.bold),),
                      ]),
                ],
              ),
            ),
          ),),),
      ),
    );
  }
  moduleSelected(context)
  {
    BlocProvider.of<PageBloc>(context).dispatch(HOME(data));
  }
}