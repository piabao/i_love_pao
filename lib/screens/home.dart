import 'package:flutter/material.dart';
import 'package:i_love_pao/code/theme.dart';
import 'package:i_love_pao/database/local/database_helper.dart';
import 'package:i_love_pao/database/rest_ds.dart';
import 'package:i_love_pao/model/user.dart';
import 'package:i_love_pao/screens/login.dart';
import 'package:i_love_pao/screens/register.dart';
import 'package:i_love_pao/screens/util/async_progress.dart';
import 'package:i_love_pao/screens/util/toast.dart';

class home extends StatelessWidget {

  String _title = 'Seja Bem Vindo';
  RestDatasource api = new RestDatasource();
  var progress = new AsyncProgress().initialize();

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

  void _callLoginApi(BuildContext context, User usr) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    showDialog(
        context: context,
        child: progress);
    try {
      var user = await api.login(usr.username, usr.password);
      if(user.username == null || user.username.isEmpty){
        MyToast.error("Email ou senha invalidos!");
        Navigator.pop(context);
        return;
      }
      Navigator.pop(context);
      MyToast.show('Entrando como '+user.username +' ...');
      Navigator.of(context).pushNamed('/backers');
    } on Exception catch(error) {
      Navigator.pop(context);
      MyToast.error("Email ou senha invalidos!");
    }
  }

  void showLoginDialog({ BuildContext context }) async {
    var db = new DatabaseHelper();
    User user = await db.getUser();
    if(user != null && user.username != null && user.password != null){
      _callLoginApi(context, user);
    }else{
      showDialog(context: context, child:
      new SimpleDialog(
        children: <Widget>[
          new Login()
        ],
      )
      );
    }
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
    return new WillPopScope(onWillPop: () async => false, child: new Scaffold(
      resizeToAvoidBottomPadding: false,
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
    )
    );
  }
}