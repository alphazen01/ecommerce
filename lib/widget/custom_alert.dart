import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final void Function() onTap;
  const CustomAlert({ Key? key,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text("Are you sure"),
      actions: [
        TextButton(
          onPressed: (){
           onTap(); Navigator.pop(context);
          }, 
          child: Text("Yes")
         ),
         TextButton(
          onPressed: (){
             Navigator.pop(context);
          }, 
          child: Text("No")
         )
      ],
    );
  }
}