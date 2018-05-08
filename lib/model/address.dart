class Address {
  String _streetName;
  int _number;
  String _district;
  String _city;
  String _state;
  int _zip;
  String _lon;
  String _lat;

  String get streetName => _streetName;

  set streetName(String value) {
    _streetName = value;
  }

  int get number => _number;

  String get lat => _lat;

  set lat(String value) {
    _lat = value;
  }

  String get lon => _lon;

  set lon(String value) {
    _lon = value;
  }

  int get zip => _zip;

  set zip(int value) {
    _zip = value;
  }

  String get state => _state;

  set state(String value) {
    _state = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get district => _district;

  set district(String value) {
    _district = value;
  }

  set number(int value) {
    _number = value;
  }


}