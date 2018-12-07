import 'package:flutter/material.dart';
import 'package:i_love_pao/code/theme.dart';
import 'package:i_love_pao/model/notification.dart';

class NotificationsItems extends StatefulWidget {
  NotificationsItems({this.items});
  final List<Notifications> items;
  @override
  State<StatefulWidget> createState() {
    return new NotificationsItemsState(items: items);
  }
}

class NotificationsItemsState extends State<NotificationsItems> {
  NotificationsItemsState({this.items});
  final List<Notifications> items;

  @override
  Widget build(BuildContext context) {

    return new Container(
      padding: const EdgeInsets.all(16.0),
      child: new ListView.builder(
          itemBuilder: (BuildContext context, int index) => _createPanel(items[index]),
          itemCount: items.length),
    );
  }

  Widget _createPanel(Notifications item){

    return new Container(
      child: new Column(
        children: <Widget>[
          new Text(item.name),
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