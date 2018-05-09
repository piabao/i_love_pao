import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:i_love_pao/code/theme.dart';

class ActionMenu extends StatefulWidget {

@override
  State<StatefulWidget> createState() {
    return new ActionMenuWidget();
  }

}

class ActionMenuWidget extends State<ActionMenu> with TickerProviderStateMixin{

  AnimationController _controller;

  static const Map<String, IconData> icons = const  {'Receitas': Icons.card_giftcard, 'Cardápio' : Icons.menu, 'Promoções': Icons.free_breakfast, 'Pão Quentinho' : Icons.whatshot} ;

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = CurrentTheme.botaoAcao;
    return new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: new List.generate(icons.length, (int index) {
          Widget child = new Container(
            height: 50.0,
            width: 180.0,
            alignment: FractionalOffset.topRight,
            child: new ScaleTransition(
              alignment: Alignment.centerRight,
              scale: new CurvedAnimation(
                parent: _controller,
                curve: new Interval(
                    0.0,
                    1.0 - index / icons.length / 2.0,
                    curve: Curves.easeOut
                ),
              ),
              child: new  Row(
                children: <Widget>[
                  new Chip(label: new Text(icons.keys.elementAt(index)), backgroundColor: backgroundColor,),
                  new FloatingActionButton(
                    heroTag: ''+icons.keys.elementAt(index),
                    backgroundColor: backgroundColor,
                    mini: true,
                    child: new Icon(icons.values.elementAt(index), color: foregroundColor),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          );
          return child;
        }).toList()..add(
          new FloatingActionButton(
            heroTag: "Generate",
            backgroundColor: foregroundColor,
            child: new AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return new Transform(
                  transform: new Matrix4.rotationZ(_controller.value * 0.5 * math.PI),
                  alignment: FractionalOffset.center,
                  child: new Icon(_controller.isDismissed ? Icons.share : Icons.close),
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
      );
  }
}
