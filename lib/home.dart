import 'package:abc/widget/custom_accessories.dart';
import 'package:abc/widget/custom_product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int activeIndex=0;
  final slideImage=[ ];
  

fetchImage()async{
 var firestoreInstance=FirebaseFirestore.instance;
 QuerySnapshot qn=await firestoreInstance.collection("h_carousel").get();
 
   for(int i=0; i<qn.docs.length; i++){
   print("${qn.docs[i]}");
   slideImage.add(qn.docs[i]["path"]);
 }
 setState(() {
   
 });


}
@override
  void initState() {
    fetchImage();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Ecommerce",
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
          decoration: InputDecoration(
            hintText: "Search products here",
            fillColor: Color(0xffF2F2F7),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: Colors.grey
              ),
            ),
            focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey,
             ) 
            ),
            suffixIcon: Container(
              height: 50,
              child: Material(
                  color: Colors.redAccent,
                  child: Icon(
                    Icons.search,color: Colors.white,
                  )
                ),
            ),
            )
            ),
             Builder(
               builder: (context) {
                 return slideImage.length>0? CarouselSlider.builder(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      height: 300,
                      autoPlayInterval: Duration(seconds: 2),
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index),
                    ),
                    itemCount: slideImage.length,
                    itemBuilder: (context, index, realIndex) {
                      final img = slideImage[index];
                      return Image.network(img,);
                    },
                  ):CircularProgressIndicator();
               }
             ),
              builIndicator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               TextButton(
                 onPressed: (){}, 
                 child: Text(
                   "Top Products",
                   style: TextStyle(
                     color: Colors.redAccent,
                   ),
                  )
                ),
                 TextButton(
                 onPressed: (){}, 
                 child: Row(
                   children: [
                     Text(
                       "View All",
                    style: TextStyle(
                     color: Colors.redAccent,
                     ),
                      ),
                      SizedBox(width: 5,),
                     Icon(
                       Icons.arrow_forward_ios,
                       color: Colors.redAccent,
                       size: 10,
                      )
                   ],
                 )
                )  
              ],
            ),
            CustomProducts(
              label: "parvej",
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               TextButton(
                 onPressed: (){}, 
                 child: Text(
                   "Accessories",
                   style: TextStyle(
                     color: Colors.redAccent,
                   ),
                  )
                ),
                 TextButton(
                 onPressed: (){}, 
                 child: Row(
                   children: [
                     Text(
                       "View All",
                    style: TextStyle(
                     color: Colors.redAccent,
                     ),
                      ),
                      SizedBox(width: 5,),
                     Icon(
                       Icons.arrow_forward_ios,
                       color: Colors.redAccent,
                       size: 10,
                      )
                   ],
                 )
                )  
              ],
            ),
            Image.asset("assets/test_photo.jpg"),
             SizedBox(
              height: 50,
            ),
            CustomAccessories(
               label: "Mahmud",
            ),
          ],
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
        count: slideImage.length,
      );

}
