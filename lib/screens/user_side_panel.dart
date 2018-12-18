import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:i_love_pao/code/theme.dart';
import 'package:i_love_pao/database/local/database_helper.dart';
import 'package:i_love_pao/database/rest_ds.dart';
import 'package:i_love_pao/model/notification.dart';
import 'package:i_love_pao/model/promotions.dart';
import 'package:i_love_pao/model/user.dart';
import 'package:i_love_pao/screens/home.dart';
import 'package:i_love_pao/screens/util/async_progress.dart';
import 'package:i_love_pao/screens/util/toast.dart';
import 'package:package_info/package_info.dart';

class SidePanel extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new SidePanelState();
  }
}

class SidePanelState extends State<SidePanel> {
  RestDatasource api = new RestDatasource();
  final oldPassController = new TextEditingController();
  final newPassController = new TextEditingController();
  final confirmPassController = new TextEditingController();

  @override
  Widget build(BuildContext context) {


    return new Drawer(
      child: new ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          new DrawerHeader(
            child: new Column(
                children: <Widget>[
                  new Text('Você esta logado como ${api.loggedUser.username}'),
                  new Padding(padding: EdgeInsets.only(top: 10.0)),
                  new Center(
                    child: new Opacity(opacity: 0.7,
                      child: new CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.white,
                        backgroundImage: new Image.asset('images/avatar_default.png', scale: 1.0,).image,
                      )),
                  )
                ],
            ), //
            decoration: new BoxDecoration(
              color: Colors.blue,
            ),
          ),
          new ListTile(
            title: new Text('Trocar Senha'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("Trocar Senha"),
                    content: new SingleChildScrollView (child:_passwordChangePanel()),
                  );
                },
              );
            },
          ),
          new ListTile(
            title: new Text('Sair'),
            onTap: () {
              //TODO: deslogar
              var db = new DatabaseHelper();
              db.deleteUsers();
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new home()));
            },
          ),
          new ListTile(
            title: new Text('Informações'),
            onTap: () {
              PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
                _showInformationDialog(packageInfo.appName, packageInfo.version);
                //String buildNumber = packageInfo.buildNumber;
              });
//              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new home()));
            },
          ),
        ],
      ),
    );
  }

  void _showInformationDialog(String name, String version) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Informações sobre o applicativo"),
          content: new Text('Versão: $version'),
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

  Widget _passwordChangePanel() {
    return new Center(
      child: new Container(
       // child: new Padding(
          //padding: const EdgeInsets.all(15.0),
          child: new Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: new EdgeInsets.all(10.0),
                child: new TextField(
                  controller: oldPassController,
                  obscureText: true,
                  decoration: new InputDecoration(
                      labelText: 'Senha atual',
                      contentPadding: new EdgeInsets.all(15.0),
                      hintText: 'Senha atual'
                  ),
                ),
              ),
              new Container(
                padding: new EdgeInsets.all(10.0),
                child: new TextField(
                  controller: newPassController,
                  obscureText: true,
                  decoration: new InputDecoration(
                      labelText: 'Nova senha',
                      contentPadding: new EdgeInsets.all(15.0),
                      hintText: 'Nova senha'
                  ),
                ),
              ),
              new Container(
                padding: new EdgeInsets.all(10.0),
                child: new TextField(
                  controller: confirmPassController,
                  obscureText: true,
                  decoration: new InputDecoration(
                      labelText: 'Comfirmar nova senha',
                      contentPadding: new EdgeInsets.all(15.0),
                      hintText: 'Confirmação'
                  ),
                ),
              ),

              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.all(5.0),
                    child: new RaisedButton(child: new Text('Comfirmar'),
                        onPressed: (){
                          setState((){
                            //apiCall=true; // Set state like this
                          });
                          _comfirmChange();
                        }),
                  ),
                  new Container(
                      padding: new EdgeInsets.all(5.0),
                      child: new RaisedButton(child: new Text('Cancelar'),onPressed: (){Navigator.of(context).pop();})
                  ),
                ],
              ),
            ],
          ),
        ),
//        decoration: new BoxDecoration(
//            color: Colors.white.withOpacity(0.2),
//            borderRadius: new BorderRadius.only(
//                topLeft: const Radius.circular(5.0),
//                topRight: const Radius.circular(5.0)
//            )
//        ),
//      ),
    );
  }

  void _comfirmChange() {
    var progress = new AsyncProgress().initialize();

    if(newPassController.text != confirmPassController.text){
      MyToast.error("A confirmação da senha está diferente da senha escolhida!");
      return;
    }
    if(oldPassController.text != api.loggedUser.password){
      MyToast.error("Senha atual incorreta!");
      Navigator.of(context).pop();
      return;
    }
    showDialog(
        context: context,
        child: progress);
    api.changePass(newPassController.text).then((user) {
      setState(() {
        MyToast.show("Senha alterada com sucesso!");
        var db = new DatabaseHelper();
        db.deleteUsers();
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/home');
      });
    }).catchError((Exception error) {
        Navigator.of(context).pop();
        MyToast.error('Ocorreu um erro ao tentar executar esta ação!');
    });
  }
}
