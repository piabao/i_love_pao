
import 'package:fluttertoast/fluttertoast.dart';

class MyToast {
  static show(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        bgcolor: "#648CC4",
        textcolor: '#ffffff'
    );
  }

  static void error(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        bgcolor: "#d84347",
        textcolor: '#ffffff'
    );
  }
}