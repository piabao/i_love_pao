import 'package:i_love_pao/model/backer.dart';

class Network {
  int _id;
  String _name;
  String _description;
  Backer _bakery;

  Network(String name, String description, Backer bakery) {
    this._name = name;
    this._description = description;
    this._bakery = bakery;
  }

  Network.fromJson(Map<String, dynamic> obj) {
    this._id = obj["id"];
    this._name = obj["name"];
    this._description = obj["description"];
    if(obj["bakery"] != null){
      this._bakery = Backer.fromJson(obj["bakery"]);
    }
  }

  Backer get bakery => _bakery;

  set bakery(Backer value) {
    _bakery = value;
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
