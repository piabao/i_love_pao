import 'package:i_love_pao/model/address.dart';

class Backer{
  String _name;
  String _icon;
  Address _address;
  bool _favorite = false;
  String _detailImage;
  String _overview;

  Backer(String name, String icon, String detailImage, Address add){
    this._detailImage = detailImage;
    this._address = add;
    this._name = name;
    this._icon = icon;
  }

  String get overview => _overview;

  set overview(String value) {
    _overview = value;
  }

  String get detailImage => _detailImage;

  set detailImage(String value) {
    _detailImage = value;
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