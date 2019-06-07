import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final FocusNode focus = new FocusNode();
  ClearOption clearOption = new ClearOption();
  String searchText = "";
  Function onClear, onSearch;

  SearchBar(this.onClear, this.onSearch);

  Widget build(BuildContext context) {
    clearOption.clearOptionsState.setClearAction(onClearField);
    controller.addListener(() => onShowPrediction(controller.text));
    focus.addListener(() {
      if (focus.hasFocus) onClear();
      if (!focus.hasFocus && searchText.compareTo("") == 0)
        onSearch(searchText);
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
              clearOption,
            ],
          ),
        ),
      ),
    );
  }

  onClearField(context) {
    controller.clear();
    FocusScope.of(context).requestFocus(new FocusNode());
    onClear();
  }

  onShowPrediction(value) {
    if (value.compareTo("") != 0) {
      clearOption.clearOptionsState.setCurrentWidget(true);
      searchText = value;
      onSearch(searchText);
    } else
      clearOption.clearOptionsState.setCurrentWidget(false);
  }
}

class ClearOption extends StatefulWidget {
  final _ClearOptionState clearOptionsState = _ClearOptionState();

  @override
  _ClearOptionState createState() => clearOptionsState;
}

class _ClearOptionState extends State<ClearOption> {
  Function clear;
  bool closeEnable = false;

  setClearAction(Function clear) {
    this.clear = clear;
  }

  setCurrentWidget(bool val) {
    setState(() => closeEnable = val);
  }

  @override
  Widget build(BuildContext context) {
    return (closeEnable)
        ? IconButton(
            icon: Icon(IconData(0xe5cd, fontFamily: 'MaterialIcons'),
                color: Colors.black54),
            onPressed: () => clear(context),
          )
        : Container();
  }
}
