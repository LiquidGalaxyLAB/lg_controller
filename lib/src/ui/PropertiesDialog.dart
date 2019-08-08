import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_controller/src/menu/OverlayMenu.dart';
import 'package:lg_controller/src/models/LineData.dart';
import 'package:lg_controller/src/models/OverlayItem.dart';
import 'package:lg_controller/src/models/PlacemarkData.dart';
import 'package:lg_controller/src/models/ImageData.dart';
import 'package:lg_controller/src/models/PointData.dart';
import 'package:lg_controller/src/utils/LineColors.dart';
import 'package:lg_controller/src/utils/MarkerColors.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// Dialog for Properties.
class PropertiesDialog extends StatefulWidget {
  final OverlayItem data;
  final OverlayMenu menu;
  final Function onSave;
  final Function onDelete;

  PropertiesDialog(this.data, this.menu, this.onSave, this.onDelete);

  @override
  _PropertiesDialogState createState() => _PropertiesDialogState();
}

class _PropertiesDialogState extends State<PropertiesDialog> {
  OverlayItem temp;
  int selected;
  TextEditingController title_controller;
  TextEditingController desc_controller;
  TextEditingController lat_controller;
  TextEditingController lgt_controller;
  TextEditingController zInd_controller;

  @override
  void initState() {
    temp = widget.data;
    selected = 0;
    title_controller = TextEditingController(text: widget.data.title);
    desc_controller = TextEditingController(text: widget.data.desc);
    if (widget.data is PlacemarkData) {
      lat_controller = TextEditingController(
          text: (widget.data as PlacemarkData).point.point.latitude.toString());
      lgt_controller = TextEditingController(
          text:
              (widget.data as PlacemarkData).point.point.longitude.toString());
      zInd_controller = TextEditingController(
          text: (widget.data as PlacemarkData).point.zInd.toString());
    } else if (widget.data is ImageData) {
      lat_controller = TextEditingController(
          text: (widget.data as ImageData).point.point.latitude.toString());
      lgt_controller = TextEditingController(
          text: (widget.data as ImageData).point.point.longitude.toString());
      zInd_controller = TextEditingController(
          text: (widget.data as ImageData).point.zInd.toString());
    } else if (widget.data is LineData) {
      lat_controller = TextEditingController(
          text: (widget.data as LineData).points[0].point.latitude.toString());
      lgt_controller = TextEditingController(
          text: (widget.data as LineData).points[0].point.longitude.toString());
      zInd_controller = TextEditingController(
          text: (widget.data as LineData).points[0].zInd.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget dataSpecific;
    if (widget.data is PlacemarkData)
      dataSpecific = PlacemarkLayer(widget.data, (value) {
        (widget.data as PlacemarkData).iconSize = value;
        setState(() {});
      }, (value) {
        (widget.data as PlacemarkData).iconColor = value;
        setState(() {});
      });
    else if (widget.data is LineData)
      dataSpecific = LineDataLayer(widget.data, (value) {
        (widget.data as LineData).width = value;
        setState(() {});
      }, (value) {
        (widget.data as LineData).color = value;
        setState(() {});
      });
    else if (widget.data is ImageData)
      dataSpecific = ImageDataLayer((widget.data as ImageData).image);
    else
      dataSpecific = Container();
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: AlertDialog(
        title: Text('Please enter details of the overlay.',
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
              widget.onDelete(widget.data);
              Navigator.of(context).pop();
            },
            child: Text('Delete', style: Theme.of(context).textTheme.title),
          ),
          FlatButton(
            onPressed: () {
              if (widget.data is PlacemarkData)
                temp = PlacemarkData(
                    PointData(
                      LatLng(double.tryParse(lat_controller.text),
                          double.tryParse(lgt_controller.text)),
                      double.tryParse(zInd_controller.text),
                    ),
                    widget.data.id,
                    title_controller.text,
                    desc_controller.text);
              (temp as PlacemarkData).iconColor =
                  (widget.data as PlacemarkData).iconColor;
              (temp as PlacemarkData).iconSize =
                  (widget.data as PlacemarkData).iconSize;
              if (widget.data is ImageData)
                temp = ImageData(
                    PointData(
                      LatLng(double.tryParse(lat_controller.text),
                          double.tryParse(lgt_controller.text)),
                      double.tryParse(zInd_controller.text),
                    ),
                    widget.data.id,
                    title_controller.text,
                    desc_controller.text,
                    (widget.data as ImageData).image,
                    (widget.data as ImageData).thumbnail);
              else if (widget.data is LineData) {
                temp.id = widget.data.id;
                temp.title = title_controller.text;
                temp.desc = desc_controller.text;
                (temp as LineData).points[selected] = PointData(
                  LatLng(double.tryParse(lat_controller.text),
                      double.tryParse(lgt_controller.text)),
                  double.tryParse(zInd_controller.text),
                );
              }
              widget.onSave(temp);
              Navigator.of(context).pop();
            },
            child: Text('Save', style: Theme.of(context).textTheme.title),
          ),
        ],
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              LabelLayer(title_controller, desc_controller),
              Padding(
                  padding: EdgeInsets.all(
                      8.0 + 8 * 0.5 * (SizeScaling.getWidthScaling() - 1))),
              (widget.data is LineData)
                  ? ChoiceChips(2, 0, (i, prev) => changeCoords(i, prev),
                      ["Point 1", "Point 2"])
                  : Container(),
              CoordsLayer(lat_controller, lgt_controller, zInd_controller),
              Padding(
                  padding: EdgeInsets.all(
                      8.0 + 8 * 0.5 * (SizeScaling.getWidthScaling() - 1))),
              dataSpecific,
            ],
          ),
        ),
      ),
    );
  }

  changeCoords(int i, int prev) {
    selected = i;
    (temp as LineData).points[prev] = PointData(
      LatLng(double.tryParse(lat_controller.text),
          double.tryParse(lgt_controller.text)),
      double.tryParse(zInd_controller.text),
    );
    setState(() {
      if (widget.data is LineData) {
        lat_controller = TextEditingController(
            text:
                (widget.data as LineData).points[i].point.latitude.toString());
        lgt_controller = TextEditingController(
            text:
                (widget.data as LineData).points[i].point.longitude.toString());
        zInd_controller = TextEditingController(
            text: (widget.data as LineData).points[i].zInd.toString());
      }
    });
  }
}

class LabelLayer extends StatelessWidget {
  final TextEditingController title_controller, desc_controller;

  LabelLayer(this.title_controller, this.desc_controller);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: 200 + 200 * 0.8 * (SizeScaling.getWidthScaling() - 1),
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
          width: 200 + 200 * 0.8 * (SizeScaling.getWidthScaling() - 1),
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
    );
  }
}

class CoordsLayer extends StatelessWidget {
  final TextEditingController lat_controller, lgt_controller, zInd_controller;

  CoordsLayer(this.lat_controller, this.lgt_controller, this.zInd_controller);

  @override
  Widget build(BuildContext context) {
    return Row(
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
        Padding(padding: EdgeInsets.all(8.0)),
        Container(
          width: 100 + 100 * 0.8 * (SizeScaling.getWidthScaling() - 1),
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
    );
  }
}

class PlacemarkLayer extends StatelessWidget {
  final PlacemarkData data;
  final Function onSizeChange;
  final Function onColorChange;

  PlacemarkLayer(this.data, this.onSizeChange, this.onColorChange);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Placemark size", style: Theme.of(context).textTheme.title),
              DropdownButton<int>(
                value: data.iconSize,
                onChanged: (int value) => onSizeChange(value),
                items: <int>[1, 2, 3, 4, 5]
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString(),
                        style: Theme.of(context).textTheme.title),
                  );
                }).toList(),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(16.0)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Placemark color", style: Theme.of(context).textTheme.title),
              DropdownButton<MarkerColors>(
                value: (MarkerColors.values() as List<MarkerColors>)
                    .firstWhere((val) => val.value == data.iconColor),
                onChanged: (MarkerColors value) => onColorChange(value.value),
                items: MarkerColors.values()
                    .map<DropdownMenuItem<MarkerColors>>((MarkerColors value) {
                  return DropdownMenuItem<MarkerColors>(
                    value: value,
                    child: Text(value.title,
                        style: Theme.of(context).textTheme.title),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LineDataLayer extends StatelessWidget {
  final LineData data;
  final Function onWidthChange;
  final Function onColorChange;

  LineDataLayer(this.data, this.onWidthChange, this.onColorChange);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Line width", style: Theme.of(context).textTheme.title),
              DropdownButton<int>(
                value: data.width,
                onChanged: (int value) => onWidthChange(value),
                items: <int>[2, 4, 6, 8, 10]
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString(),
                        style: Theme.of(context).textTheme.title),
                  );
                }).toList(),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(16.0)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Line color", style: Theme.of(context).textTheme.title),
              DropdownButton<LineColors>(
                value: (LineColors.values() as List<LineColors>)
                    .firstWhere((val) => val.value == data.color),
                onChanged: (LineColors value) => onColorChange(value.value),
                items: LineColors.values()
                    .map<DropdownMenuItem<LineColors>>((LineColors value) {
                  return DropdownMenuItem<LineColors>(
                    value: value,
                    child: Text(value.title,
                        style: Theme.of(context).textTheme.title),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageDataLayer extends StatelessWidget {
  final List<int> image;

  ImageDataLayer(this.image);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Image :", style: Theme.of(context).textTheme.title),
        Container(
          constraints: BoxConstraints(
              maxHeight: 320.0 * SizeScaling.getWidthScaling(),
              maxWidth: 400.0 * SizeScaling.getWidthScaling(),
              minWidth: 200.0 * SizeScaling.getWidthScaling(),
              minHeight: 160.0 * SizeScaling.getWidthScaling()),
          child: Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.memory(image),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ],
    );
  }
}

class ChoiceChips extends StatefulWidget {
  final int length;
  final int initialValue;
  final Function onSelected;
  final List<String> labels;

  ChoiceChips(this.length, this.initialValue, this.onSelected, this.labels);

  @override
  _ChoiceChipsState createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  int selected;

  @override
  void initState() {
    selected = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: getLabels(),
        ),
      ),
    );
  }

  getLabels() {
    List<Widget> list = [];
    for (int i = 0; i < widget.length; i++) {
      list.add(
        GestureDetector(
          onTap: () {
            if (selected != i) {
              widget.onSelected(i, selected);
              setState(() {
                selected = i;
              });
            }
          },
          child: Container(
            height: 32 + 32 * 0.8 * (SizeScaling.getWidthScaling() - 1),
            padding: EdgeInsets.symmetric(
                horizontal: 8.0 + 8 * 0.5 * (SizeScaling.getWidthScaling() - 1),
                vertical: 8.0 + 8 * 0.5 * (SizeScaling.getWidthScaling() - 1)),
            decoration: BoxDecoration(
                color: (selected == i) ? Colors.teal : Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(
                  16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                ))),
            child: Text(widget.labels[i],
                style: Theme.of(context).textTheme.body1),
          ),
        ),
      );
      list.add(Padding(padding: EdgeInsets.all(12)));
    }

    return list;
  }
}
