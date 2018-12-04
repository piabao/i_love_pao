import 'package:i_love_pao/model/address.dart';
import 'package:i_love_pao/model/bakery_artifacts.dart';

class Backer{

  int _id;
  String _name;
  String _description;
  String _logo;
  String _cardImage;
  String _site;
  String _email;
  String _topic;
  List<Address> _address;
  bool _favorite = false;
  double _averageRating = 0.0;
  BakeryArtifacts _artifacts;


  Backer(String name, String logo, String cardImg, Address addr){
    this._name = name;
    this._logo = logo;
    this._cardImage = cardImg;
    this._address = [addr];
  }

  Backer.fromId(int id){
    this._id = id;
  }

  Backer.fromJson(Map<String, dynamic> obj) {
    this._id = obj["id"];
    this._name = obj["name"];
    this._description = obj["description"];
    this._logo = obj["logo"];
    this._cardImage = obj["cardImage"];
    this._site = obj["site"];
    this._email = obj["email"];
    this._topic = obj["topic"];
    this._averageRating = obj["averageRating"];
    if(obj["addresses"] != null){
      var list = obj["addresses"].map<Address>((json) => Address.fromJson(json)).toList();
      this._address = list;
    }else{
      this._address = [new Address()];
    }
  }

  double get averageRating => _averageRating;

  set averageRating(double value) {
    _averageRating = value;
  }

  bool get favorite => _favorite;

  set favorite(bool value) {
    _favorite = value;
  }

  String get topic => _topic;

  set topic(String value) {
    _topic = value;
  }

  List<Address> get address => _address;

  set address(List<Address> value) {
    _address = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get site => _site;

  set site(String value) {
    _site = value;
  }

  String get cardImage => _cardImage;

  set cardImage(String value) {
    _cardImage = value;
  }

  String get logo => _logo;

  set logo(String value) {
    _logo = value;
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

  BakeryArtifacts get artifacts => _artifacts;

  set artifacts(BakeryArtifacts value) {
    _artifacts = value;
  }




}