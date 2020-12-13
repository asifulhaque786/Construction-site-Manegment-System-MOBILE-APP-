import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:civil/MainScreen.dart';
import 'package:civil/animation/FadeIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
final usernamecontroller123 = new TextEditingController();
final passwordcontroller2 = new TextEditingController();
final _authenticateuser = FirebaseAuth.instance;
//import 'package:untitled/chatscreenwidgets/newchatInputbox.dart';
bool data1;
bool progress = false;
final authenticate = FirebaseAuth.instance;
FirebaseUser loggedInperson;
String emailId;
//final firestore = Firestore.instance;


class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LogInState();
  }
}

class LogInState extends State<LogIn> {




  @override
  Widget build(BuildContext context) {
    double width1 = MediaQuery.of(context).size.width;
    double height1 = MediaQuery.of(context).size.height;
    void getcurrentperson() async {
      try {
        final user = await authenticate.currentUser();

        if (user != null) {
          loggedInperson = user;
          emailId = loggedInperson.email.toString().toUpperCase();
          print(loggedInperson.email);
          Navigator.of(context).popAndPushNamed("page5");
          Fluttertoast.showToast(
              msg: "you have been loged in",
              backgroundColor: Colors.green,
              textColor: Colors.white);

        }
      } catch (e) {
        print(e);
      }
    };

    getcurrentperson();
    return MaterialApp(debugShowCheckedModeBanner: false,
      /*theme: ThemeData(fontFamily: 'Lobster'),*/
      home: Scaffold(
        backgroundColor: Colors.white,
        body: (progress == true)
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                  margin: EdgeInsets.all(8),
                  child: CircularProgressIndicator()),
            ),
            Text(
              "LOADING....",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue),
            )
          ],
        )
            : ListView(children: <Widget>[
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                FadeIn(
                  1,
                  Container(
                    width: double.infinity,
//                      margin: EdgeInsets.all(5),
                    height: 340,
                    margin: EdgeInsets.only(right: 30, left: 30, top: 0),
                    child: Image.asset(
                      'assets/pic2.png',
                      height: height1 / 1.3,
                      width: width1 / 1.3,
                    ),
//                    image: AssetImage("assets/pic2.png"),

                  ),
                ),
                FadeIn(
                  2,
                  Container(
                    margin: EdgeInsets.only(top: 5, left: width1/15, right:width1/15),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.lightGreen,
                          blurRadius: 20,
                          offset: Offset(10, 10))
                    ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: usernamecontroller123,
                        autocorrect: true,
                        cursorColor: Colors.black,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "EMAIL ID",
                          icon: Icon(Icons.account_circle,color: Colors.green,),
                        )),
                  ),
                ),
                FadeIn(
                  3,
                  Container(
                    margin: EdgeInsets.only(top: 20, left: width1/15, right:width1/15),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.lightGreen,
                          blurRadius: 20,
                          offset: Offset(10, 10))
                    ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                        controller: passwordcontroller2,
                        cursorColor: Colors.black,
                        enableSuggestions: true,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "PASSWORD",
                          icon: Icon(Icons.lock,color: Colors.green,),
                        )),
                  ),
                ),
                FadeIn(
                  4,
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightGreen,
                    ),
                    child: FlatButton(
                      onPressed: () async {
                        if (passwordcontroller2.text.isEmpty ||
                            usernamecontroller123.text.isEmpty) {
                          if (passwordcontroller2.text.isEmpty == true) {
                            Fluttertoast.showToast(msg: "feild empty");
                          }
                          if (usernamecontroller123.text.isEmpty == true) {
                            Fluttertoast.showToast(msg: "feild empty");
                          }
                        } else {
                          setState(() {
                            progress = true;
                          });
                          try {
                            final user2 = await _authenticateuser
                                .signInWithEmailAndPassword(
                              email: usernamecontroller123.text,
                              password: passwordcontroller2.text,
                            );
                            if (user2 != null) {
                              Fluttertoast.showToast(
                                  msg: "you have been loged in",
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white);

//                              getcurrentperson();
//                              Navigator.pushAndRemoveUntil(
//                                context,
//                                MaterialPageRoute(builder: (context) => MainScreen()),
//                                    (Route<dynamic> route) => false,
//                              );
                              Navigator.of(context).popAndPushNamed("page5");
                            } else {

                            }
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg: e.message.toString(),
                                backgroundColor: Colors.red,
                                textColor: Colors.white);
                          }
                          setState(() {
                            progress = false;
                          });
                        }
                      },
                      child: Text(
                        "  LOGIN  ",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

//                FadeIn(
//                  4,
//                  Container(
////                      margin: EdgeInsets.all(20),
//                      child: FlatButton(
//                        child: Text("forgot password?",style: TextStyle(color: Colors.black),),
//                        onPressed: () {
//                          Navigator.of(context).pushNamed("page4");
//                        },
//                      )),
//                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

