import 'package:flutter/material.dart';

class home extends StatelessWidget{

  String _title = 'Bem Vindo';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text(_title, style: new TextStyle(color: Colors.white, fontSize: 32.0),),
              new Image.asset('images/info.png')
            ],
          ),
        ),
      ),
      backgroundColor: new Color(0xF1F2D440),
    );
  }
}