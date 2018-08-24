import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:i_love_pao/database/local/database_helper.dart';
import 'package:i_love_pao/database/network_util.dart';
import 'package:i_love_pao/model/backer.dart';
import 'package:i_love_pao/model/user.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  DatabaseHelper db = new DatabaseHelper();

  static final LOGIN_URL = 'https://i-love-pao.herokuapp.com/user';

  static final BACKER_LIST = 'https://i-love-pao.herokuapp.com/bakery/getBackeryList';

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

  Future<List<Backer>> getBackerList() {
    return _netUtil.get(BACKER_LIST).then((dynamic res) {

      print(res.toString());
      if(res["error"]) throw new Exception(res["error_msg"]);
      return res;
    });
  }
}