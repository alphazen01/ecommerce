import 'package:abc/cart.dart';
import 'package:abc/favorite.dart';
import 'package:abc/home.dart';
import 'package:abc/profile.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({ Key? key }) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedIndex=0;
  List<Widget>screens=[
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      screens.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
             
             icon:Icon(Icons.home),
              label: "Home",
              ),
              
               BottomNavigationBarItem(
              icon:Icon(Icons.shopping_cart),
              label: "Cart",
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favourite",  
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Account",
              ),
          
        ],
        
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        backgroundColor:Colors.white,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(
          color: Colors.green
        ),
       
        onTap: (int index){
          setState(() {
            selectedIndex=index;
            
            
          });
        },
      ),
    );
  }
}