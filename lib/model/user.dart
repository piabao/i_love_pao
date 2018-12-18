class User {
  int _id;
  String _username;
  String _password;
  bool _authenticated;

  User(this._username, this._password);

  User.map(dynamic obj) {
    this._id = obj["id"];
    this._username = obj["name"];
    this._password = obj["password"];
    this._authenticated = obj["authenticated"];
  }
  int get id => _id;

  set id(int value) => _id = value;

  bool get authenticated => _authenticated;
  String get username => _username;
  String get password => _password;

  void set password(String pass) => _password = pass;
  void set username(String name) => _username = name;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._username = map['username'];
    this._password = map['password'];
  }
}