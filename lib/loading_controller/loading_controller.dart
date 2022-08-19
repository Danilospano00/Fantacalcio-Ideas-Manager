import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin LoadingController {

  void loadingStart() => Get.dialog(const Center(child: CircularProgressIndicator()),barrierDismissible: false);

  void loadingEnd(){
    if(Get.isDialogOpen ?? false) Get.back();
  }

}