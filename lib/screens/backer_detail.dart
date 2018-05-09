import 'package:flutter/material.dart';
import 'package:i_love_pao/model/backer.dart';
import 'package:i_love_pao/screens/util/clipper.dart';

class Details extends StatelessWidget{

  final Backer backer;

  Details(this.backer);

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
                    top: MediaQuery
                        .of(context)
                        .padding
                        .top),
                child: new BackButton(color: Colors.white),
              );
      }

  Widget _getContent() {
        return new ListView(
          padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
          children: <Widget>[
          ],
        );
      }
}