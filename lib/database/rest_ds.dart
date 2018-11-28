import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:i_love_pao/database/local/database_helper.dart';
import 'package:i_love_pao/database/network_util.dart';
import 'package:i_love_pao/model/backer.dart';
import 'package:i_love_pao/model/bakery_artifacts.dart';
import 'package:i_love_pao/model/user.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  DatabaseHelper db = new DatabaseHelper();

  static final LOGIN_URL = 'https://i-love-pao.herokuapp.com/user';
  static final REGISTER_URL = 'https://i-love-pao.herokuapp.com/register';
  static final BACKER_LIST = 'https://i-love-pao.herokuapp.com/bakery/getBackeryList';
  static final BACKER_ARTIFACTS = 'https://i-love-pao.herokuapp.com/bakery/getBackeryArtifacts';
  static final SAVE_BAKERY_RATING = 'https://i-love-pao.herokuapp.com/bakery/saveBakeryRating';

  Future<User> login(String username, String password) async {
    _netUtil.setAuthorization(username, password);
    return _netUtil.get(LOGIN_URL).then((dynamic res) {

      var user = new User.map(res);
//      var db = new DatabaseHelper();
//      db.saveUser(user);
      //if(res["error"]) throw new Exception(res["error_msg"]);
      return user;
    });
  }

  Future<List<Backer>> getBackerList() async {
    return _netUtil.get(BACKER_LIST).then((dynamic res) {

      print(res.toString());
      final parsed = res.cast<Map<String, dynamic>>();

      //if(res["error"]) throw new Exception(res["error_msg"]);
      return parsed.map<Backer>((json) => Backer.fromJson(json)).toList();
    });
  }

  Future<BakeryArtifacts> getBackerArtifacts(int id) async {
    return _netUtil.get(BACKER_ARTIFACTS+'/'+id.toString()).then((dynamic res) {

      print(res.toString());
      final parsed = res.cast<Map<String, dynamic>>();

      //if(res["error"]) throw new Exception(res["error_msg"]);
      return parsed.map<BakeryArtifacts>((json) => BakeryArtifacts.fromJson(json));
    });
  }

  Future<bool> saveBakeryRating(int id, double rating) async {
    return _netUtil.post( SAVE_BAKERY_RATING, body: json.encoder.convert({"bakery_id": id,"rating": rating})).then((dynamic res) {
      print(res.toString());
      final parsed = res.cast<Map<String, dynamic>>();
      if(parsed != null){
        return true;
      }
      //if(res["error"]) throw new Exception(res["error_msg"]);
      return false;
    });
  }

  Future<User> register(String username, String password) async {
    return _netUtil.geWoutAuth(REGISTER_URL+'/'+username+'/'+password).then((dynamic res) {

      var user = new User.map(res);
      return user;
    });
  }
}