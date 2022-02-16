

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

return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 15),
  child:Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Material(
                elevation: 5,
                child:  TextFormField(
                controller:nameController=TextEditingController(text:data["name"] ), 
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                      Icons.person,
                      color: Colors.white,
                      ),
                    ),
                  ),
                  labelText: "Name",
                  labelStyle: TextStyle(color: Colors.redAccent),
                  hintText: "Enter your name",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.red)
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.red)
                 )
                ),
              ),
              ),
              SizedBox(
                height: 25,
              ),
              Material(
            elevation: 5,
            child:  TextFormField(
            controller:phoneController=TextEditingController(text:data["phone"] ), 
            decoration: InputDecoration(
            prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                  Icons.phone_android_sharp,
                  color: Colors.white,
                  ),
                ),
              ),
              labelText: "Phone",
              labelStyle: TextStyle(color: Colors.redAccent),
              hintText: "Enter your phone number",
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
               borderSide: BorderSide(color: Colors.red)
             ),
             focusedBorder: OutlineInputBorder(
               borderSide: BorderSide(color: Colors.red)
             )
            ),
          ),
          ),
           SizedBox(
            height: 25,
              ),
            Material(
            elevation: 5,
            child:  TextFormField(
            controller:ageController=TextEditingController(text:data["age"] ), 
            decoration: InputDecoration(
              labelText: "Age",
              labelStyle: TextStyle(color: Colors.redAccent),
              hintText: "Enter your age",
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
             border: OutlineInputBorder(
               borderSide: BorderSide(color: Colors.red)
             ),
             focusedBorder: OutlineInputBorder(
               borderSide: BorderSide(color: Colors.red)
             )
            ),
          ),
          ),
          ],
          ),
        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: (){
              updateData();
            }, 
            child: Text("Update")
          ),
        )
      ],
    ),
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