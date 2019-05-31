import 'package:flutter/material.dart';

class NavigationView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: SizedBox(
        width: 240,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Card(
                  child: Text(
                    "navigation view",
                    style: Theme.of(context).textTheme.title,
                  ),
                  color: Colors.white),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
