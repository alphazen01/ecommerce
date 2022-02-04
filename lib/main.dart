import 'package:abc/custom_splash.dart';
import 'package:abc/sign_in.dart';
import 'package:abc/sign_up.dart';
import 'package:abc/user_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp()
//   MaterialApp(
//     debugShowCheckedModeBanner: false,
//   // home:SignInScreen()
//   initialRoute: SignInScreen.path,
//   routes: {
//     SignInScreen.path:(context)=>SignInScreen(),
//     SignUpScreen.path:(context)=>SignUpScreen(),
//     UserDataScreen.path:(context)=>UserDataScreen()
//   },
//   // home: HomeScreen(),
//   )
  );
}
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}