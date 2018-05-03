import 'package:flutter/material.dart';

class home extends StatelessWidget{

  String _title = 'Bem Vindo';

  Color _gradientStart = new Color(0xFFBC8E65);
  Color _gradientEnd = new Color(0xFFD7BB96);

  static Color _botaoAcao = new Color(0xFF648CC4);

  static void _onPressed(){

  }

  var comecarPane = new Container(
    child: new Column(
      children: <Widget>[
        new RaisedButton(padding : new EdgeInsets.all(30.0), color : _botaoAcao, child: new Text('Começar'), onPressed: (){_onPressed();}),
      ],
    ),
    margin: const EdgeInsets.all(10.0),
    padding: const EdgeInsets.all(10.0),
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: new EdgeInsets.all(32.0),
          child: new Column(
            children: <Widget>[
              new Text(_title, style: new TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontFamily: "Lobster",
              ),),
              new Image.asset('images/icone1.png', scale: 3.0,),
              comecarPane,
              new RaisedButton(child: new Text('Entrar'), onPressed: (){_onPressed();})
            ],
          ),
        constraints: new BoxConstraints.expand(),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(colors: [_gradientStart, _gradientEnd],
              begin: const FractionalOffset(1.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0,1.0],
              tileMode: TileMode.clamp
          ),
        ),
        ),
    );
  }
}