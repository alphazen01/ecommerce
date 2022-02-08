import 'package:abc/cart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailsScreen extends StatefulWidget {
  var product;
 DetailsScreen({ Key? key,this.product }) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int activeIndex=0;
  Future addToCart()async{
    final FirebaseAuth auth=FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef=FirebaseFirestore.instance.collection("users-cart-items");
    return collectionRef.doc(currentUser!.email).collection("items").doc().set(
      {
        "name":widget.product["product-name"],
        "price":widget.product["product-price"],
        "image":widget.product["product-img"],
      }
    ).then((value) => print("added"));
   
  }
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.redAccent,
            child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              icon: Icon(Icons.arrow_back)
            ),
          ),
        ),
        actions: [
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.redAccent,
            child: IconButton(
              onPressed: (){
              }, 
              icon: Icon(Icons.favorite_border)
            ),
          ),
        ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 CarouselSlider.builder(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    height: 300,
                    autoPlayInterval: Duration(seconds: 2),
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index),
                  ),
                  itemCount: widget.product.length,
                  itemBuilder: (context, index, realIndex) {
                    final img = widget.product["product-img"];
                    return Image.network(img,);
                  },
                ),
                Center(child: builIndicator()),
                  Text(widget.product["product-name"],style: TextStyle(fontSize: 24),),
                Text(widget.product["product-description"],style: TextStyle(fontSize: 18),),
                Text(widget.product["product-price"],style: TextStyle(fontSize: 18),),
                SizedBox(
                  height: 10,
                ),
                 ElevatedButton(
                        onPressed: () {
                          addToCart();
                        },
                        child: Text(
                          "Add to cart",
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
                      SizedBox(height: 25,)
              ]
            ),
          ),
        ),
      ),
      );
  }
   Widget buildImage(String img, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        color: Colors.grey,
        child: Image.network(
          img,
          fit: BoxFit.fill,
        ),
      );
  Widget builIndicator() => AnimatedSmoothIndicator(
        effect: ScrollingDotsEffect(
        dotHeight: 10,
        dotWidth: 10,
        activeDotColor: Colors.redAccent,
        dotColor: Colors.grey
        ),
        activeIndex: activeIndex,
        count: widget.product.length,
      );

}