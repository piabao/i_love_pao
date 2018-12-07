
class Notifications {

  int _id;
  String _name;
  String _description;
  int _type;
  DateTime _dateTime;
  int _bakeryId;


  Notifications(String name, String description, int type, DateTime dateTime, int bakeryId) {
    this._name = name;
    this._description = description;
    this._type = type;
    this._dateTime = dateTime;
    this._bakeryId = bakeryId;
  }

  Notifications.fromJson(Map<String, dynamic> obj) {
    this._id = obj["id"];
    this._name = obj["name"];
    this._description = obj["description"];
    this._type = obj["type"];
    //this._dateTime = DateTime.tryParse(obj["dateTime"]);
    this._bakeryId = obj["bakeryId"];
  }

  int get bakeryId => _bakeryId;

  set bakeryId(int value) {
    _bakeryId = value;
  }

  DateTime get dateTime => _dateTime;

  set dateTime(DateTime value) {
    _dateTime = value;
  }

  int get type => _type;

  set type(int value) {
    _type = value;
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