import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:i_love_pao/model/user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  final String tableUser = 'User';
  final String columnId = 'id';
  final String columnName = 'username';
  final String columnPass = 'password';

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, "main.db");
//    await deleteDatabase(path); // just for testing
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }


  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
    print("Created tables");
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    var usr = await getUser();
    if(usr != null){
      var del = await deleteUsers();
    }
    var res = await dbClient.insert("User", user.toMap());
    print("User inserido");
    return res;
  }

  Future<User> getUser() async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableUser,
        columns: [columnId, columnName, columnPass]
        //where: '$columnId = ?',
       // whereArgs: [id]
    );
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new User.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteUsers() async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  Future<bool> isLoggedIn() async {
    var dbClient = await db;
    var res = await dbClient.query("User");
    return res.length > 0? true: false;
  }

}