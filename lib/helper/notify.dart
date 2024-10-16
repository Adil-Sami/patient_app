
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

successNotify(msg){
  Get.snackbar(
    "Success",
    msg,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.green,
    colorText: Colors.white
  );
}

errorNotify(msg){
  Get.snackbar(
    "Success",
    msg,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.red,
      colorText: Colors.white
  );
}

// infoNotify(msg){
//   Get.snackbar(
//     "Success",
//     msg,
//     snackPosition: SnackPosition.BOTTOM,
//   );
// }
