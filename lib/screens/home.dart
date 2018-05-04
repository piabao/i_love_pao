import 'package:flutter/material.dart';
import 'package:i_love_pao/code/theme.dart';

class home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new homeState();
  }
}

class homeState extends State<home>{

  String _title = 'Bem Vindo';

  static void _onPressed(){

  }

  var comecarPane = new Container(
    child: new Column(
      children: <Widget>[
        new RaisedButton(padding : new EdgeInsets.all(30.0), color : CurrentTheme.botaoAcao, child: new Text('Começar'), onPressed: (){_onPressed();}),
      ],
    ),
    margin: const EdgeInsets.all(10.0),
    padding: const EdgeInsets.all(10.0),
  );

  void showDemoDialog({ BuildContext context }) {
    showDialog(context: context, child:
      new SimpleDialog(
        children: <Widget>[
          loginPane
        ],
      )
    );
  }
  var loginPane = new Container(
    child: new Column(
      children: <Widget>[
        new Text('texto')
      ],
    ),
    decoration: new BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(5.0),
            topRight: const Radius.circular(5.0)
        )
    ),
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
              new RaisedButton(
                  child: new Text('Entrar'),
                  onPressed: (){showDemoDialog(context: context);})
            ],
          ),
        constraints: new BoxConstraints.expand(),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(colors: [CurrentTheme.gradientStart, CurrentTheme.gradientEnd],
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