import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/blocs/KMLFilesBloc.dart';
import 'package:lg_controller/src/blocs/NavBarBloc.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/states_events/KMLFilesActions.dart';
import 'package:lg_controller/src/states_events/NavBarActions.dart';
import 'package:lg_controller/src/ui/KMLModuleView.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// Content of POI screen.
class POIContent extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<NavBarEvent, NavBarState>(
        bloc: BlocProvider.of<NavBarBloc>(context),
        builder: (BuildContext context, NavBarState state) {
          return GridContent(state);
        },
      ),
    );
  }
}

/// Grid view of the KML modules.
class GridContent extends StatelessWidget {
  /// Current Nav bar selection.
  final NavBarState choice;

  GridContent(this.choice);

  Widget build(BuildContext context) {
    return BlocBuilder<KMLFilesEvent, KMLFilesState>(
        bloc: BlocProvider.of<KMLFilesBloc>(context),
        builder: (BuildContext context, KMLFilesState state) {
          if (state is LoadingState) {
            return Text("Loading..", style: Theme.of(context).textTheme.body1);
          } else if (state is ErrorState) {
            return Text("Error.", style: Theme.of(context).textTheme.body1);
          } else if (state is LoadedState) {
            List<KMLData> content;
            if (choice is SearchState)
              content = (choice as SearchState).searchData;
            else
              content = state.data[choice.toString()];
            return GridView.builder(
              itemCount: content.length,
              padding: EdgeInsets.all(
                  4 + 4 * 0.5 * (SizeScaling.getWidthScaling() - 1)),
              scrollDirection: Axis.vertical,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.667,
                crossAxisCount: ((426 * SizeScaling.getHeightScaling()) ~/
                        (128 * SizeScaling.getHeightScaling()))
                    .toInt(),
              ),
              itemBuilder: (BuildContext context, int index) {
                return new KMLModuleView(choice, content[index]);
              },
            );
          } else {
            BlocProvider.of<KMLFilesBloc>(context).dispatch(GET_FILES());
            return Text("Uninitialized..",
                style: Theme.of(context).textTheme.body1);
          }
        });
  }
}
