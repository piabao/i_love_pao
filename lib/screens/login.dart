import 'package:flutter/material.dart';
import 'package:i_love_pao/code/theme.dart';

class login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new loginState();
  }
}

class loginState extends State<login>{


  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Container(
          constraints: new BoxConstraints.expand(),
          decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: [CurrentTheme.gradientStart, CurrentTheme.gradientEnd],
                begin: const FractionalOffset(1.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp
            ),
          ),
          padding: new EdgeInsets.all(100.0),
          child: new Container(
            decoration: new BoxDecoration(
                //color: _semiTranlucent.withOpacity(0.2),
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    topRight: const Radius.circular(40.0)
                )
            ),

          ),
        ),
      ),
    );
  }
}