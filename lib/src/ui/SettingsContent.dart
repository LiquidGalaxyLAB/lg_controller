import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

/// Content of the settings page.
class SettingsContent extends StatefulWidget {
  SettingsContent();

  @override
  _SettingsContentState createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  /// Loading state of the page.
  bool loading;

  /// Gesture navigation enabled.
  bool gesEnabled = false;

  /// Default KML data.
  KMLData data;

  /// LG connections data.
  List<String> connectionData = List(3);

  @override
  void initState() {
    loading = true;
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        8 + (8 * 0.7 * SizeScaling.getWidthScaling() - 1),
      ),
      child: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
              GestureData(gesEnabled),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 8 + (8 * 0.7 * SizeScaling.getWidthScaling() - 1),
                  horizontal: 4 + (4 * 0.7 * SizeScaling.getWidthScaling() - 1),
                ),
                height: 2,
                color: Colors.black87,
              ),
              Padding(
                padding: EdgeInsets.all(
                  4 + (4 * 0.7 * SizeScaling.getWidthScaling() - 1),
                ),
              ),
              ConnectionData(connectionData),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 8 + (8 * 0.7 * SizeScaling.getWidthScaling() - 1),
                  horizontal: 4 + (4 * 0.7 * SizeScaling.getWidthScaling() - 1),
                ),
                height: 2,
                color: Colors.black87,
              ),
              Padding(
                padding: EdgeInsets.all(4),
              ),
              DefaultData(data, setDefaultData),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 8 + (8 * 0.7 * SizeScaling.getWidthScaling() - 1),
                  horizontal: 4 + (4 * 0.7 * SizeScaling.getWidthScaling() - 1),
                ),
                height: 2,
                color: Colors.black87,
              ),
              Padding(
                padding: EdgeInsets.all(
                  4 + (4 * 0.7 * SizeScaling.getWidthScaling() - 1),
                ),
              ),
              AboutData(),
            ]),
    );
  }

  /// Set default data.
  setDefaultData(KMLData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('defaultData', jsonEncode(data));
    setState(() {
      this.data = data;
    });
  }

  /// Get data from SharedPreferences.
  getData() async {
    await Future.delayed(Duration(seconds: 1));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    gesEnabled = prefs.getBool('gesEnabled');
    if (gesEnabled == null) {
      gesEnabled = true;
      await prefs.setBool('gesEnabled', gesEnabled);
    }
    connectionData[0] = prefs.getString('ip');
    connectionData[1] = prefs.getInt('socket').toString();
    connectionData[2] = prefs.getInt('id').toString();
    String defData = prefs.getString('defaultData');
    if (defData == null) {
      data = new KMLData(
          title: "Default",
          desc: "default",
          latitude: 0,
          longitude: 0,
          bearing: 0,
          zoom: 0,
          tilt: 0);
      defData = jsonEncode(data);
      await prefs.setString('defaultData', defData);
    } else {
      data = KMLData.fromJson(jsonDecode(defData));
    }
    setState(() {
      loading = false;
    });
  }
}

/// Data regarding gestures.
class GestureData extends StatelessWidget {
  final bool gesEnabled;

  GestureData(this.gesEnabled);

  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              "Touch Gestures",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18 + 18 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                  color: Colors.teal,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Enable",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(),
              ),
              Switch(
                value: gesEnabled,
                onChanged: (value) => setGesEnabled(value),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              "Allowed gestures",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "Single finger swipe - Panning across x and y axis.",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 12 + 12 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Pinch action - Zooming.",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 12 + 12 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Two finger swirl - Rotation about z axis.",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 12 + 12 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Two finger vertical swipe - Rotation about x and y axis",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 12 + 12 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          ),
        ]);
  }

  setGesEnabled(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('gesEnabled', val);
  }
}

/// Data regarding connections.
class ConnectionData extends StatelessWidget {
  final List<String> connectionData;

  ConnectionData(this.connectionData);

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Text(
            "Connections",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 18 + 18 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                color: Colors.teal,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "IP address",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                connectionData[0],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Port",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                connectionData[1],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "LG ID",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                connectionData[2],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// About app data.
class AboutData extends StatelessWidget {
  AboutData();

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Text(
            "About",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 18 + 18 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                color: Colors.teal,
                fontWeight: FontWeight.bold),
          ),
        ),
        GestureDetector(
          onTap: () => launchPolicy(),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              "Privacy policy",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Version",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                "1.0.1",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  launchPolicy() async {
    if (await canLaunch("https://www.google.com/")) {
      await launch("https://www.google.com/");
    }
  }
}

// Initial KML data.
class DefaultData extends StatelessWidget {
  final KMLData data;
  final Function setDefaultData;

  DefaultData(this.data, this.setDefaultData);

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Default Data",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        18 + 18 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.teal,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(),
              ),
              IconButton(
                padding: EdgeInsets.all(4),
                iconSize: 24 + 24 * 0.5 * (SizeScaling.getWidthScaling() - 1),
                key: Key('New_Overlay'),
                icon: Icon(IconData(58313, fontFamily: 'MaterialIcons')),
                color: Colors.black54,
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context2) {
                      return DefaultDataDialog(data, setDefaultData);
                    }),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Coordinates",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                data.latitude.toString() + ", " + data.longitude.toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Zoom",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                data.zoom.toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Bearing",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                data.bearing.toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Tilt",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                data.tilt.toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Dialog for setting initial KML data.
class DefaultDataDialog extends StatefulWidget {
  final KMLData data;
  final Function onSave;

  DefaultDataDialog(this.data, this.onSave);

  @override
  _DefaultDataDialogState createState() => _DefaultDataDialogState();
}

class _DefaultDataDialogState extends State<DefaultDataDialog> {
  TextEditingController lat_controller;
  TextEditingController lgt_controller;
  TextEditingController zoom_controller;
  TextEditingController bear_controller;
  TextEditingController tilt_controller;

  @override
  void initState() {
    lat_controller =
        TextEditingController(text: widget.data.latitude.toString());
    lgt_controller =
        TextEditingController(text: widget.data.longitude.toString());
    zoom_controller = TextEditingController(text: widget.data.zoom.toString());
    bear_controller =
        TextEditingController(text: widget.data.bearing.toString());
    tilt_controller = TextEditingController(text: widget.data.tilt.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Please enter details for the default data.',
          style: Theme.of(context).textTheme.title),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel', style: Theme.of(context).textTheme.title),
        ),
        FlatButton(
          onPressed: () {
            KMLData data = new KMLData(
                title: "Default",
                desc: "default",
                latitude: double.parse(lat_controller.text),
                longitude: double.parse(lgt_controller.text),
                bearing: double.parse(bear_controller.text),
                zoom: double.parse(zoom_controller.text),
                tilt: double.parse(tilt_controller.text));
            widget.onSave(data);
            Navigator.of(context).pop();
          },
          child: Text('Save', style: Theme.of(context).textTheme.title),
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 100 + 100 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                  child: TextFormField(
                    controller: lat_controller,
                    validator: (value) {
                      if (value.length == 0 && double.tryParse(value) != null)
                        return 'Enter a valid value.';
                    },
                    autovalidate: true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    autocorrect: true,
                    decoration: new InputDecoration(
                      labelText: "Latitude",
                    ),
                    maxLines: 1,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                Container(
                  width: 100 + 100 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                  child: TextFormField(
                    controller: lgt_controller,
                    validator: (value) {
                      if (value.length == 0 && double.tryParse(value) != null)
                        return 'Enter a valid value.';
                    },
                    autovalidate: true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    autocorrect: true,
                    decoration: new InputDecoration(
                      labelText: "Longitude",
                    ),
                    maxLines: 1,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 100 + 100 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                  child: TextFormField(
                    controller: zoom_controller,
                    validator: (value) {
                      if (value.length == 0 && double.tryParse(value) != null)
                        return 'Enter a valid value.';
                    },
                    autovalidate: true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    autocorrect: true,
                    decoration: new InputDecoration(
                      labelText: "Zoom",
                    ),
                    maxLines: 1,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                Container(
                  width: 100 + 100 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                  child: TextFormField(
                    controller: bear_controller,
                    validator: (value) {
                      if (value.length == 0 && double.tryParse(value) != null)
                        return 'Enter a valid value.';
                    },
                    autovalidate: true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    autocorrect: true,
                    decoration: new InputDecoration(
                      labelText: "Bearing",
                    ),
                    maxLines: 1,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                Container(
                  width: 100 + 100 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                  child: TextFormField(
                    controller: tilt_controller,
                    validator: (value) {
                      if (value.length == 0 && double.tryParse(value) != null)
                        return 'Enter a valid value.';
                    },
                    autovalidate: true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    autocorrect: true,
                    decoration: new InputDecoration(
                      labelText: "Tilt",
                    ),
                    maxLines: 1,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
