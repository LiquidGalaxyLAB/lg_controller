import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(image: new AssetImage("image_assets/background.png"), fit: BoxFit.cover,),),
        child: Center(child:Text("tttt"),),
        ),
    );
  }
}