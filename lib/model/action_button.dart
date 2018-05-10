import 'package:flutter/material.dart';

class ActionButton {

  ActionButton(String label, IconData icon, List<Widget> widgets){
     this._icon = icon;
     this._label = label;
     this._widgets = widgets;
  }

  String _label;
  IconData _icon;
  List<Widget> _widgets;

  String get label => _label;

  set label(String value) {
    _label = value;
  }

  IconData get icon => _icon;

  set icon(IconData value) {
    _icon = value;
  }

  List<Widget> get widgets => _widgets;

  set widgets(List<Widget> value) {
    _widgets = value;
  }

}