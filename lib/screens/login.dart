import 'package:flutter/material.dart';
import 'package:i_love_pao/code/theme.dart';

class login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new loginState();
  }
}

void _entrar(context){
  Navigator.of(context).pushNamed('/backers');
}

void _cancelar(context){
  Navigator.pop(context);
}

class loginState extends State<login>{
  
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
                          child: new RaisedButton(child: new Text('Entrar'),onPressed: (){_entrar(context);}),
                      ),
                      new Container(
                          padding: new EdgeInsets.all(5.0),
                          child: new RaisedButton(child: new Text('Cancelar'),onPressed: (){_cancelar(context);})
                      ),
                    ],
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