import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/blocs/PageBloc.dart';
import 'package:lg_controller/src/states_events/PageActions.dart';
import 'package:lg_controller/src/ui/ScreenBackground.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Tutorial screen root.
class TutorialPage extends StatefulWidget {
  TutorialPage();

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> with NavigatorObserver {
  @override
  void initState() {
    super.initState();
    checkOSCParams();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: ScreenBackground.getBackgroundDecoration(),
          child: Center(
            child: Container(),
          ),
        ),
      ),
    );
  }

  /// Check if the user launches app for 1st time.
  bool isFirstTime() {
    return false;
  }

  void checkOSCParams() {
    SharedPreferences.getInstance().then((prefs) async {
      final dataString = prefs.getString('ip') ?? '';
      if ((dataString.compareTo('')) == 0) {
        await setOSCParams();
      } else {
        if (!isFirstTime()) {
          BlocProvider.of<PageBloc>(context).dispatch(HOME(null));
        }
      }
    });
  }

  setOSCParams() {
    final ip_key = GlobalKey<FormFieldState>();
    final soc_key = GlobalKey<FormFieldState>();
    final id_key = GlobalKey<FormFieldState>();
    final FocusNode soc_node = FocusNode();
    final FocusNode id_node = FocusNode();
    final TextEditingController ip_controller = TextEditingController();
    final TextEditingController soc_controller =
        TextEditingController(text: '3000');
    final TextEditingController id_controller = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => SystemNavigator.pop(),
          child: AlertDialog(
            title: Text('Enter the name of module to be saved.',
                style: Theme.of(context).textTheme.title),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  if (ip_key.currentState.validate() &&
                      soc_key.currentState.validate() &&
                      id_key.currentState.validate())
                    setParams(ip_controller.text, soc_controller.text,
                        id_controller.text);
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
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
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
      },
    );
  }

  void setParams(String ip, String soc, String lgid) {
    try {
      if (!isFirstTime()) {
        BlocProvider.of<PageBloc>(context).dispatch(HOME(null));
      }
      int socket = int.parse(soc);
      int id = int.parse(lgid);
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('ip', ip);
        prefs.setInt('socket', socket);
        prefs.setInt('id', id);
      });
    } catch (e) {
      print('Error : In setting OSC params.');
    }
  }
}
