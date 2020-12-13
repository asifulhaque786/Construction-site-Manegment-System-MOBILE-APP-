import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//import 'file:///C:/Users/asifu/IntelliJIDEAProjects/myknot/lib/chess/EventPage.dart';
var userget = false;
var check67;var filled=false;
var emailId = "";
final time = DateTime.now();
String formattedDate = DateFormat('dd-MM-yyyy').format(time);
var site = "";
var loggedInperson;
var me = "";
var val1 = 0;
var uidglobal;
var _firebaseRef67;
var _firebaseRef671;

var siteid = "";
var place34 = "";
var lat;
var long;

void getpost() async {
  Position position = await Geolocator()
      .getLastKnownPosition(desiredAccuracy: LocationAccuracy.medium);
  lat = position.latitude;
  long = position.longitude;
}

final authenticate12 = FirebaseAuth.instance;

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<void> _launched;

  void getcurrentperson() async {
    try {
      final authenticate = FirebaseAuth.instance;

      final user = await authenticate.currentUser();
      final uid = user.uid;
      uidglobal = uid;

      await FirebaseDatabase.instance
          .reference()
          .child('users')
          .child(uid.toString())
          .once()
          .then((DataSnapshot snapshot) async {
        Map<dynamic, dynamic> values = snapshot.value;
        if (values['name'] == null) {
          me = "..";
        } else {
          me = values["name"].toString().toUpperCase();
        }
        if (values['id'] == null) {
          site = "..";
        } else {
          place34 = values['place'].toString();
          site = values["id"].toString();
          _firebaseRef67 = await FirebaseDatabase()
              .reference()
              .child("sites")
              .child(site)
              .child("DATABASE")
              .child(formattedDate);
   var data;
          _firebaseRef67.once().then((DataSnapshot snapshot){
            Map<dynamic, dynamic> values = snapshot.value;

            data=  values["setstate"].toString();print(data);
            if(data=="1"){setState(() {
              filled=true;
            });}
          });

          _firebaseRef671 = await FirebaseDatabase()
              .reference()
              .child("users")
              .child(uid.toString());

          setState(() {
            userget = true;
          });
        }
      });
      ;
      if (user != null) {
        loggedInperson = user;
        emailId = loggedInperson.email.toString().toUpperCase();
        print(loggedInperson.email);
      } else {}
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getcurrentperson();
    getpost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final drawerhead = UserAccountsDrawerHeader(
      arrowColor: Colors.green,
      decoration: BoxDecoration(color: Colors.green),
      accountName: Text("Hi, " + "$me"),
      accountEmail: Text("$emailId"),
      currentAccountPicture: CircleAvatar(
        child: FlutterLogo(
          colors: Colors.green,
          size: 42,
        ),
        backgroundColor: Colors.white,
      ),
    );
    final draweritems = ListView(
      children: <Widget>[
        drawerhead,
        Container(
            alignment: Alignment.topLeft,
            //margin: EdgeInsets.only(left: 5, bottom: 50),
            child: RaisedButton(
              child: Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.error,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text("TERMS OF SERVICE"),
                      ),
                    ],
                  )),
              color: Colors.white,
              onPressed: () {},
            )),
        Container(
            alignment: Alignment.topLeft,
            //margin: EdgeInsets.only(left: 5, bottom: 50),
            child: RaisedButton(
              child: Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.call_missed_outgoing,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text("SIGN  OUT"),
                      ),
                    ],
                  )),
              color: Colors.white,
              onPressed: () {
                authenticate12.signOut();
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: "logged out",
                    backgroundColor: Colors.red,
                    textColor: Colors.white);
                Navigator.of(context).pushNamed('page2');
              },
            )),
      ],
    );
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    return (userget == true)
        ?(filled==false)? Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Neptune - Daily Tracker"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
              print("new");
            },
          ),
        ],
      ),
      drawer: Drawer(child: draweritems),
      body: StreamBuilder(
          stream: _firebaseRef67.onValue,
          builder: (context, snap) {
            if (!snap.hasData) {
              return Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      "LOADING....",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ));
            }

            if (snap.data.snapshot.value == null) {
              return Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 100),
                          child:
                          Center(child: Text("SHEET NOT GENERATED"))),
                    ],
                  ));
            } else {
              DataSnapshot snapshot9 = snap.data.snapshot;
              final value = snapshot9.value;
//                    final id = value['id'];
//                    final place = value['place'];

              return StreamBuilder(
                  stream: _firebaseRef671.onValue,
                  builder: (context, snap1) {
                    if (!snap1.hasData) {
                      return Container(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              "LOADING....",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 20),
                            ),
                          ));
                    }

                    if (snap1.data.snapshot.value == null) {
                      return Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height,
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(top: 100),
                                  child:
                                  Center(child: Text("USER  NOT THERE"))),
                            ],
                          ));
                    } else {
                      DataSnapshot snapshot91 = snap1.data.snapshot;
                      final value1 = snapshot91.value;
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 30, right: 30, bottom: 10, top: 20),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Hello,",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 35,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      "$me",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                CircleAvatar(
                                  radius: 35,
                                  child: FlutterLogo(
                                    colors: Colors.green,
                                    size: 50,
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0xff818181),
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 5,
                                ),
                                child: Text(
                                  "ENTERING DETAILS FOR",
                                  style: TextStyle(fontSize: 17),
                                )),
                            Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 20, bottom: 1),
                                child: Text(
                                  "SITE: ($site)($place34)",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )),
                            Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "DATE: $formattedDate",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 17),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 12,
                                child: value1['datad']['data']['set']
                                    .toString() == "0" ? RaisedButton(
                                  elevation: 10,
                                  color: Colors.white,
                                  child: Text("ADD JCB TIME",
                                      style: TextStyle(fontSize: 17)),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('page3');
                                  },
                                )
                                    :
                                Stack(children: <Widget>[
                                  Positioned(right: 0,
                                    left: 0,
                                    bottom: 0,
                                    top: 0,
                                    child: RaisedButton(
                                      elevation: 10,
                                      color: Colors.white,
                                      child: Text("ADD JCB TIME",
                                          style: TextStyle(fontSize: 17,
                                              color: Colors.black)),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            'page3');
                                      },
                                    ),
                                  ),
                                  Positioned(right: 5,
                                      child: IconButton(icon: Icon(
                                        Icons.done_outline,
                                        color: Colors.green,),
                                        onPressed: null,))
                                ])),
                            Container(
                                margin: EdgeInsets.only(top: 17),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 12,
                                child: value1['datad']['data4']['set']
                                    .toString() == "0" ? RaisedButton(
                                  elevation: 10,
                                  color: Colors.white,
                                  child: Text("ADD EB TIME",
                                      style: TextStyle(fontSize: 17)),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('page7');
                                  },
                                ) : Stack(children: <Widget>[
                                  Positioned(right: 0,
                                    left: 0,
                                    bottom: 0,
                                    top: 0,
                                    child: RaisedButton(
                                      elevation: 10,
                                      color: Colors.white,
                                      child: Text("ADD EB TIME",
                                          style: TextStyle(fontSize: 17,
                                              color: Colors.black)),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            'page7');
                                      },
                                    ),
                                  ),
                                  Positioned(right: 5,
                                      child: IconButton(icon: Icon(
                                        Icons.done_outline,
                                        color: Colors.green,),
                                        onPressed: null,))
                                ])),
                            Container(
                                margin: EdgeInsets.only(top: 17),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 12,
                                child: value1['datad']['data3']['set']
                                    .toString() == "0" ? RaisedButton(
                                  elevation: 10,
                                  color: Colors.white,
                                  child: Text("ADD MACHINE TIME",
                                      style: TextStyle(fontSize: 17)),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('page6');
                                  },
                                ) : Stack(children: <Widget>[
                                  Positioned(right: 0,
                                      left: 0,
                                      bottom: 0,
                                      top: 0,
                                      child: RaisedButton(
                                        elevation: 10,
                                        color: Colors.white,
                                        child: Text("ADD MACHINE TIME",
                                            style: TextStyle(fontSize: 17,
                                                color: Colors.black)),
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              'page6');
                                        },
                                      )),
                                  Positioned(right: 5, child: IconButton(
                                    icon: Icon(
                                      Icons.done_outline, color: Colors.green,),
                                    onPressed: null,))
                                ])),
                            Container(
                                margin: EdgeInsets.only(top: 17),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 12,
                                child: value1['datad']['data2']['set']
                                    .toString() == "0" ? RaisedButton(
                                  elevation: 10,
                                  color: Colors.white,
                                  child: Text("ADD ATTENDENCE",
                                      style: TextStyle(fontSize: 17)),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('page4');
                                  },
                                ) : Stack(children: <Widget>[
                                  Positioned(right: 0,
                                      left: 0,
                                      bottom: 0,
                                      top: 0,
                                      child: RaisedButton(
                                        elevation: 10,
                                        color: Colors.white,
                                        child: Text("ADD ATTENDENCE",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black)),
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              'page4');
                                        },
                                      )),
                                  Positioned(right: 5, child: IconButton(
                                    icon: Icon(
                                      Icons.done_outline, color: Colors.green,),
                                    onPressed: null,))
                                ])),
                            Container(
                                margin: EdgeInsets.only(top: 17),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 12,
                                child: value1['datad']['data7']['set']
                                    .toString() == "0" ? RaisedButton(
                                  elevation: 10,
                                  color: Colors.white,
                                  child: Text("ADD OTHER EXPENSE",
                                      style: TextStyle(fontSize: 17)),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('page112');
                                  },
                                ) : Stack(children: <Widget>[
                                  Positioned(right: 0,
                                      left: 0,
                                      bottom: 0,
                                      top: 0,
                                      child: RaisedButton(
                                        elevation: 10,
                                        color: Colors.white,
                                        child: Text("ADD OTHER EXPENSE",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black)),
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              'page112');
                                        },
                                      )),
                                  Positioned(right: 5, child: IconButton(
                                    icon: Icon(
                                      Icons.done_outline, color: Colors.green,),
                                    onPressed: null,))
                                ])),
                            Container(
                                margin: EdgeInsets.only(top: 17),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 12,
                                child: value1['datad']['data5']['set']
                                    .toString() == "0" ? RaisedButton(
                                  elevation: 10,
                                  color: Colors.white,
                                  child: Text("ADD PROCESSED VALUE",
                                      style: TextStyle(fontSize: 17)),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('page8');
                                  },
                                ) : Stack(children: <Widget>[
                                  Positioned(right: 0,
                                      left: 0,
                                      bottom: 0,
                                      top: 0,
                                      child: RaisedButton(
                                        elevation: 10,
                                        color: Colors.white,
                                        child: Text("ADD PROCESSED VALUE",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black)),
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              'page8');
                                        },
                                      )),
                                  Positioned(right: 5, child: IconButton(
                                    icon: Icon(
                                      Icons.done_outline, color: Colors.green,),
                                    onPressed: null,))
                                ])),
                            Container(
                                margin: EdgeInsets.only(top: 17),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 12,
                                child: value1['datad']['data6']['set']
                                    .toString() == "0" ? RaisedButton(
                                  elevation: 10,
                                  color: Colors.white,
                                  child: Text("ADD PHOTOS",
                                      style: TextStyle(fontSize: 17)),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('page11');
                                  },
                                ) : Stack(children: <Widget>[
                                  Positioned(right: 0,
                                      left: 0,
                                      bottom: 0,
                                      top: 0,
                                      child: RaisedButton(
                                        elevation: 10,
                                        color: Colors.white,
                                        child: Text("ADD PHOTOS",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black)),
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              'page11');
                                        },
                                      )),
                                  Positioned(right: 5, child: IconButton(
                                    icon: Icon(
                                      Icons.done_outline, color: Colors.green,),
                                    onPressed: null,))
                                ])),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Hexcolor('#FF9900')),
                                margin: EdgeInsets.only(top: 17, bottom: 30),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 16,
                                child: RaisedButton(
                                  elevation: 10,
                                  color: Colors.orange,
                                  child: Text("SUBMIT",
                                      style: TextStyle(fontSize: 17)),
                                  onPressed: () async {
                                    try {
                                      final authenticate =
                                          FirebaseAuth
                                          .instance;

                                      final user =
                                      await
                                      authenticate.currentUser();
                                      final uid = user.uid;
                                      print(uid);
                                      FirebaseDatabase.instance
                                          .reference()
                                          .child('users')
                                          .child(uid.toString())
                                          .once()
                                          .then((DataSnapshot snapshot) async {
                                        Map<dynamic, dynamic> values =
                                            snapshot.value;
                                        if (values['datad']['data4']
                                        ["ebtimeon"] == "" ||
                                            values['datad']['data4']
                                            ["ebtimeoff"] == "" ||
                                            values['datad']['data5']
                                            ["processed"] == "" ||
                                            values['datad']['data']["jcbto"] ==
                                                "" ||
                                            values['datad']['data']["jcbfrom"] ==
                                                "" ||
                                            values['datad']['data']
                                            ["jcbfromhr"] == "" ||
                                            values['datad']
                                            ['data']["jcbfrommin"] == "" ||
                                            values['datad']['data']["jcbtohr"] ==
                                                "" ||
                                            values['datad']
                                            ['data3']["machinefromhr"] == "" ||
                                            values['datad']['data4']
                                            ["ebfromhr"] == "" ||
                                            values['datad']['data6']["image1"] ==
                                                "" ||
                                            values['datad']['data6']["image3"] ==
                                                "" ||
                                            values['datad']['data6']["image2"] ==
                                                "" ||
                                            values['datad']['data2']["female"] ==
                                                "" ||
                                            values['datad']['data2']["male"] ==
                                                ""||values['datad']['data7']["other"]=="") {
                                          Fluttertoast.showToast(
                                              msg: "FEILDS MISSING",
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white);
                                        } else {
                                          var lol4 = values['datad']['data4']
                                          ["ebtimeon"];
                                          var lol41 = values['datad']['data4']
                                          ["ebtimeoff"];
var new99=values['datad']['data7']["other"];
                                        ["ebtimeoff"];
                                          var lol5 = values['datad']['data5']
                                          ["processed"];
                                          var lol1 =
                                          values['datad']['data']["jcbfrom"];
                                          var last2 =
                                          values['datad']['data']["jcbto"];
                                          var jcbfromhr1 = values['datad']['data']
                                          ["jcbfromhr"];
                                          var jcbfrommin1 = values['datad']
                                          ['data']["jcbfrommin"];
                                          var jcbtohr =
                                          values['datad']['data']["jcbtohr"];
                                          var jcbtomin =
                                          values['datad']['data']["jcbtomin"];

                                          var machinefromhr = values['datad']
                                          ['data3']["machinefromhr"];
                                          var machinefrommin = values['datad']
                                          ['data3']["machinefrommin"];
                                          var machinetohr = values['datad']
                                          ['data3']["machinetohr"];
                                          var machinetomin = values['datad']
                                          ['data3']["machinetomin"];

//                                          var ebfromhr = values['datad']['data4']
//                                          ["ebfromhr"];
//                                          var ebfrommin = values['datad']['data4']
//                                          ["ebfrommin"];
//                                          var ebtohr =
//                                          values['datad']['data4']["ebtohr"];
//                                          var ebtomin =
//                                          values['datad']['data4']["ebtomin"];
                                          var ebtime;

                                            ebtime = (((lol41) -
                                                (lol4))
                                            );


                                          var photo1 =
                                          values['datad']['data6']["image1"];
                                          var photo2 =
                                          values['datad']['data6']["image2"];
                                          var photo3 =
                                          values['datad']['data6']["image3"];

                                          var lol6 =
                                          values['datad']['data2']["male"];
                                          var last7 =
                                          values['datad']['data2']["female"];
                                          var lol455 = values['datad']['data3']
                                          ["machinefrom"];

                                          var last55 = values['datad']['data3']
                                          ["machineto"];

                                          var lol4599 = values['id'];

                                          var check = await FirebaseDatabase
                                              .instance
                                              .reference()
                                              .child('sites')
                                              .child(lol4599);
                                          print(lol4);
                                          print(lol4599);
                                          print(check);
                                          await check
                                              .once()
                                              .then((DataSnapshot snapshot) {
                                            Map<dynamic, dynamic> values1 =
                                                snapshot.value;
                                            var jcbcost = int.parse(
                                                values1['sitedata']['jcb1']);
                                            print(jcbcost);
                                            var mencost = int.parse(
                                                values1['sitedata']['malecost1']);
                                            var femencost = int.parse(
                                                values1['sitedata']
                                                ['femalecost1']);
                                            var mentotalcost =
                                                mencost * (int.parse(lol6));
                                            var fementotalcost =
                                                femencost * (int.parse(last7));
                                            var machinecost1 = int.parse(
                                                values1['sitedata']['machine1']);
                                            var machinecostcal =
                                                (((machinetohr * 60 +
                                                    machinetomin) -
                                                    (machinefromhr * 60 +
                                                        machinefrommin)) /
                                                    60) *
                                                    machinecost1;
                                            var jcbcostcal =
                                            ((((jcbtohr * 60 + jcbtomin) -
                                                (jcbfromhr1 * 60 +
                                                    jcbfrommin1)) /
                                                60) *
                                                jcbcost);

                                            if (new99==null||new99==""||ebtime == null ||
                                                ebtime == "" ||
                                                jcbcostcal == "" ||
                                                jcbcostcal == null ||
                                                machinecostcal == "" ||
                                                machinecostcal == null ||
                                                photo3 == "" ||
                                                photo3 == null ||
                                                photo2 == "" ||
                                                photo2 == null ||
                                                photo1 == "" ||
                                                photo1 == null ||
                                                lol41 == "" ||
                                                last55 == "" ||
                                                last55 == null ||
                                                lol4599 == "" ||
                                                lol4599 == null ||
                                                lol4 == "" ||
                                                lol4 == null ||
                                                lol5 == "" ||
                                                lol5 == null ||
                                                lol1 == "" ||
                                                lol1 == null ||
                                                last2 == "" ||
                                                last2 == null ||
                                                lol6 == "" ||
                                                lol6 == null ||
                                                last7 == "" ||
                                                last7 == null ||
                                                lol455 == "" ||
                                                lol455 == null) {
                                              Fluttertoast.showToast(
                                                  msg: "SOME FEILDS ARE EMPTY",
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white);
                                            } else {
                                              if (check == null) {
                                                Fluttertoast.showToast(
                                                    msg: "no sheet",
                                                    backgroundColor: Colors
                                                        .green,
                                                    textColor: Colors.white);
                                              } else {
                                                check
                                                    .child("DATABASE")
                                                    .child(formattedDate)
                                                    .set({
                                                  "ebtimeon": lol4,
                                                  "ebtimeoff": lol41,
                                                  "processed": lol5,
                                                  "jcbfrom": lol1,
                                                  "jcbto": last2,
                                                  "male": lol6,
                                                  "female": last7,
                                                  "machinefrom": lol455,
                                                  "machineto": last55,
                                                  "setstate": "1",
                                                  "lat": lat,
                                                  "long": long,
                                                  "image": photo1,
                                                  "image1": photo2,
                                                  "image2": photo3,
                                                  "jcbcost": jcbcostcal,
                                                  "machinecost": machinecostcal,
                                                  "ebtime": ebtime,
                                                  "mentotal": mentotalcost,
                                                  "femaletotal": fementotalcost,
                                                  "other":new99
                                                }).then(
                                                      (value) =>
                                                  {
                                                    check67 = FirebaseDatabase
                                                        .instance
                                                        .reference()
                                                        .child('users')
                                                        .child(uid.toString())
                                                        .child("datad"),
                                                    check67.child("data").set({
                                                      "jcbfrom": "",
                                                      "jcbfromhr": "",
                                                      "jcbfrommin": "",
                                                      "jcbto": "",
                                                      "jcbtohr": "",
                                                      "jcbtomin": "",
                                                      "set": '0',
                                                    }),
                                                    check67.child("data2").set({
                                                      "female": "",
                                                      "male": "",
                                                      "set": '0',
                                                    }),
                                                    check67.child("data3").set({
                                                      "machinefrom": "",
                                                      "machinefromhr": "",
                                                      "machinefrommin": "",
                                                      "machineto": "",
                                                      "machinetohr": "",
                                                      "machinetomin": "",
                                                      "set": '0',
                                                    }),
                                                    check67.child("data4").set({
                                                      "ebtimeoff": "",

                                                      "ebtimeon": "",
                                                    "set": '0',
                                                    }),
                                                    check67.child("data5").set({
                                                      "processed": "",
                                                      "set": '0',
                                                    }),
                                                    check67.child("data7").set({
                                                      "other": "",
                                                      "set": '0',
                                                    }),
                                                    check67.child("data6").set({
                                                      "image1": "",
                                                      "image2": "",
                                                      "image3": "", "set": '0',
                                                    }),
                                                    {setState(() {
                                                      filled=true;
                                                    }),

                                                      Fluttertoast.showToast(
                                                          msg:
                                                          "SUCCESSFULLY UPDATED",
                                                          backgroundColor:
                                                          Colors.green,
                                                          textColor: Colors
                                                              .white),
                                                    }
                                                  },
                                                );
                                              }
                                            }
                                          });
                                        }
                                      });
                                      ;
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                )),
                          ]),
                        ),
                      );
                    }
                    ;
                  });
            }
          }),
    ):Scaffold(
      body: Column(
        children: [SizedBox(height: 120,),Image(image: AssetImage('assets/pic34.png')),SizedBox(height: 60,),
          Center(
            child: Text(
              "SUCCESS!!!!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 40),
            ),
          ),Center(
            child: Container(margin: EdgeInsets.all(5),
              child: Text(
                "YOU HAVE ENTERED VALUES FOR $formattedDate",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),Center(
            child: Container(margin: EdgeInsets.all(5),
              child: Text(
                "PLEASE COME BACK TOMMOROW",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),RaisedButton(onPressed:(){Fluttertoast.showToast(
              msg:
              "APP EXITED",
              backgroundColor:
              Colors.white,
              textColor: Colors
                  .black); exit(0); },color: Colors.red,child: Text("EXIT",style: TextStyle(color: Colors.white),),)
        ],
      ),
    )
        : Container(
        color: Colors.white,
        child: Center(
          child: Text(
            "LOADING....",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue, fontSize: 20),
          ),
        ));
  }
}
