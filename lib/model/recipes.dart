class Recipes {

  int _id;
  String _name;
  String _description;
  String _image;
  int _bakeryId;

  Recipes(String name, String description,  String image, int bakeryId) {
    this._name = name;
    this._description = description;
    this._image = image;
    this._bakeryId = bakeryId;
  }

  Recipes.fromJson(Map<String, dynamic> obj) {
    this._id = obj["id"];
    this._name = obj["name"];
    this._description = obj["description"];
    this._image = obj["image"];
    this._bakeryId = obj["bakeryId"];
  }

  int get bakeryId => _bakeryId;

  set bakeryId(int value) {
    _bakeryId = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
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