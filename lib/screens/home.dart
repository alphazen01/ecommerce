import 'package:abc/controller/cart_controller.dart';
import 'package:abc/controller/home_controller.dart';
import 'package:abc/controller/provider_theme_controller.dart';
import 'package:abc/controller/theme_controller.dart';
import 'package:abc/product/details.dart';
import 'package:abc/screens/search.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final themeController=Get.put(ThemeController());
  int activeIndex=0;
  final slideImage=[];
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
        actions: [
                Consumer<ProviderThemeController>(
                  builder: (context, providerThemeController, child) {
                   return Switch(
                   inactiveThumbColor: Colors.red,
                   activeColor: Colors.blue,
                   value: providerThemeController.isDark, 
                   onChanged: (value){
                     if (value) {
                       providerThemeController.setDarkTheme();
                     }else{
                       providerThemeController.setLightTheme();
                     }
                   },
                  ); 
                  },

                ),
             
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 1100,
          child: Column(
            children: [
              TextField(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchScreen())),
              readOnly: true,
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
              Expanded(
              child:Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Consumer<HomeController>(
                  builder: (context,homeController,child) {
                    if (homeController.products.isEmpty) {
                      homeController.fetchProducts();
                      return Center(child: CircularProgressIndicator());
                    }
                    return GridView.builder(
                      itemCount: homeController.products.length,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1
                      ), 
                      itemBuilder: (BuildContext,  index){
                        return GestureDetector(
                          onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder:(_)=> DetailsScreen(product: homeController.products[index]))); 
                          },
                          child: Card(
                            elevation: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AspectRatio(
                                  aspectRatio: 2,
                                  child: Image.network(homeController. products[index].image)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(homeController. products[index].title,
                                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                                        SizedBox(height: 5,),
                                         Text(homeController.products[index].price.toString(),
                                         style: TextStyle(fontSize: 20,color: Colors.red),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ),
                        );
                      }
                      );
                  }
                ),
                ), 
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
                 