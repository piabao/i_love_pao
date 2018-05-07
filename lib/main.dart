import 'package:flutter/material.dart';
import 'package:i_love_pao/screens/home.dart';
import 'package:i_love_pao/screens/login.dart';
import 'package:i_love_pao/screens/backerList.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome Page',
      home: new home(),
      routes: <String, WidgetBuilder>{
        '/home' : (BuildContext context) => new home(),
        '/login' : (BuildContext context) => new login(),
        '/backers' : (BuildContext context) => new backerList(),
      }
    );
  }
}