import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Dialog to request OSC params.
class OSCDialog extends StatefulWidget {
  /// To be called when necessary params have been validated.
  final Function setParams;

  OSCDialog(this.setParams);

  @override
  _OSCDialogState createState() => _OSCDialogState();
}

class _OSCDialogState extends State<OSCDialog> {
  final ip_key = GlobalKey<FormFieldState>();
  final soc_key = GlobalKey<FormFieldState>();
  final id_key = GlobalKey<FormFieldState>();
  final FocusNode soc_node = FocusNode();
  final FocusNode id_node = FocusNode();
  final TextEditingController ip_controller = TextEditingController();
  final TextEditingController soc_controller =
      TextEditingController(text: '8113');
  final TextEditingController id_controller = TextEditingController();

  /// To show loading of the dialog.
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: AlertDialog(
        title: Text('Please enter the name of module to be saved.',
            style: Theme.of(context).textTheme.title),
        actions: <Widget>[
          (loading)
              ? CircularProgressIndicator()
              : FlatButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    await Future.delayed(Duration(seconds: 1));
                    if (ip_key.currentState.validate() &&
                        soc_key.currentState.validate() &&
                        id_key.currentState.validate())
                      await widget.setParams(ip_controller.text,
                          soc_controller.text, id_controller.text);
                    else
                      setState(() {
                        loading = false;
                      });
                  },
                  child: Text('Ok', style: Theme.of(context).textTheme.title),
                ),
        ],
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextFormField(
                key: ip_key,
                controller: ip_controller,
                validator: (value) {
                  if (value.length == 0 || value.split('.').length != 4)
                    return 'Enter a valid value.';
                },
                autovalidate: true,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(soc_node);
                },
                autocorrect: true,
                decoration: new InputDecoration(
                  labelText: "IP address",
                ),
                maxLines: 1,
                style: Theme.of(context).textTheme.title,
              ),
              Padding(padding: EdgeInsets.all(4.0)),
              TextFormField(
                key: soc_key,
                focusNode: soc_node,
                controller: soc_controller,
                validator: (value) {
                  if (value.length == 0 && int.tryParse(value) == null)
                    return 'Enter a valid value.';
                },
                autovalidate: true,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(id_node);
                },
                autocorrect: true,
                decoration: new InputDecoration(
                  labelText: "Socket",
                ),
                maxLines: 1,
                style: Theme.of(context).textTheme.title,
              ),
              Padding(padding: EdgeInsets.all(4.0)),
              TextFormField(
                key: id_key,
                focusNode: id_node,
                controller: id_controller,
                validator: (value) {
                  if (value.length == 0 && int.tryParse(value) == null)
                    return 'Enter a valid value.';
                },
                autovalidate: true,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autocorrect: true,
                decoration: new InputDecoration(
                  labelText: "LG ID",
                ),
                maxLines: 1,
                style: Theme.of(context).textTheme.title,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
