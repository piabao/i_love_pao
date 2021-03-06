import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:i_love_pao/code/theme.dart';
import 'package:i_love_pao/database/rest_ds.dart';
import 'package:i_love_pao/model/bakery_artifacts.dart';
import 'package:i_love_pao/model/menu.dart';
import 'package:i_love_pao/model/notification.dart';
import 'package:i_love_pao/model/promotions.dart';
import 'package:i_love_pao/model/recipes.dart';
import 'package:i_love_pao/screens/actions.dart';
import 'package:i_love_pao/model/backer.dart';
import 'package:i_love_pao/model/action_button.dart';
import 'package:i_love_pao/screens/menu_panel.dart';
import 'package:i_love_pao/screens/notifications_panel.dart';
import 'package:i_love_pao/screens/promotion_panel.dart';
import 'package:i_love_pao/screens/recipes_panel.dart';
import 'package:i_love_pao/screens/util/async_progress.dart';
import 'package:i_love_pao/screens/util/toast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ActionMenu extends StatefulWidget {
  ActionMenu({this.backer});

  Backer backer;

  @override
  State<StatefulWidget> createState() {
    return new ActionMenuWidget(backer: backer);
  }
}

class ActionMenuWidget extends State<ActionMenu> with TickerProviderStateMixin {
  ActionMenuWidget({this.backer});

  Backer backer;

  AnimationController _controller;

  List<ActionButton> icons = [];

  @override
  void initState() {
    icons = [
      new ActionButton('Pão Quentinho', Icons.whatshot, buildHotBread()),
      new ActionButton('Cardápio', Icons.menu, buildMenu()),
      new ActionButton('Promoções', Icons.card_giftcard, buildPromo()),
      new ActionButton('Receitas', Icons.free_breakfast, buildReceipe()),
      new ActionButton('Avaliar', Icons.stars, buildRating(backer.id))
    ];
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
              curve: new Interval(0.0, 1.0 - index / icons.length / 2.0,
                  curve: Curves.easeOut),
            ),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Chip(
                  label: new Text(icons.elementAt(index).label),
                  backgroundColor: backgroundColor,
                ),
                new FloatingActionButton(
                  heroTag: '' + icons.elementAt(index).label,
                  backgroundColor: backgroundColor,
                  mini: true,
                  child: new Hero(
                    tag: 'image-hero' + icons.elementAt(index).label,
                    child: new Icon(icons.elementAt(index).icon,
                        color: foregroundColor),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new ActionDialog(
                            action: icons.elementAt(index),
                            builder: (BuildContext context) {
                              return new Container();
                            }));
                  },
                )
              ],
            ),
          ),
        );
        return child;
      }).toList()
        ..add(
          new FloatingActionButton(
            heroTag: "Generate",
            backgroundColor: foregroundColor,
            child: new AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return new Transform(
                  transform:
                      new Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child: new Icon(
                      _controller.isDismissed ? Icons.add : Icons.close),
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

  Widget buildReceipe() {
    List<Recipes> items = backer.artifacts.recipes;
    return new ListView(children: [
      new Padding(
        padding: new EdgeInsets.all(5.0),
        child: new RecepesExpansionItems(items: items),
      )
    ]);
  }

  Widget buildMenu() {
    List<Menu> items = backer.artifacts.menu;
    return new ListView(children: [
      new Padding(
        padding: new EdgeInsets.all(5.0),
        child: new MenuExpansionItems(items: items),
      )
    ]);
  }

  Widget buildPromo() {
    List<Promotions> items = backer.artifacts.promotions;
    return new ListView(children: [
      new Padding(
        padding: new EdgeInsets.all(5.0),
        child: new PromotionExpansionItems(items: items),
      )
    ]);
  }

  Widget buildHotBread() {
    List<Notifications> items = backer.artifacts.notifications;
    return new Container(
      constraints: BoxConstraints(maxHeight: 500.0, maxWidth: 500.0),
      child: new ListView(children: [
        new Padding(
          padding: new EdgeInsets.all(5.0),
          child: new NotificationsExpansionItems(items: items),
          //child: new NotificationsItems(items: notifications),
        )
      ]),
    );
  }
}

Widget buildRating(int id) {
  StarRating _rating = new StarRating();
  RestDatasource _api = new RestDatasource();

  var progress = new AsyncProgress().initialize();
  return new Container(
    child: new Column(
      children: <Widget>[
        new Center(
          child: new Text('Qual é sua avaliação deste estabelecimento?'),
        ),
        new Container(
          child: _rating,
        ),
        new FlatButton(
          child: new Text("Confirmar"),
          onPressed: () {
            showDialog(context: _rating.context, child: progress);
            _api.saveBakeryRating(id, _rating.rating).then((value) {
              if (value) {
                MyToast.show("Avaliação cadastrada com sucesso!");
              }
              Navigator.pop(_rating.context);
              Navigator.of(_rating.context).pop();
            });
          },
        ),
      ],
      //      ),
    ),
  );
}

class StarRating extends StatefulWidget {
  StarRatingState obj;

  @override
  State<StatefulWidget> createState() {
    obj = new StarRatingState();
    return obj;
  }

  get context => obj.context;

  get rating => obj.rating;
}

class StarRatingState extends State<StarRating> {
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
