import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:i_love_pao/code/theme.dart';
import 'package:i_love_pao/model/notification.dart';
import 'package:i_love_pao/model/promotions.dart';
import 'package:money/money.dart';

class NotificationsExpansionItems extends StatefulWidget {
  NotificationsExpansionItems({this.items});
  final List<Notifications> items;
  @override
  State<StatefulWidget> createState() {
    return new NotificationsExpansionItemsState(items: items);
  }
}

class NotificationsExpansionItemsState extends State<NotificationsExpansionItems> {
  NotificationsExpansionItemsState({this.items});
  final List<Notifications> items;

  @override
  Widget build(BuildContext context) {
    return new Container(
      constraints: BoxConstraints(maxHeight: 500.0),
      child: new Drawer(
       child: new ListView.builder(
           itemBuilder: (BuildContext context, int index) => _createPanel(items[index]),
         itemCount: items.length,
       ),
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
