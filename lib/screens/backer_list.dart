import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:i_love_pao/database/rest_ds.dart';
import 'package:i_love_pao/model/backer.dart';
import 'package:i_love_pao/screens/backer_detail.dart';
import 'package:i_love_pao/screens/util/card.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'dart:convert';

import 'package:http/http.dart';

import 'package:i_love_pao/database/backerListMock.dart';

import 'package:firebase_messaging/firebase_messaging.dart';


class backerList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new backerListState();
  }
}



class backerListState extends State<backerList> {
  final GlobalKey<AnimatedListState> _listKey = new GlobalKey<
      AnimatedListState>();
  RestDatasource api = new RestDatasource();
  List<Backer> _list = new List<Backer>();
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  
  void getList(){
    //teste();
    if(!_list.isEmpty ){
      startFirebase();
      return;
    }
    api.getBackerList().then((List<Backer> list) {
      setState(() {
          _list = list;
          startFirebase();
        });
    }).catchError((Exception error) {
      print(error);
    });
  }
  //new backerListMock().getList();

  // Used to build list items that haven't been removed.
  Widget buildItem(BuildContext context, int index) {
    return new BackerItem(
      item: _list[index],
      onTap: () {
        var item =  _list[index];
        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new Details(backer: item)));
      }
    );
  }

  void onFilter(){
//    getList();
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Minhas Padarias'),
        backgroundColor: new Color(0xFF330808),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.filter), onPressed: (){onFilter();}),
        ],
      ),
      drawer: new Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: new ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
              child: new Text('Drawer Header'),
              decoration: new BoxDecoration(
                color: Colors.blue,
              ),
            ),
            new ListTile(
              title: new Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            new ListTile(
              title: new Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new ListView.builder(
            itemBuilder: (BuildContext context, int index) => buildItem(context, index),
            itemCount: _list.length),
      ),
    );
  }

  Widget _buildDialog(BuildContext context,  String name, String message) {
    return new AlertDialog(
      title: new Text(name, style: new TextStyle(fontWeight: FontWeight.bold)),
      content: new Text(message),
      actions: <Widget>[
        new FlatButton(
          child: const Text('Fechar'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    //TODO verificar se a padaria esta habilitada a receber notificações (marcada como favorita?) message[id]
    var title = utf8.decode(base64Decode(message['name']));
    var content = utf8.decode(base64Decode(message['description']));
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, title,  content),
    ).then((bool shouldNavigate) {
    });
  }
  
  void startFirebase() {
    for(Backer bk in _list){
      if(bk.topic == null){
        continue;
      }
      _firebaseMessaging.unsubscribeFromTopic(bk.topic);
    }
    api.getBackerFavorites().then((List<Backer> list){
      for(Backer bk in list){
        if(bk.topic == null){
          continue;
        }
        _firebaseMessaging.subscribeToTopic(bk.topic);
      }
    });
    //_firebaseMessaging.subscribeToTopic("ILovePaoMarlonH");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) {
        print("onLaunch: $message");
        _showItemDialog(message);
      },
      onResume: (Map<String, dynamic> message) {
        print("onResume: $message");
        _showItemDialog(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        print("token: $token");
        //_homeScreenText = "Push Messaging token: $token";
      });
      print("token 2");
      //print(_homeScreenText);
    });
  }
}

class BackerItem extends StatefulWidget {
  BackerItem({Key key, this.onTap, @required this.item});

  final VoidCallback onTap;
  final Backer item;

  @override
  State<StatefulWidget> createState() {
    return new StateItem(key: key, onTap: onTap, item: this.item);
  }
}

class StateItem extends State<BackerItem>{
  StateItem({Key key, this.onTap, @required this.item});

  final VoidCallback onTap;
  final Backer item;

  Widget getThumbnail(){
    return new Container(
      margin: new EdgeInsets.only(top: 10.0),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: new Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: new CircleAvatar(
        backgroundImage: new CachedNetworkImageProvider(item.logo
        ),//new AssetImage(item.logo),
      ),
      height: 80.0,
      width: 80.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(2.0),
      child: new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: new SizedBox(
          height: 128.0,
          child: new Card(
            child: new Container(
              margin: new EdgeInsets.all(10.0),
              child: new Stack(
                children: <Widget>[
                  new BackerCard(item: this.item),
                  getThumbnail()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
