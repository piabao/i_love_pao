import 'package:flutter/material.dart';
import 'package:i_love_pao/code/theme.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:i_love_pao/database/rest_ds.dart';
import 'package:http/http.dart' as http;
import 'package:i_love_pao/model/user.dart';

class login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new loginState();
  }
}

class loginState extends State<login>{
  RestDatasource api = new RestDatasource();

  final userController = new TextEditingController();
  final passController = new TextEditingController();

  String _currentLogin = "";
  bool apiCall = false; // New variable

  void _cancelar(context){
    Navigator.pop(context);
  }

  Widget getProperWidget(){
    if(apiCall)
      return new CircularProgressIndicator();
    else
      return new Text(
        '$_currentLogin',
        style: Theme.of(context).textTheme.display1,
      );
  }

  void _callLoginApi() {
    api.login(userController.text, passController.text).then((user) {
      setState(() {
        apiCall= false; //Disable Progressbar
        if(user.username == null || user.username.isEmpty){
          _currentLogin = 'Email ou senha invalidos!';
          return;
        }
        _currentLogin = 'Entrando como '+user.username +' ...';
        Navigator.of(context).pushNamed('/backers');
      });
    }).catchError((Exception error) {
      setState(() {
        apiCall=false; //Disable Progressbar
        _currentLogin = 'Email ou senha invalidos!';
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
                  topRight: const Radius.circular(5.0)
              )
          ),
        ),
      );
  }
}