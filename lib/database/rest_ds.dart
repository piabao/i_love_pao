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
  User _logged;
  static final LOGIN_URL = "https://i-love-pao.herokuapp.com/user";

  static final BACKER_LIST = "https://i-love-pao.herokuapp.com/bakery/getBackeryList";

  Future<User> login(String username, String password) {
    var str = username + ":" + password;
    var bytes = utf8.encode(str);
    var auth = base64.encode(bytes);
    return _netUtil.get(LOGIN_URL, headers: {
        HttpHeaders.AUTHORIZATION: 'Basic ' + auth
    }).then((dynamic res) {
      _logged = new User.map(res["user"]);
      _logged.password = password;
      var db = new DatabaseHelper();
      db.saveUser(_logged);
      print(res.toString());
      if(res["error"]) throw new Exception(res["error_msg"]);
      return _logged;
    });
  }

  Future<List<Backer>> getBackerList() {
    return _netUtil.get(BACKER_LIST, headers: {
      "username": _logged.username,
      "password": _logged.password
    }).then((dynamic res) {

      print(res.toString());
      if(res["error"]) throw new Exception(res["error_msg"]);
      return null;
    });
  }
}