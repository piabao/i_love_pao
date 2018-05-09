import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:i_love_pao/model/backer.dart';
import 'package:i_love_pao/screens/backer_detail.dart';
import 'package:i_love_pao/screens/util/card.dart';

import 'package:i_love_pao/database/backerListMock.dart';


class backerList extends StatelessWidget{
  final GlobalKey<AnimatedListState> _listKey = new GlobalKey<
      AnimatedListState>();
  List<Backer> _list = new backerListMock().getList();

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
        backgroundImage: new AssetImage(item.icon),
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
