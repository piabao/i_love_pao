import 'package:flutter/material.dart';
import 'package:i_love_pao/screens/home.dart';
import 'package:i_love_pao/screens/login.dart';
import 'package:i_love_pao/screens/backer_list.dart';
import 'package:i_love_pao/screens/backer_detail.dart';
import 'package:i_love_pao/model/backer.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  Backer item;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome Page',
      home: new home(),
      routes: <String, WidgetBuilder>{
        '/home' : (BuildContext context) => new home(),
        '/login' : (BuildContext context) => new Login(),
        '/backers' : (BuildContext context) => new backerList(),
        //'/details/$item' : (BuildContext context) => new Details(item),
      }
    );
  }
}