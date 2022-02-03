

import 'package:flutter/material.dart';

class CustomAccessories extends StatelessWidget {
  final String? label;
  const CustomAccessories({
    Key? key,this.label
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child:  ListView.separated(
        separatorBuilder: (context,index){
          return SizedBox(
            width: 10,
          );
        },
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (BuildContext context, index){
        return Container(
          width: 100,
          height: 100,
          color: Colors.redAccent,
          child: Text("$label"),
        );
      }
    )
    );
  }
}