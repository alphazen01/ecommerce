import 'package:abc/Model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier{

 int activeIndex=0;
  final List<String> slideImage=[];
  List<ProductsModel> products=[];
  

fetchImage()async{
 var firestoreInstance=FirebaseFirestore.instance;
 QuerySnapshot qn=await firestoreInstance.collection("h_carousel").get();
 
   for(int i=0; i<qn.docs.length; i++){
   print("${qn.docs[i]}");
   slideImage.add(qn.docs[i]["path"]);
 }


}
fetchProducts()async{
 var firestoreInstance=FirebaseFirestore.instance;
 QuerySnapshot qn=await firestoreInstance.collection("products").get();
 products.clear();
 
   for(int i=0; i<qn.docs.length; i++){
  //  print("${qn.docs.asMap() }");
   products.add(
    
    ProductsModel.fromMap(qn.docs[i] , qn.docs[i].id)
   );
 }
notifyListeners();
}










}