import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(Icons.threed_rotation)
            ],
          ),
          shape: CircularNotchedRectangle(),
          color: Colors.white,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Align(
            alignment: Alignment.bottomCenter,
            child:  ElevatedButton(
                      onPressed: () {
                      },
                      child: Text(
                        "SIGN IN",
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
          )
        )
    );
  }
}
   