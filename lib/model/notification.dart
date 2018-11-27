
class Notification {

  int _id;
  String _name;
  String _description;
  String _type;
  DateTime _dateTime;
  int _bakeryId;


  Notification(String name, String description, String type, DateTime dateTime, int bakeryId) {
    this._name = name;
    this._description = description;
    this._type = type;
    this._dateTime = dateTime;
    this._bakeryId = bakeryId;
  }

  Notification.fromJson(Map<String, dynamic> obj) {
    this._id = obj["id"];
    this._name = obj["name"];
    this._description = obj["description"];
    this._type = obj["type"];
    this._dateTime = obj["dateTime"];
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

  String get type => _type;

  set type(String value) {
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