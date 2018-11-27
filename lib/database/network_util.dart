import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:i_love_pao/model/user.dart';

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;
  User _logged;
  var _authetication;

  final JsonDecoder _decoder = new JsonDecoder();

  void setAuthorization(String username, String password) {
    _logged = new User(username, password);
  }

  User getAuthorization (){
    return _logged;
  }

  Future<dynamic> get(String url) async {
    if(_authetication == null){
      var str = _logged.username + ":" + _logged.password;
      var bytes = utf8.encode(str);
      _authetication = base64.encode(bytes);
    }
    var response = await http.get(url,
      headers: {HttpHeaders.AUTHORIZATION: 'Basic ' + _authetication},
    );
    var responseJson = json.decode(response.body);
    int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao buscar informações");
    }

    return responseJson;
  }

  Future<dynamic> post(String url, {body, encoding}) {
    var str = _logged.username + ":" + _logged.password;
    var bytes = utf8.encode(str);
    var auth = base64.encode(bytes);
    return http
        .post(url, body: body, headers: {}, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Erro ao buscar informações");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> geWoutAuth(String url) async {
    var response = await http.get(url);
    var responseJson = json.decode(response.body);
    int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Erro ao buscar informações");
    }

    return responseJson;
  }

}