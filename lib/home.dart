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
  List products=[];
  

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
fetchProductImage()async{
 var firestoreInstance=FirebaseFirestore.instance;
 QuerySnapshot qn=await firestoreInstance.collection("products").get();
 
   for(int i=0; i<qn.docs.length; i++){
   print("${qn.docs[i]}");
   products.add(
    
     {
       "product-name":qn.docs[i]["product-name"],
       "product-description":qn.docs[i]["product-description"],
       "product-price":qn.docs[i]["product-price"],
       "product-img":qn.docs[i]["product-img"],
     }
   );
 }
 setState(() {
   
 });


}
@override
  void initState() {
    fetchImage();
    fetchProductImage();
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
        child: Container(
          width: double.infinity,
          height: 1100,
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
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  print(products);
                }, 
                child: Text("print")
                ),
              SizedBox(height: 20,),
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
              // SizedBox(height: 25,),
              Expanded(
              child:Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GridView.builder(
                  itemCount: products.length,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 20,
                  // mainAxisExtent: 190,
                  
                  childAspectRatio: 1
                  ), 
                  itemBuilder: (BuildContext,  index){
                    return Container(
                      color: Colors.red,
                    child: Card(
                      elevation: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                            aspectRatio: 2,
                            child: Image.network(products[index]["product-img"])),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${products[index]["product-name"]}",style: TextStyle(fontSize: 20),),
                                  SizedBox(height: 5,),
                                   Text("${products[index]["product-price"].toString()}",style: TextStyle(fontSize: 20),),
                                ],
                              ),
                            ),
                           
                          ],
                        ),
                    ),
                  );
                  }
                  ),
              ), 
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
               SizedBox(
                height: 50,
              ),
              CustomAccessories(
                 label: "Mahmud",
              ),
              SizedBox(height: 20,)
            ],
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
        count: slideImage.length,
      );

}
                 