import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:i_love_pao/model/recipes.dart';

class RecepesExpansionItems extends StatefulWidget {
  RecepesExpansionItems({this.items});
  final List<Recipes> items;
  @override
  State<StatefulWidget> createState() {
    return new RecepesExpansionItemsState(items: items);
  }
}

class RecepesExpansionItemsState extends State<RecepesExpansionItems> {
  RecepesExpansionItemsState({this.items});
  final List<Recipes> items;

  @override
  Widget build(BuildContext context) {
    return new ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded){
        setState(() {
          items[index].isExpanded = !items[index].isExpanded;
        });
      },
      children:items.map(_createPanel).toList(),
    );
  }

  ExpansionPanel _createPanel(Recipes item){
    return new ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded){
          return new Container(
            padding: new EdgeInsets.all(10.0),
            child: new Text('${item.name}'),
          );
        },
        body: new Padding(
          padding: new EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              item.image != null ? new Container(
                child: CachedNetworkImage(
                  placeholder: CircularProgressIndicator(),
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  imageUrl: item.image,
                ),//new Image.asset(backer.logo, width: 100.0,),
//                height: 100.0,
//                width: 100.0,
              ) : new Container(),
              new Container(padding: EdgeInsets.only(top: 10.0),),
              new Text(item.description),
            ],
          ),
        ),
        isExpanded: item.isExpanded
    );
  }
}