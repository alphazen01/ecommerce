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
      body:SafeArea(
        child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users-cart-items")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

          if(snapshot.hasError){
            return Center(child: Text("something is wrong"));
          }


          return ListView.builder(
            itemCount:snapshot.data==null?0: snapshot.data!.docs.length,
            itemBuilder: ( context,index){
              DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
              return Card(
                elevation: 2,
                child: ListTile(
                  leading: Text(documentSnapshot["name"]),
                  title: Text(" ${documentSnapshot["price"]}",
                  style: TextStyle(color: Colors.red),),
                  trailing: GestureDetector(
                    onTap: (){
                      FirebaseFirestore.instance.collection("users-cart-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").doc(documentSnapshot.id).delete();
                    },
                    child: CircleAvatar(
                    child: Icon(Icons.remove_circle)),
                  ),
                ),
              );
            }
          );
        },
        
      )
      )
    );
  }
}