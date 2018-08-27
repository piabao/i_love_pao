class Address {
  int _id;
  String _street;
  String _number;
  String _neighborhood;
  String _complement;
  String _city;
  String _state;
  int _cep;
  String _phone;
  String _email;
  String _lon;
  String _lat;

  Address(){}

  Address.fromJson(Map<String, dynamic> obj) {
    this._id = obj["id"];
    this._street = obj["street"];
    this._number = obj["number"];
    this._neighborhood = obj["neighborhood"];
    this._complement = obj["complement"];
    this._city = obj["city"];
    this._state = obj["state"];
    this._cep = obj["cep"];
    this._phone = obj["phone"];
    this._email = obj["email"];
    this._lon = obj["lon"];
    this._lat = obj["lat"];
  }
  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get street => _street;

  String get lat => _lat;

  set lat(String value) {
    _lat = value;
  }

  String get lon => _lon;

  set lon(String value) {
    _lon = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  int get cep => _cep;

  set cep(int value) {
    _cep = value;
  }

  String get state => _state;

  set state(String value) {
    _state = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get complement => _complement;

  set complement(String value) {
    _complement = value;
  }

  String get neighborhood => _neighborhood;

  set neighborhood(String value) {
    _neighborhood = value;
  }

  String get number => _number;

  set number(String value) {
    _number = value;
  }

  set street(String value) {
    _street = value;
  }


}