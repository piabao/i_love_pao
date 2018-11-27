import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:i_love_pao/code/theme.dart';
import 'package:i_love_pao/screens/actions.dart';
import 'package:i_love_pao/model/backer.dart';
import 'package:i_love_pao/model/action_button.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ActionMenu extends StatefulWidget {
  ActionMenu({this.backer});

  final Backer backer;

@override
  State<StatefulWidget> createState() {
    return new ActionMenuWidget(backer: backer);
  }

}

class ActionMenuWidget extends State<ActionMenu> with TickerProviderStateMixin{
  ActionMenuWidget({this.backer});

  final Backer backer;

  AnimationController _controller;

  static List<ActionButton> icons =  [new ActionButton('Pão Quentinho', Icons.whatshot, buildHotBread()), new ActionButton('Cardápio', Icons.menu, buildMenu()), new ActionButton('Promoções', Icons.card_giftcard, buildPromo()), new ActionButton('Receitas', Icons.free_breakfast, buildReceipe()), new ActionButton('Avaliar', Icons.stars, buildRating())] ;

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Chip(label: new Text(icons.elementAt(index).label), backgroundColor: backgroundColor,),
                  new FloatingActionButton(
                    heroTag: ''+icons.elementAt(index).label,
                    backgroundColor: backgroundColor,
                    mini: true,
                    child:  new Hero(
                      tag: 'image-hero'+icons.elementAt(index).label,
                      child:   new Icon(icons.elementAt(index).icon, color: foregroundColor),
                    ),
                    onPressed: () {
                      Navigator.push(context, new ActionDialog(
                          action: icons.elementAt(index),
                          builder: (BuildContext context)
                          {
                            return new Container(

                            );
                          }
                      )
                      );
                    },
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
                  transform: new Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child: new Icon(_controller.isDismissed ? Icons.add : Icons.close),
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

Widget buildReceipe() {
  return Container(
    
  );
}

Widget buildPromo() {
  return Container(

  );
}

Widget buildMenu() {
  return Container(

  );
}

Widget buildRating() {
  return new Container(
//    body: new Container(
//      padding: new EdgeInsets.only(top: 32.0),
    child: new Column(
      children: <Widget>[
        new Center(
          child: new Text('Qual é sua avaliação deste estabelecimento?'),
        ),
        new Container(
          child:  new StarRating(),
        ),
        new FlatButton(
          child: new Text("Confirmar"),
          onPressed: () {
            // TODO: salvar avaliação
            //Navigator.of(context).pop();
          },
        ),
      ],
//      ),
    ),
  );

}

Widget buildHotBread() {
  return new Scaffold(
//    body: new Container(
//      padding: new EdgeInsets.only(top: 32.0),
      body: new Column(
        children: <Widget>[
          new Text('Próxima formada sai em: '),
          new Container(
            child: new Card(
              color: CurrentTheme.cardBackground,              
              margin: new EdgeInsets.only(top: 30.0),
              child: new Container(
                padding: new EdgeInsets.all(15.0),
                child: new Text('Pão Doce: 20/04/2018 18:30'),
              )
            ),
          ),
        ],
//      ),
    ),
  );
}

class StarRating extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new StarRatingState();
  }
}

class StarRatingState extends State<StarRating>{
  var rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: SmoothStarRating(
        allowHalfRating: true,
        rating: rating,
        size: 45.0,
        starCount: 5,
        onRatingChanged: (value) {
          setState(() {
            rating = value;
          });
        },
      ),
    );
  }

}
