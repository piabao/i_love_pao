import 'package:flutter/material.dart';

class home extends StatelessWidget{

  String _title = 'Bem Vindo';

  Color _gradientStart = new Color(0xDDA85B11);
  Color _gradientEnd = Colors.brown[300];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          child: new Column(
            children: <Widget>[
              new Text(_title, style: new TextStyle(
                  color: Colors.white,
                  fontSize: 32.0
              ),),
              new Image.asset('images/info.png')
            ],
          ),
        constraints: new BoxConstraints.expand(),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(colors: [_gradientStart, _gradientEnd],
              begin: const FractionalOffset(0.5, 0.0),
              end: const FractionalOffset(0.0, 0.5),
              stops: [0.0,1.0],
              tileMode: TileMode.clamp
          ),
        ),
        ),
    );
  }
}