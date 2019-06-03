import 'package:flutter/material.dart';
import 'package:lg_controller/src/models/POIData.dart';
import 'package:lg_controller/src/ui/KMLModuleView.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/states_events/NavBarActions.dart';
import 'package:lg_controller/src/blocs/NavBarBloc.dart';
import 'package:lg_controller/src/states_events/KMLFilesActions.dart';
import 'package:lg_controller/src/blocs/KMLFilesBloc.dart';

class POIContent extends StatelessWidget {

  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<NavBarEvent, NavBarState>(
            bloc: BlocProvider.of<NavBarBloc>(context),
            builder: (BuildContext context, NavBarState state) {
              if ("Recently Viewed".compareTo(state.toString())==0) {
                return GridContent();
              }
              else {
                return GridView.builder(
                  itemCount: 16,
                  scrollDirection: Axis.vertical,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.667,
                    crossAxisCount: ((MediaQuery.of(context).size.width - 176) ~/ 128),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return new KMLModuleView(
                        new POIData("Test " + index.toString(), "Trial description"));
                  },
                );
              }
            },
          ),
    );
  }
}
class GridContent extends StatelessWidget {

  Widget build(BuildContext context) {
    return BlocBuilder<KMLFilesEvent, KMLFilesState>(
        bloc: BlocProvider.of<KMLFilesBloc>(context),
        builder: (BuildContext context, KMLFilesState state) {
          if(state is LoadingState)
          {return Text("Loading..", style: Theme.of(context).textTheme.body1);}
          else if(state is ErrorState)
          {return Text("Error.", style: Theme.of(context).textTheme.body1);}
          else if(state is LoadedState)
          {
            return GridView.builder(
              itemCount: state.data.length,
              scrollDirection: Axis.vertical,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.667,
                crossAxisCount: ((MediaQuery.of(context).size.width - 176) ~/ 128),
              ),
              itemBuilder: (BuildContext context, int index) {
                return new KMLModuleView(
                    state.data[index]);
              },
            );
          }
          else
          {BlocProvider.of<KMLFilesBloc>(context).dispatch(GET_FILES());
          return Text("Uninitialized..", style: Theme.of(context).textTheme.body1);}
        });
  }
}
