import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/blocs/NavBarBloc.dart';
import 'package:lg_controller/src/states_events/NavBarActions.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final FocusNode focus = new FocusNode();
  String searchText = "";

  Widget build(BuildContext context) {
    controller.addListener(() {
      //TODO: Add prediction dropdown.
    });
    focus.addListener(() {
      if (focus.hasFocus)
        BlocProvider.of<NavBarBloc>(context).dispatch(SEARCH(searchText));
      if (!focus.hasFocus && searchText.compareTo("") == 0)
        BlocProvider.of<NavBarBloc>(context).dispatch(RECENTLY());
    });
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: SizedBox(
        height: 42,
        width: 240,
        child: Card(
          color: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21.0),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                  child: Center(
                    child: TextField(
                      controller: controller,
                      onSubmitted: (value) {
                        searchText = value;
                        FocusScope.of(context).requestFocus(new FocusNode());
                        BlocProvider.of<NavBarBloc>(context)
                            .dispatch(SEARCH(searchText));
                      },
                      focusNode: focus,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      autocorrect: true,
                      decoration: new InputDecoration.collapsed(
                        hintText: "Search..",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black54),
                      ),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(IconData(0xe5cd, fontFamily: 'MaterialIcons'),
                    color: Colors.black54),
                onPressed: () {
                  controller.clear();
                  FocusScope.of(context).requestFocus(new FocusNode());
                  BlocProvider.of<NavBarBloc>(context).dispatch(RECENTLY());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
