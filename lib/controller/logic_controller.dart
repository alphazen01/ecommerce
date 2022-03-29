import 'package:get/get.dart';

class LogicController extends GetxController{

RxInt count=0.obs;

increaseCount(){

  count++;
}


decreaseCount(){
if (count>0) {
  count--;
}
  
}









}