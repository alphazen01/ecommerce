

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModel{
final String id;
final String title; 
final String description;
final String image;
final int price;



ProductsModel({
  
   required this.id,
   required this.title,
   required this.image,
   required this.price,
   required this.description

   });
   Map <String, dynamic>toMap()=>{
     "id":id,
     "title":title,
     "image":image,
     "price":price,
     "description":description
   };

   factory ProductsModel.fromMap(QueryDocumentSnapshot data,String id)=>ProductsModel(
     id: id,
     title: data["product-name"], 
     image: data["product-img"], 
     price: data["product-price"],
     description: data["product-description"]
     );









}