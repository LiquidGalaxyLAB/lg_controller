import 'package:flutter/material.dart';

class NavigationView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Hero(
            tag: "Nav_view",
            child: SizedBox(
              width: 220,
              height: 100,
              child: Card(
                  child: Text(
                    "navigation view",
                    style: Theme.of(context).textTheme.title,
                  ),
                  color: Colors.white70),
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
