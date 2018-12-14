import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:i_love_pao/code/theme.dart';
import 'package:i_love_pao/database/rest_ds.dart';
import 'package:i_love_pao/model/notification.dart';
import 'package:i_love_pao/model/promotions.dart';
import 'package:i_love_pao/screens/home.dart';
import 'package:money/money.dart';

class SidePanel extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new SidePanelState();
  }
}

class SidePanelState extends State<SidePanel> {
  RestDatasource api = new RestDatasource();


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
              //TODO: chamar panel
              Navigator.pop(context);
            },
          ),
          new ListTile(
            title: new Text('Sair'),
            onTap: () {
              //TODO: deslogar
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new home()));
            },
          ),
        ],
      ),
    );
  }

  Widget _createPanel(Notifications item){

    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(padding: EdgeInsets.only(top: 15.0),),
          new Text(item.name, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: CurrentTheme.titleFontSize) ,),
          new Container(
            child: new Card(
                color: CurrentTheme.cardBackground,
                margin: new EdgeInsets.only(top: 30.0),
                child: new Container(
                  padding: new EdgeInsets.all(15.0),
                  child: new Text(item.description),
                )),
          ),
          //new Text(item.dateTime.toIso8601String()),
        ],
//      ),
      ),
    );

  }
}
