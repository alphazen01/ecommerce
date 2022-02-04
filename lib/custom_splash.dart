import 'dart:async';

import 'package:abc/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 5),
      ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>SignInScreen())));
      
 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.redAccent,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "E-Commerce",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 44,
                  //for font size have to use sp
                  fontWeight: FontWeight.bold,
                ),
              ),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}