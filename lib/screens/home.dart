import 'package:flutter/material.dart';
import 'package:i_love_pao/code/theme.dart';
import 'package:i_love_pao/screens/login.dart';
import 'package:i_love_pao/screens/register.dart';

class home extends StatelessWidget {

  String _title = 'Seja Bem Vindo';

  Container comecarPane(BuildContext context){
  return new Container(
    child: new Column(
      children: <Widget>[
        new RaisedButton(
            padding : new EdgeInsets.all(30.0),
            color : CurrentTheme.botaoAcao,
            child: new Text('Começar'),
            onPressed: (){showLoginDialog(context: context);}
            ),
      ],
    ),
    margin: const EdgeInsets.all(10.0),
    padding: const EdgeInsets.all(10.0),

  );
  }

  void showLoginDialog({ BuildContext context }) {
    showDialog(context: context, child:
      new SimpleDialog(
        children: <Widget>[
          new Login()
        ],
      )
    );
  }

  void showRegisterDialog({ BuildContext context }) {
    showDialog(context: context, child:
    new SimpleDialog(
      children: <Widget>[
        new register()
      ],
    )
    );
  }

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
              new Image.asset('images/eu_amo_pao_v2.png', scale: 3.0,),
              comecarPane(context),
              new RaisedButton(
                  child: new Text('Registrar'),
                  onPressed: (){showRegisterDialog(context: context);})
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