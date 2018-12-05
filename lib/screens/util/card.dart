import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:i_love_pao/database/rest_ds.dart';
import 'package:i_love_pao/model/address.dart';
import 'package:i_love_pao/model/backer.dart';
import 'package:i_love_pao/screens/util/async_progress.dart';
import 'package:i_love_pao/screens/util/toast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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
  RestDatasource api = new RestDatasource();
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  void onFavorite() {
    var progress = new AsyncProgress().initialize();
    setState(() {
      showDialog(
          context: context,

          child: progress);
      api.toggleBakeryFavorite(item.id, !item.favorite).then((value){
        if(value){
          setState(() {
            item.favorite = !item.favorite;
          });
          if(item.favorite){
            _firebaseMessaging.subscribeToTopic(item.topic);
          }else{
            _firebaseMessaging.unsubscribeFromTopic(item.topic);
          }
          MyToast.show("Parabens! ${item.name} esta nos seus favoritos");
        }
        Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    Address adds = item.address == null || item.address.length == 0 ? null :  item.address[0];

    String _title = '';
    if(adds != null) {
      _title = (adds.city != null ? adds.city : '') + ', ' +
          (adds.neighborhood != null ? adds.neighborhood : '');
    }

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
          contentPadding: EdgeInsets.only(left: 10.0, bottom: 15.0, top: 5.0),
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
          subtitle: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text(_title,
                  style: new TextStyle(color: new Color(0xFF330808))),
              new Container(
                  child: SmoothStarRating(
                    allowHalfRating: true,
                    rating: item.averageRating,
                    size: 20.0,
                    starCount: 5,
                    color: new Color(0xFF333366),
                    borderColor: Colors.black,
                  )
              ),
            ],
          )
        ),
      );
    }

  }



