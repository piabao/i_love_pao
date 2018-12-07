import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:i_love_pao/model/menu.dart';
import 'package:money/money.dart';

class MenuExpansionItems extends StatefulWidget {
  MenuExpansionItems({this.items});
  final List<Menu> items;
  @override
  State<StatefulWidget> createState() {
    return new MenuExpansionItemsState(items: items);
  }
}

class MenuExpansionItemsState extends State<MenuExpansionItems> {
  MenuExpansionItemsState({this.items});
  final List<Menu> items;

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

  ExpansionPanel _createPanel(Menu item){
    final _money = item.price != null ? Money.fromDouble(item.price, Currency('BRL')) : null;
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
              new Container(padding: EdgeInsets.only(top: 10.0),),
              item.price != null ? new Text("Valor por ${item.unit} : R\$${_money.amountAsString}") : new Container()
            ],
          ),
        ),
        isExpanded: item.isExpanded
    );
  }
}