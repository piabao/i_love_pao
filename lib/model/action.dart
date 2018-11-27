class Action {

  int _id;
  String _name;
  String _description;
  int _bakeryId;

  Action(String name, String description, int bakeryId) {
    this._name = name;
    this._description = description;
    this._bakeryId = bakeryId;
  }

  Action.fromJson(Map<String, dynamic> obj) {
    this._id = obj["id"];
    this._name = obj["name"];
    this._description = obj["description"];
    this._bakeryId = obj["bakeryId"];
  }

  int get bakeryId => _bakeryId;

  set bakeryId(int value) {
    _bakeryId = value;
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