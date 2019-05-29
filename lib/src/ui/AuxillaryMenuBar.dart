import 'package:flutter/material.dart';
import 'package:lg_controller/src/menu/AuxillaryMenu.dart';
import 'package:lg_controller/src/blocs/PageBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/states_events/PageActions.dart';

class AuxillaryMenuBar extends StatelessWidget {

  Widget build(BuildContext context) {
    return Container(
        child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: getIcons(context),
              ),
    );
  }
  List<Widget> getIcons(context)
  {
    List<Widget> list = new List<Widget>();
    for(var ic in AuxillaryMenu.values()){
      list.add(
          Expanded(flex: 10,child:IconButton(
            icon: ic.icon,
            tooltip: ic.title,
            onPressed: () =>iconSelected(ic,context),
          )
      ),);
      list.add(Expanded(flex: 5,child:SizedBox(width: 5,)));
    }
    return list;
  }
  iconSelected(AuxillaryMenu ic,context)
  {
    switch(ic)
    {
      case AuxillaryMenu.PROFILE:
        {BlocProvider.of<PageBloc>(context).dispatch(PageEvent.PROFILE);}
        break;
      case AuxillaryMenu.SETTINGS:
        {BlocProvider.of<PageBloc>(context).dispatch(PageEvent.SETTINGS);}
        break;
      case AuxillaryMenu.ADDITIONAL:
        {BlocProvider.of<PageBloc>(context).dispatch(PageEvent.ADDITIONAL);}
        break;
      default:
        {}
    }
  }
}