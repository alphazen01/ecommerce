
import 'package:abc/widget/custom_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({ Key? key }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {



  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Added To Cart"),
      ),
      body:SafeArea(
        child:  Padding(
              padding: const EdgeInsets.only(top: 15),
              child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users-cart-items")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("items").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

                if(snapshot.hasError){
                  return Center(child: Text("something is wrong"));
                }


                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount:snapshot.data==null?0: snapshot.data!.docs.length,
                        itemBuilder: ( context,index){
                          DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              leading: Image.network(documentSnapshot["image"]),
                              title: Text(documentSnapshot["name"],
                              style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(" ${documentSnapshot["price"]}",
                              style: TextStyle(
                              color: Colors.red,fontSize: 16,fontWeight: FontWeight.w400),),
                              trailing: GestureDetector(
                                onTap: (){
                                 showDialog(
                                   barrierDismissible: false,
                                  context: context, 
                                  builder: (BuildContext context){
                                    return CustomAlert(
                                   onTap: (){
                                            FirebaseFirestore.instance.collection("users-cart-items")
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection("items").doc(documentSnapshot.id).delete();
                                   },
                                      
                                    );
                                  }
                                  );
                                },
                                child: CircleAvatar(
                                child: Icon(Icons.remove_circle)),
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                  // Container(
                  //   height: 100,
                  //   width: double.infinity,
                  //   color: Colors.redAccent,
                  //   child: Text(
                  //     "Total:",
                  //     style: TextStyle(fontSize: 42),
                  //     ),
                  // )








                  ],
                );
              },
           ),
           
            ),
          
        
      )
    );
    
  }
}

