import 'package:flutter/material.dart';
import 'package:i_love_pao/code/theme.dart';

import 'package:i_love_pao/database/rest_ds.dart';

class register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new registerState();
  }
}

class registerState extends State<register> {
  RestDatasource api = new RestDatasource();

  final userController = new TextEditingController();
  final passController = new TextEditingController();
  final confirmPassController = new TextEditingController();

  String _currentLogin = "";
  bool apiCall = false; // New variable

  void _cancelar(context) {
    Navigator.pop(context);
  }

  Widget getProperWidget() {
    if (apiCall)
      return new CircularProgressIndicator();
    else
      return new Text(
        '$_currentLogin',
        style: Theme.of(context).textTheme.display1,
      );
  }

  void _showDialog(String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alerta"),
          content: new Text(mensagem),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _callRegistrarApi() {
    if(passController.text != confirmPassController.text){
      _showDialog("A confirmação da senha está diferente da senha escolhida!");
      return;
    }
    api.register(userController.text, passController.text).then((user) {
      setState(() {
        _showDialog("Uma confirmação foi enviada para o seu e-mail, por favor acesse o link enviado no seu e-mail para confirmar seu registro!");
        Navigator.of(context).pushNamed('/home');
      });
    }).catchError((Exception error) {
      setState(() {
        apiCall = false; //Disable Progressbar
        _currentLogin = 'Erro ao registrar esse email!';
      });
    });
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
                child: new Text(
                  'Entre com seu Login e Senha',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
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
                      hintText: 'Insira o seu email'),
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
                      hintText: 'Insira a sua senha'),
                ),
              ),
              new Container(
                padding: new EdgeInsets.all(10.0),
                child: new TextField(
                  controller: confirmPassController,
                  obscureText: true,
                  decoration: new InputDecoration(
                      labelText: 'Confirmação de senha',
                      contentPadding: new EdgeInsets.all(15.0),
                      hintText: 'Confirme a sua senha'),
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.all(5.0),
                    child: new RaisedButton(
                        child: new Text('Registrar'),
                        onPressed: () {
                          setState(() {
                            //apiCall=true; // Set state like this
                          });
                          _callRegistrarApi();
                        }),
                  ),
                  new Container(
                      padding: new EdgeInsets.all(5.0),
                      child: new RaisedButton(
                          child: new Text('Cancelar'),
                          onPressed: () {
                            _cancelar(context);
                          })),
                ],
              ),
              new Container(
                padding: new EdgeInsets.all(15.0),
                child: getProperWidget(),
              )
            ],
          ),
        ),
        decoration: new BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(5.0),
                topRight: const Radius.circular(5.0))),
      ),
    );
  }
}
