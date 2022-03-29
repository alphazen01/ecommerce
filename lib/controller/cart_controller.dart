
import 'package:abc/Model/cart_model.dart';
import 'package:abc/Model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class CartController extends ChangeNotifier{

double total=0;


Map<String,CartModel> cartItems={};
List<CartModel>cartList =[];

void addProduct(ProductsModel product){
  print(cartItems.length);
  print(product.id);
cartItems.putIfAbsent(product.id, () => CartModel(item: product),);
print("cart Item"+cartItems.length.toString());
cartList=cartItems.values.toList();
print("cart List"+cartList.length.toString());
calculateTotal();
notifyListeners();
}
void increment(String id){
 cartItems[id]?.quantity++;
 calculateTotal();
  notifyListeners();
}

void decrement(String id){
  final CartModel? item=cartItems[id];
  if (item==null||item.quantity<2) {
    return;
  }else{
    cartItems[id]?.quantity--;
    calculateTotal();
  notifyListeners();
  }
 
}
void calculateTotal(){
  total=0;
  cartList.forEach((element) {total+=(element.price*element.quantity); });
}
void removeProduct(String id){
cartItems.remove(id);
cartList=cartItems.values.toList();
calculateTotal();
notifyListeners();
}




}