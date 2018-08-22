import 'dart:async';

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
    return _netUtil.get(LOGIN_URL, headers: {
      "username": username,
      "password": password
    }).then((dynamic res) {
      _logged = new User.map(res["user"]);
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