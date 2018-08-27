import 'package:flutter/material.dart';
import 'package:i_love_pao/model/address.dart';
import 'package:i_love_pao/model/backer.dart';

class BackerCard extends StatefulWidget{
  BackerCard({this.item});

  final Backer item;

  @override
  State<StatefulWidget> createState() {
    return new CardState(item: this.item);
  }
}

class CardState extends State<BackerCard> {
  CardState({this.item});
  final Backer item;

  void onFavorite() {
    setState(() {
      item.favorite = !item.favorite;
    });
  }

  @override
  Widget build(BuildContext context) {

    Address adds = item.address == null || item.address.length == 0 ? null :  item.address[0];

    return new Container(
      height: 124.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: new Color(0xCCff841f), //(0xFF333366),
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
          icon: item.favorite ? new Icon(Icons.favorite) : new Icon(
              Icons.favorite_border),
          onPressed: () {
            onFavorite();
          },
          color: item.favorite ? new Color(0xFFe50000) : Colors.black,
        ),
        title: new Text(item.name, style: new TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600),),
        subtitle: new Text(adds == null ? '' : adds.city + ', ' + adds.neighborhood,
            style: new TextStyle(color: new Color(0xFF330808))),
      ),
    );
  }
}