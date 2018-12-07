
class Menu {

  int _id;
  String _name;
  String _description;
  double _price;
  String _image;
  String _unit;
  int _bakeryId;
  bool _isExpanded = false;

  Menu(String name, String description, double price, String image, String unit, int bakeryId) {
    this._name = name;
    this._description = description;
    this._price = price;
    this._image = image;
    this._unit = unit;
    this._bakeryId = bakeryId;
  }

  Menu.fromJson(Map<String, dynamic> obj) {
    this._id = obj["id"];
    this._name = obj["name"];
    this._description = obj["description"];
    this._price = obj["price"];
    this._image = obj["image"];
    this._unit = obj["unit"];
    this._bakeryId = obj["bakeryId"];
  }

  bool get isExpanded => _isExpanded;

  set isExpanded(bool value) {
    _isExpanded = value;
  }

  int get bakeryId => _bakeryId;

  set bakeryId(int value) {
    _bakeryId = value;
  }

  String get unit => _unit;

  set unit(String value) {
    _unit = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }


}