import 'package:flutter/material.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// Search bar widget.
class SearchBar extends StatelessWidget {
  /// Controller for text field.
  final TextEditingController controller = TextEditingController();

  /// Focus controller of the text field.
  final FocusNode focus = new FocusNode();

  /// Clear option widget.
  ClearOption clearOption = new ClearOption();

  /// Search query text.
  String searchText = "";

  /// To be executed on clearing text field.
  Function onClear;

  /// To be executed on searching the query.
  Function onSearch;

  /// To be executed on completing search tasks.
  Function onComplete;

  SearchBar(this.onClear, this.onSearch, this.onComplete);

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
        height: 42 + 42 * 0.8 * (SizeScaling.getWidthScaling() - 1),
        width: 240 * SizeScaling.getWidthScaling(),
        child: Card(
          color: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                21 + 21.0 * 0.8 * (SizeScaling.getWidthScaling() - 1)),
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
                        onComplete(searchText);
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

  /// Clear text field.
  onClearField(context) {
    controller.clear();
    FocusScope.of(context).requestFocus(new FocusNode());
    onClear();
  }

  /// Show predictions on search query.
  onShowPrediction(value) {
    if (value.compareTo("") != 0) {
      clearOption.clearOptionsState.setCurrentWidget(true);
      searchText = value;
      onSearch(searchText);
    } else
      clearOption.clearOptionsState.setCurrentWidget(false);
  }
}

/// Widget for clearing search text field.
class ClearOption extends StatefulWidget {
  final _ClearOptionState clearOptionsState = _ClearOptionState();

  @override
  _ClearOptionState createState() => clearOptionsState;
}

class _ClearOptionState extends State<ClearOption> {
  /// To be executed on selecting this widget.
  Function clear;

  /// Enabling state of clear option.
  bool closeEnable = false;

  /// Set clear functionality.
  setClearAction(Function clear) {
    this.clear = clear;
  }

  /// Set enabling state [closeEnable] of clear option.
  setCurrentWidget(bool val) {
    setState(() => closeEnable = val);
  }

  @override
  Widget build(BuildContext context) {
    return (closeEnable)
        ? IconButton(
            iconSize: 24 + 24 * 0.5 * (SizeScaling.getWidthScaling() - 1),
            icon: Icon(IconData(0xe5cd, fontFamily: 'MaterialIcons'),
                color: Colors.black54),
            onPressed: () => clear(context),
          )
        : Container();
  }
}
