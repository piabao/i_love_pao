import 'package:flutter/material.dart';
import 'package:i_love_pao/database/rest_ds.dart';
import 'package:i_love_pao/model/backer.dart';
import 'package:i_love_pao/model/bakery_artifacts.dart';
import 'package:i_love_pao/screens/util/clipper.dart';
import 'package:i_love_pao/screens/util/card.dart';
import 'package:i_love_pao/screens/util/text_style.dart';
import 'package:i_love_pao/code/theme.dart';
import 'package:i_love_pao/screens/action_menu.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cached_network_image/cached_network_image.dart';

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
  RestDatasource api = new RestDatasource();
  final Backer backer;

  @override
  void initState() {
    super.initState();
    //getArtifacts();
  }

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
        child: CachedNetworkImage(
          placeholder: CircularProgressIndicator(),
          imageUrl: backer.cardImage,
        ),
        clipper: new BottomWaveClipper(),
      )
    );
  }

  Container _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          right: MediaQuery.of(context).padding.right
      ),
      child: new BackButton(color: Colors.white),
    );
  }

  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Mapa não encontrado $url';
    }
  }

  Widget _getContent() {
    var lon;
    var lat;
    if(backer.address.isNotEmpty){
      lon = backer.address[0].lon;
      lat = backer.address[0].lat;
    }

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
                  alignment: Alignment.center,
                  //margin: new EdgeInsets.only(left: 110.0, top: 0.0),
                  child: CachedNetworkImage(
                    placeholder: CircularProgressIndicator(),
                    width: 100.0,
                    imageUrl: backer.logo,
                  ),//new Image.asset(backer.logo, width: 100.0,),
                  height: 100.0,
                 // width: 100.0,
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
                  new Text(backer.description, style: Style.baseTextStyle),
                  lon != null ? new Container(
                    padding: new EdgeInsets.all(5.0),
                    child: new RaisedButton(child: new Text('Localização'),
                        onPressed: (){
                          setState((){
                            //apiCall=true; // Set state like this
                          });
                          _launchMapsUrl(lat, lon);
                        }),
                  ) : new Container(child: new RaisedButton(onPressed: null,  child: new Text("Localização não disponivel"))),
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