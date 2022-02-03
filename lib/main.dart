import 'package:abc/sign_in.dart';
import 'package:abc/sign_up.dart';
import 'package:abc/user_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
  // home:SignInScreen()
  initialRoute: SignInScreen.path,
  routes: {
    SignInScreen.path:(context)=>SignInScreen(),
    SignUpScreen.path:(context)=>SignUpScreen(),
    UserDataScreen.path:(context)=>UserDataScreen()
  },
  // home: HomeScreen(),
  )
  );
}