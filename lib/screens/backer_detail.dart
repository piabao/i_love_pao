import 'package:flutter/material.dart';
import 'package:i_love_pao/model/backer.dart';
import 'package:i_love_pao/screens/util/clipper.dart';
import 'package:i_love_pao/screens/util/card.dart';
import 'package:i_love_pao/screens/util/text_style.dart';
import 'package:i_love_pao/code/theme.dart';
import 'package:i_love_pao/screens/action_menu.dart';

class Details extends StatefulWidget{
  Details({this.backer});
  final Backer backer;

  @override
  State<StatefulWidget> createState() {
    return new DetailsState(backer: backer);
  }
}

class DetailsState extends State<Details>{
  DetailsState({this.backer});

  final Backer backer;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(colors: [new Color(0xCCffd162), new Color(0xCCf1fba6)],
            begin: const FractionalOffset(1.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp
          ),
        ),
        child: new Stack (
          children: <Widget>[
            _getBackground(),
            _getContent(),
            _getToolbar(context),
          ],
        ),
      ),
      floatingActionButton: new ActionMenu(backer: backer),
    );
  }

  Container _getBackground () {
    return new Container(
      child: new ClipPath(
        child: new Image.asset(backer.detailImage),
        clipper: new BottomWaveClipper(),
      )
    );
  }

  Container _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(
          top: MediaQuery.of(context).padding.top
      ),
      child: new BackButton(color: Colors.white),
    );
  }

  Widget _getContent() {
        return new ListView(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Container(
                  padding: new EdgeInsets.fromLTRB(0.0, 110.0, 46.0, 0.0),//90
                  //padding: new EdgeInsets.only(top: 110.0),//80
                  child: new BackerCard(item: this.backer),
                ),
                new Container(
                  margin: new EdgeInsets.only(left: 110.0, top: 0.0),
                  child: new Image.asset(backer.icon, width: 100.0,),
                  height: 100.0,
                  width: 100.0,
                ),
              ],
            ),
            new Container(
              padding: new EdgeInsets.symmetric(horizontal: 32.0, vertical: 15.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("VISÃO GERAL", style: Style.titleTextStyle,),
                  new Container(
                    margin: new EdgeInsets.symmetric(vertical: 8.0),
                    height: 2.0,
                    width: 18.0,
                    color: new Color(0xFF00c6ff),
                  ),
                  new Text(backer.overview, style: Style.baseTextStyle)
                ],
              ),
            ),
            new Container(
              height: 60.0,
            ),
          ],
        );
      }
}