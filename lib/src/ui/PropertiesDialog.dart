import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_controller/src/menu/OverlayMenu.dart';
import 'package:lg_controller/src/models/PlacemarkData.dart';

/// Dialog for Properties.
class PropertiesDialog extends StatefulWidget {
  final Marker marker;
  final OverlayMenu menu;
  final Function onSave;
  final Function onDelete;

  PropertiesDialog(this.marker, this.menu, this.onSave, this.onDelete);

  @override
  _PropertiesDialogState createState() => _PropertiesDialogState();
}

class _PropertiesDialogState extends State<PropertiesDialog> {
  TextEditingController title_controller;
  TextEditingController desc_controller;
  TextEditingController lat_controller;
  TextEditingController lgt_controller;
  TextEditingController zInd_controller;

  @override
  void initState() {
    title_controller =
        TextEditingController(text: widget.marker.infoWindow.title);
    desc_controller =
        TextEditingController(text: widget.marker.infoWindow.snippet);
    lat_controller =
        TextEditingController(text: widget.marker.position.latitude.toString());
    lgt_controller = TextEditingController(
        text: widget.marker.position.longitude.toString());
    zInd_controller =
        TextEditingController(text: widget.marker.zIndex.toString());
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
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel', style: Theme.of(context).textTheme.title),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onDelete();
            },
            child: Text('Delete', style: Theme.of(context).textTheme.title),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              PlacemarkData data = PlacemarkData(
                  LatLng(double.tryParse(lat_controller.text),
                      double.tryParse(lgt_controller.text)),
                  widget.marker.markerId.value,
                  title_controller.text,
                  desc_controller.text,
                  double.tryParse(zInd_controller.text));
              widget.onSave(data);
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
                    width: 200,
                    child: TextFormField(
                      controller: title_controller,
                      validator: (value) {
                        if (value.length == 0) return 'Enter a valid value.';
                      },
                      autovalidate: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      autocorrect: true,
                      decoration: new InputDecoration(
                        labelText: "Title",
                      ),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  Container(
                    width: 200,
                    child: TextFormField(
                      controller: desc_controller,
                      validator: (value) {
                        if (value.length == 0) return 'Enter a valid value.';
                      },
                      autovalidate: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      autocorrect: true,
                      decoration: new InputDecoration(
                        labelText: "Description",
                      ),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 100,
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
                    width: 100,
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
                  Padding(padding: EdgeInsets.all(8.0)),
                  Container(
                    width: 100,
                    child: TextFormField(
                      controller: zInd_controller,
                      validator: (value) {
                        if (value.length == 0 && double.tryParse(value) != null)
                          return 'Enter a valid value.';
                      },
                      autovalidate: true,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      autocorrect: true,
                      decoration: new InputDecoration(
                        labelText: "Z index",
                      ),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 200,
                    child: Text('Icon Size'),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  Container(
                    width: 200,
                    child: Text('Icon Color'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
