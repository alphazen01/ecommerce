import 'package:abc/screens/home.dart';
import 'package:abc/widget/bottom_navigationbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  static const String path = "UserdataScreen";
  const UserDataScreen({ Key? key }) : super(key: key);

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {

 TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  List<String> gender = ["Male", "Female", "Other"];


   Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year - 20),
        firstDate: DateTime(DateTime.now().year - 30),
        lastDate: DateTime(DateTime.now().year));
    if (picked != null)
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

 
  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(currentUser!.email).set({
      "name":_nameController.text,
      "phone":_phoneController.text,
      "dob":_dobController.text,
      "gender":_genderController.text,
      "age": _ageController.text,
    })
      ..then((value) => Navigator.push(
              context, MaterialPageRoute(builder: (_) => NavigationScreen())))
          .catchError((error) => print("something is wrong. $error"));
  }



   List<QueryDocumentSnapshot<Object?>> _user=[];
  Future getUser()async{
   CollectionReference instance=  FirebaseFirestore.instance.collection('users');
   instance .get().then((QuerySnapshot querySnapshot) {
       _user =querySnapshot.docs;
       print("_user:$_user");
       setState(() {
         
       });
    });
  }
  int countTotalUser(List user){
    return user.length;
  }
  @override
  void initState() {
   getUser();
    super.initState();
  }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Submit the Form and Continue",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20,
                ),
              ),
              Text(
                "We will not share your information to anyone",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Full Name",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xfff7C7C7C),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xfff7C7C7C),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _dobController,
                      decoration: InputDecoration(
                        hintText: "Date of Birth",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                          suffixIcon: IconButton(
                            onPressed: () => _selectDateFromPicker(context),
                            icon: Icon(Icons.calendar_today_outlined),
                          ),
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xfff7C7C7C),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _genderController,
                      decoration: InputDecoration(
                        hintText: "Choose your Gender",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                         prefixIcon: DropdownButton<String>(
                            items: gender.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                                onTap: () {
                                  setState(() {
                                    _genderController.text = value;
                                  });
                                },
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xfff7C7C7C),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        hintText: "Age",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xfff7C7C7C),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: ElevatedButton(
                        onPressed: () {
                          sendUserDataToDB();
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          minimumSize: Size(double.infinity, 67),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}