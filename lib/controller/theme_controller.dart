import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController{

RxBool isDark=false.obs;




void changeAppTheme(Value){
Get.changeTheme(
  Value? ThemeData.dark():ThemeData.light()
);
}





}