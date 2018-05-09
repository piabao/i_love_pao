import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:i_love_pao/model/backer.dart';
import 'package:i_love_pao/screens/backer_detail.dart';

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
        print('Opa');
        var item =  _list[index];
        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new Details(item)));
//        Navigator.of(context).pushNamed('/details/$item');
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Minhas Padarias'),
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

  void onFavorite(){
    setState((){
       item.favorite = !item.favorite;
    });
  }

  Widget getCard(){
    return new Container(
      height: 124.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: new Color(0xFFff841f),//(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
      padding: new EdgeInsets.only(left: 20.0),
      child: new ListTile(
        leading: new IconButton(
            icon: item.favorite ? new Icon(Icons.favorite): new Icon(Icons.favorite_border),
            onPressed: (){onFavorite();},
            color: item.favorite ? new Color(0xFFe50000) : Colors.black,
            ),
        title: new Text(item.name, style: new TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
        subtitle: new Text(item.address.city+', '+item.address.district, style: new TextStyle(color: new Color(0xFF330808))),
      ),
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
                  getCard(),
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
