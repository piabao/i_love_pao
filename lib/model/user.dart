class User {
  String _username;
  String _password;
  bool _authenticated;

  User(this._username, this._password);

  User.map(dynamic obj) {
    this._username = obj["name"];
    this._password = obj["password"];
    this._authenticated = obj["authenticated"];
  }

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
}