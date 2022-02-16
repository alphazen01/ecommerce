import 'package:abc/controller/custom_theme.dart';
import 'package:abc/custom_splash.dart';
import 'package:abc/screens/user_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp()

  );
}
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (){
        return GetMaterialApp(
          theme: lightTheme(),
          darkTheme: darkTheme(),
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}