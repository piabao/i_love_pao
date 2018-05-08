import 'package:i_love_pao/model/address.dart';

class Backer{
  String _name;
  String _icon;
  Address _address;
  bool _favorite = false;

  Backer(String name, String icon, Address add){
    this._address = add;
    this._name = name;
    this._icon = icon;
  }

  Address get address => _address;

  set address(Address value) {
    _address = value;
  }

  String get icon => _icon;

  set icon(String value) {
    _icon = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  bool get favorite => _favorite;

  set favorite(bool value) {
    _favorite = value;
  }

}