import 'package:abc/controller/cart_controller.dart';
import 'package:abc/controller/custom_theme.dart';
import 'package:abc/controller/home_controller.dart';
import 'package:abc/custom_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

import 'controller/provider_theme_controller.dart';



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
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<ProviderThemeController>(
              create: (BuildContext context) {
                return ProviderThemeController();
              }
          ),
           ChangeNotifierProvider<CartController>(
              create: (BuildContext context) {
                return CartController();
              }
          ),
           ChangeNotifierProvider<HomeController>(
              create: (BuildContext context) {
                return HomeController();
              }
          ),
          ],
          child: CustomApp()
          );
      },
    );
  }
}

class CustomApp extends StatelessWidget {
  const CustomApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerThemeController=Provider.of<ProviderThemeController>(context);
    return MaterialApp(
      theme: ThemeData(
        brightness: providerThemeController.isDark?Brightness.dark:Brightness.light
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}