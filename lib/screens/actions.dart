import 'package:flutter/material.dart';
import 'package:i_love_pao/model/action_button.dart';
import 'package:i_love_pao/screens/util/text_style.dart';

class ActionDialog<T> extends PageRoute<T> {
  ActionDialog({ this.builder , this.action}) : super();

  final WidgetBuilder builder;

  final ActionButton action;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get maintainState => true;

  @override
  String get barrierLabel => 'ok';

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return new FadeTransition(
        opacity: new CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn
        ),
        child: child
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new Center(
      child: new AlertDialog(
        title: new Container(
          alignment: Alignment.topLeft,
          child: new Row(
            children: <Widget>[
              new Hero(
                tag: 'image-hero'+action.label,
                child:  new Icon(action.icon),
              ),
              new Container(
                padding: new EdgeInsets.only(left: 5.0),
                child: new Text(action.label, style: Style.titleTextStyle ,),
              )
            ],
          )
        ),

        content: new ListView.builder(
            itemBuilder: (BuildContext context, int index) => action.widgets.elementAt(index),
            itemCount: action.widgets.length),//builder(context),
        actions: <Widget>[
          new FlatButton(
            child: new Text('OK'),
            onPressed: Navigator
                .of(context)
                .pop,
          ),
        ],
      ),
    );
  }
}