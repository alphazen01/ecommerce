import 'package:abc/Model/product_model.dart';
import 'package:abc/controller/cart_controller.dart';
import 'package:abc/product/cart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailsScreen extends StatefulWidget {
  final ProductsModel product;

 DetailsScreen({ Key? key,
 required this.product,

  }) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int activeIndex=0;
  void addToCart(BuildContext context){
   Provider.of<CartController>(context,listen: false).addProduct(widget.product);
  }


  Future addToFavourite()async{
    final FirebaseAuth auth=FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef=FirebaseFirestore.instance
    .collection("users-favourite-items");
    return collectionRef.doc(currentUser!.email).collection("items").doc().set(
      {
        "name":widget.product.title,
        "price":widget.product.price,
        "image":widget.product.image,
      }
    ).then((value) => print("added to favourite"));
   
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
           StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users-favourite-items")
            .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("items").where("name",isEqualTo: widget.product.title).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data==null){
                return Text("");
              }
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: IconButton(
                    onPressed: () {
                      addToFavourite();
                    },
                    icon: snapshot.data.docs.length==0? Icon(
                      Icons.favorite_outline,
                      color: Colors.white,
                    ):Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },

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
                  itemCount:3,
                  itemBuilder: (context, index, realIndex) {
                    return Image.network(widget.product.image,);
                  },
                ),
                Center(child: builIndicator()),
                Text(widget.product.title,
                style: TextStyle(fontSize: 24),),
                Text(widget.product.description,
                style: TextStyle(fontSize: 16),),
                Text("${widget.product.price.toString()}",
                style: TextStyle(fontSize: 20,color: Colors.red),),
                SizedBox(
                  height: 10,
                ),
                 ElevatedButton(
                        onPressed: () {
                          addToCart(context);
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>CartScreen()));
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
        count: 3,
      );

}