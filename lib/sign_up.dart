import 'package:abc/sign_in.dart';
import 'package:abc/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  static const String path = "SignUpScreen";
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
 TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  bool istap = false;

  signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      var authCredential = userCredential.user;
      print(authCredential!.uid);

      if (authCredential.uid.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => UserDataScreen()));
      } else {
        Fluttertoast.showToast(msg: "Something is Wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              height: 800,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Buddy!",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Glad to see you my buddy",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Icon(
                                    Icons.mail_outline,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              labelText: "Email",
                              labelStyle: TextStyle(color: Colors.redAccent),
                              hintText: "xyz@gmail.com",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xfff7C7C7C),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !istap,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.redAccent),
                              suffixIcon: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(istap
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xfff7C7C7C),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                       signUp();
                      },
                      child: Text(
                        "Continue",
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
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Do you have an account?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignInScreen.path);
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      istap = !istap;
    });
  }
}