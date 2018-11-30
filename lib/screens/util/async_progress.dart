import 'package:flutter/material.dart';
import 'package:progress_hud/progress_hud.dart';

class AsyncProgress {

  ProgressHUD initialize(){
    return new ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.white,
      containerColor: Colors.blue,
      borderRadius: 5.0,
    );
  }
}
