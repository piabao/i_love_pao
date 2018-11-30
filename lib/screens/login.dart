import 'package:flutter/material.dart';
import 'package:i_love_pao/code/theme.dart';
import 'package:i_love_pao/database/rest_ds.dart';
import 'package:i_love_pao/screens/util/async_progress.dart';
import 'package:i_love_pao/screens/util/toast.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new LoginState();
  }
}

class LoginState extends State<Login>{
  RestDatasource api = new RestDatasource();

  final userController = new TextEditingController();
  final passController = new TextEditingController();

  var progress = new AsyncProgress().initialize();

  void _cancelar(context){
    Navigator.pop(context);
  }

  void _callLoginApi() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    showDialog(
        context: context,
        child: progress);
    try {
      var user = await api.login(userController.text, passController.text);
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
  
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
          child: new Padding(
              padding: const EdgeInsets.all(15.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.all(10.0),
                    child :new Text('Entre com seu Login e Senha', textAlign: TextAlign.center, style: new TextStyle(
                      color: CurrentTheme.textColor,
                      fontSize: 20.0,
                    ),
                    ),
                  ),
                  new Container(
                    padding: new EdgeInsets.all(10.0),
                    child: new TextField(
                      controller: userController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                        labelText: 'Email',
                          contentPadding: new EdgeInsets.all(15.0),
                          hintText: 'Insira o seu email cadastrado'
                      ),
                    ),
                  ),

                  new Container(
                    padding: new EdgeInsets.all(10.0),
                    child: new TextField(
                      controller: passController,
                      obscureText: true,
                      decoration: new InputDecoration(
                          labelText: 'Senha',
                          contentPadding: new EdgeInsets.all(15.0),
                          hintText: 'Insira a sua senha'
                      ),
                    ),
                  ),

                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                          padding: new EdgeInsets.all(5.0),
                          child: new RaisedButton(child: new Text('Entrar'),
                              onPressed: (){
                                setState((){
                                  //apiCall=true; // Set state like this
                                });
                                _callLoginApi();
                          }),
                      ),
                      new Container(
                          padding: new EdgeInsets.all(5.0),
                          child: new RaisedButton(child: new Text('Cancelar'),onPressed: (){_cancelar(context);})
                      ),
                    ],
                  ),
                ],
              ),
          ),
          decoration: new BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(5.0),
                  topRight: const Radius.circular(5.0)
              )
          ),
        ),
      );
  }
}