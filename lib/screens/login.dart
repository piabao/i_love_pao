import 'package:flutter/material.dart';
import 'package:i_love_pao/code/theme.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new loginState();
  }
}

class loginState extends State<login>{

  final userController = new TextEditingController();
  final passController = new TextEditingController();

  String _currentLogin = "";
  bool apiCall = false; // New variable

  Future<Post> fetchPost(String auth) async {
    final response = await http.get(
      'https://i-love-pao.herokuapp.com/user',
      headers: {HttpHeaders.AUTHORIZATION: 'Basic ' + auth},
    );
    final responseJson = json.decode(response.body);
    //debugPrint('cai aqui '+ responseJson);
    return new Post.fromJson(responseJson);
  }

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
    var str = userController.text + ":" + passController.text;
    var bytes = utf8.encode(str);
    var encoded = base64.encode(bytes);
    fetchPost(encoded).then((login) {
      setState(() {
        apiCall= false; //Disable Progressbar
        if(login.name == null || login.name.isEmpty){
          _currentLogin = 'Email ou senha invalidos!';
          return;
        }
        _currentLogin = 'Entrando como '+login.name +' ...';
        Navigator.of(context).pushNamed('/backers');
      });
    }, onError: (error) {
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
                                  apiCall=true; // Set state like this
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

class Post {
  final int userId;
  final int id;
  final String name;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body, this.name});

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
      name: json['name'],
    );
  }
}