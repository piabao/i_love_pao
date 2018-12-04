
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

    var act = obj['actions'] as List;
    this._actions = act.map((i) =>
        Action.fromJson(i)
    ).toList();

    var mn = obj["menu"] as List;
    this._menu = mn.map((i) =>
        Menu.fromJson(i)
    ).toList();

    var promo = obj["promotions"] as List;
    this._promotions = promo.map((i) =>
        Promotions.fromJson(i)
    ).toList();

    var rec = obj["recipes"] as List;
    this._recipes = rec.map((i) =>
        Recipes.fromJson(i)
    ).toList();

    var not = obj["notifications"] as List;
    this._notifications = not.map((i) =>
        Notification.fromJson(i)
    ).toList();
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