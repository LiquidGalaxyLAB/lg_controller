import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Dialog for tool attributes.
class AttributeDialog extends StatefulWidget {
  AttributeDialog();

  @override
  _AttributeDialogState createState() => _AttributeDialogState();
}

class _AttributeDialogState extends State<AttributeDialog> {
  bool loading = true;
  int value = 3;

  @override
  void initState() {
    getPolygonVertexCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Slect the number of vertices',
          style: Theme.of(context).textTheme.title),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: (loading)
              ? CircularProgressIndicator()
              : DropdownButton<int>(
                  value: value,
                  onChanged: (int value) {
                    setState(() {
                      this.value = value;
                      setPolygonVertexCount();
                    });
                  },
                  items: <int>[3, 4, 5].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString(),
                          style: Theme.of(context).textTheme.title),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }

  /// Get user default for number of vertices of polygon.
  Future getPolygonVertexCount() async {
    final prefs = await SharedPreferences.getInstance();
    value = prefs.getInt('PolygonVertex') ?? 3;
    setState(() {
      loading = false;
    });
  }

  /// Set user default for number of vertices of polygon.
  Future setPolygonVertexCount() async {
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('PolygonVertex', value);
    setState(() {
      loading = false;
    });
  }
}
