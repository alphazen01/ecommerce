

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? ageController;

updateData(){
 CollectionReference collectionRef=FirebaseFirestore.instance.collection("users-form-data");
 return collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
  {
     "name":nameController!.text,
     "phone":phoneController!.text,
     "age":ageController!.text,
  }
 ).then((value) => print("Updated Successfully"));
}
setDataToTextfield(data){

return Column(
          children: [
            TextField(
              controller: nameController=TextEditingController(text:data["name"] ),
            ),
            TextField(
              controller: phoneController=TextEditingController(text:data["phone"] ),
            ),
            TextField(
              controller: ageController=TextEditingController(text:data["age"] ),
            ),
            ElevatedButton(
              onPressed: (){
                updateData();
              }, 
              child: Text("Update")
            )
          ],
        );

}


  @override
  Widget build(BuildContext context) {
     return Scaffold(
       
       appBar: AppBar(
         centerTitle: true,
         elevation: 0,
         backgroundColor: Colors.white,
         title: Text(
           "Edit Profile",
           style: TextStyle(color: Colors.black),
        ),
       ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          var data=snapshot.data;

          if(data==null){
            return Center(child: CircularProgressIndicator());
          }


          return setDataToTextfield(data);
        },
        
      )
    );
  }
}