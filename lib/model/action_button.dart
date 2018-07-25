import 'package:flutter/material.dart';

class ActionButton {

  ActionButton(String label, IconData icon, Widget widget){
     this._icon = icon;
     this._label = label;
     this._widget = widget;
  }

  String _label;
  IconData _icon;
  Widget _widget;

  String get label => _label;

  set label(String value) {
    _label = value;
  }

  IconData get icon => _icon;

  set icon(IconData value) {
    _icon = value;
  }

  Widget get widget => _widget;

  set widget(Widget value) {
    _widget = value;
  }

}