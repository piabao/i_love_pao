import 'package:flutter/material.dart';
import 'package:i_love_pao/screens/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome Page',
      home: new home(),
    );
  }
}