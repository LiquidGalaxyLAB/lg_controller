import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/blocs/KMLFilesBloc.dart';
import 'package:lg_controller/src/blocs/NavBarBloc.dart';
import 'package:lg_controller/src/gdrive/FileRequests.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/resources/SQLDatabase.dart';
import 'package:lg_controller/src/states_events/NavBarActions.dart';
import 'package:lg_controller/src/ui/KMLGridContent.dart';
import 'package:lg_controller/src/ui/NavBar.dart';
import 'package:lg_controller/src/ui/ScreenBackground.dart';
import 'package:lg_controller/src/ui/SearchBar.dart';
import 'package:lg_controller/src/ui/TitleBar.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// Tour screen root.
class TourPage extends StatefulWidget {
  TourPage();

  @override
  _TourPageState createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  final NavBarBloc nvBloc = NavBarBloc();
  final KMLFilesBloc fBloc =
      KMLFilesBloc(FileRequests(), SQLDatabase(), MainMenu.TOURS);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: ScreenBackground.getBackgroundDecoration(),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 64 * SizeScaling.getHeightScaling(),
                  child: TitleBar(MainMenu.TOURS),
                ),
                Expanded(
                  child: BlocProviderTree(
                    blocProviders: [
                      BlocProvider<NavBarBloc>(bloc: nvBloc),
                      BlocProvider<KMLFilesBloc>(bloc: fBloc),
                    ],
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 8, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 164 * SizeScaling.getWidthScaling(),
                            child: Container(
                              color: Colors.blueGrey[800],
                              child: NavBar(MainMenu.TOURS),
                            ),
                          ),
                          SizedBox(
                            width: 4 +
                                4 * 0.5 * (SizeScaling.getWidthScaling() - 1),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                SearchWidget(),
                                Expanded(
                                  child: KMLGridContent(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 4 +
                                4 * 0.5 * (SizeScaling.getWidthScaling() - 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Search bar of the Tour screen.
class SearchWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return SearchBar(
        (() => BlocProvider.of<NavBarBloc>(context).dispatch(RECENTLY())),
        ((searchText) => BlocProvider.of<NavBarBloc>(context)
            .dispatch(SEARCH(searchText, MainMenu.TOURS))),
        () => {});
  }
}
