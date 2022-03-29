
import 'package:abc/controller/cart_controller.dart';
import 'package:abc/controller/logic_controller.dart';
import 'package:abc/product/cart_total.dart';
import 'package:abc/widget/custom_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatelessWidget {

   CartScreen({ Key? key }) : super(key: key);



  // Future addToCartForTotal()async{
  //   final FirebaseAuth auth=FirebaseAuth.instance;
  //   var currentUser = auth.currentUser;
  //   CollectionReference collectionRef=FirebaseFirestore.instance.collection("users-cart-items");
  //   return collectionRef.doc(currentUser!.email).collection("items").doc().set(
  //     {
  //       "name":widget.product["product-name"],
  //       "price":widget.product["product-price"],
  //       "image":widget.product["product-img"],
  //     }
  //   ).then((value) => print("added"));
   
  // }





  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(automaticallyImplyLeading: false,
        title: Text("Added To Cart"),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>CartTotalScreen()));
            }, 
            icon: Icon(Icons.shopping_cart)
          )
        ],
      ),
      body:SafeArea(
        child:  Padding(
              padding: const EdgeInsets.only(top: 15),
              child:  Consumer<CartController>(
                builder:(context, cartController, child) =>  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                              itemCount:cartController.cartList.length,
                              itemBuilder: ( context,index){
                                return CartItem(
                                  id: cartController.cartList[index].item.id, 
                                  image: cartController.cartList[index].item.image, 
                                  price: cartController.cartList[index].item.price, 
                                  name: cartController.cartList[index].item.title, 
                                  cartController: cartController, 
                                  quantity: cartController.cartList[index].quantity
                                );
                              }
                            )
                          
                        ),
                      
                       Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.redAccent,
                      child: Text(
                        "Total: \$"+cartController.total.toString(),
                        style: TextStyle(fontSize: 42),
                        ),
                    )
                 
                    ],
                  ),
              ),
              
           
           
            ),
      )
    );
    
  }
}

class CartItem extends StatelessWidget {
  final String id;
  final String name;
  final String image;
  final int price;
  final int quantity;
  final CartController cartController;
  const CartItem({
    Key? key,
    required this.id,
    required this.image,
    required this.price,
    required this.name,
    required this.cartController,
    required this.quantity
 
  }) : super(key: key);
delete(BuildContext context){
Provider.of<CartController>(context,listen: false).removeProduct(id);
}

   void confirmDelete(BuildContext context){
      showDialog(
             barrierDismissible: false,
            context: context, 
            builder: (BuildContext context){
              return CustomAlert(
             onTap: (){
              delete(context);
             },
                
              );
            }
            );

   }




 

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Image.network(image),
        title: Text(name,
        style: TextStyle(fontSize: 20),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(" \$${price}",
            style: TextStyle(
            color: Colors.red,fontSize: 16,fontWeight: FontWeight.w400),),
            Row(
              children: [
                
                ClipOval(
                  
                  child: Material(
                    color: Colors.red,
                    child: IconButton(
                      onPressed: (){
                        cartController.increment(id);
                      }, 
                      icon: Icon(Icons.add)
                    ),
                  ),
                ),
                 Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      quantity.toString(),
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ),
                
                ClipOval(
                  child: Material(
                    color: Colors.red,
                    child: IconButton(
                      onPressed: (){
                        cartController.decrement(id);
                      }, 
                      icon: Icon(Icons.remove)
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        trailing: GestureDetector(
          onTap: (){
          confirmDelete(context);
          },
          child: CircleAvatar(
          child: Icon(Icons.remove_circle)),
        ),
      ),
    );
  }
}

