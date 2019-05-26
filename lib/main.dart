import 'package:flutter/material.dart';
import 'package:lg_controller/src/screens/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
          fontFamily: 'RobotoMono'
      ),
      home: HomePage(),
    );
  }
}
