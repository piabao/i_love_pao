
import 'package:i_love_pao/model/action.dart';
import 'package:i_love_pao/model/menu.dart';
import 'package:i_love_pao/model/notification.dart';
import 'package:i_love_pao/model/promotions.dart';
import 'package:i_love_pao/model/recipes.dart';

class BakeryArtifacts {

  int _bakeryId;
  List<Action> _actions;
  List<Menu> _menu;
  List<Promotions> _promotions;
  List<Recipes> _recipes;
  List<Notification> _notifications;

  BakeryArtifacts();

  //  BakeryArtifacts(this._bakeryId, this._actions, this._menu, this._promotions,
//      this._recipes, this._notifications);

  BakeryArtifacts.fromJson(Map<String, dynamic> obj) {
    this._bakeryId = obj["bakeryId"];
    this._actions = obj["actions"];
    this._menu = obj["menu"];
    this._promotions = obj["promotions"];
    this._recipes = obj["recipes"];
    this._notifications = obj["notifications"];
  }

  List<Notification> get notifications => _notifications;

  set notifications(List<Notification> value) {
    _notifications = value;
  }

  List<Recipes> get recipes => _recipes;

  set recipes(List<Recipes> value) {
    _recipes = value;
  }

  List<Promotions> get promotions => _promotions;

  set promotions(List<Promotions> value) {
    _promotions = value;
  }

  List<Menu> get menu => _menu;

  set menu(List<Menu> value) {
    _menu = value;
  }

  List<Action> get actions => _actions;

  set actions(List<Action> value) {
    _actions = value;
  }

  int get bakeryId => _bakeryId;

  set bakeryId(int value) {
    _bakeryId = value;
  }


}