import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore

import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
var upload123=false;var upload1231=false;var upload1232=false;
final usernamecontroller12341 = new TextEditingController();
final passwordcontroller241 = new TextEditingController();File _image;File _image1;File _image2;
String _uploadedFileURL;String _uploadedFileURL1;String _uploadedFileURL2;
var userget = false;
var emailId = "";
var loggedInperson;
var me = "";
var last="";
var lol ="";
var val1 = 0;
var uidglobal;
var _firebaseRef67;
void getcurrentperson() async {
  try {
    final authenticate = FirebaseAuth.instance;

    final user = await authenticate.currentUser();
    final uid = user.uid;
    print(uid);
    FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(uid.toString())
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
//      lol = values['datad']['data5']["processed"];

      me=values['name'];

      usernamecontroller12341.text=lol.toString();
      passwordcontroller241.text=last.toString();






    }
    );
    ;

  } catch (e) {
    print(e);
  }
}
final authenticate12 = FirebaseAuth.instance;

class Photo extends StatefulWidget {
  const Photo({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {


  Future uploadFile() async {setState(() {
    upload123=true;
  });
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;upload123=false;
      });
    });

  }
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((image) {
      setState(() {
      _image = image;
      });uploadFile();
    });
  }
  Future uploadFile1() async {setState(() {
    upload1231=true;
  });
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(_image1.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image1);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL1 = fileURL; upload1231=false;
      });
    });
  }Future uploadFile2() async {setState(() {
    upload1232=true;
  });
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(_image2.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image2);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL2 = fileURL;    upload1232=false;
      });
    });
  }
  Future chooseFile1() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((image) {
      setState(() {
        _image1 = image;
      });uploadFile1();
    });
  }Future chooseFile2() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((image) {
      setState(() {
        _image2 = image;
      });uploadFile2();
    });
  }
 Function clear(){
    setState((){_image=null;_uploadedFileURL=null;});
 }
  Function clear1(){
    setState((){_image1=null;_uploadedFileURL1=null;});
  }Function clear2(){
    setState((){_image2=null;_uploadedFileURL2=null;});
  }

  Future<void> _launched;

  void getcurrentperson1() async {
    try {
      final authenticate = FirebaseAuth.instance;

      final user = await authenticate.currentUser();
      final uid = user.uid;
      uidglobal = uid;
      _firebaseRef67 =
      await FirebaseDatabase().reference().child("users").child(uidglobal);

      FirebaseDatabase.instance
          .reference()
          .child('users')
          .child(uid.toString())
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        if (values['name'] == null) {
          me = "..";
        } else {
          me = values["name"].toString().toUpperCase();
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
    getcurrentperson1();
    getcurrentperson();
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
        ?
    Scaffold(
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
                      style:
                      TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ));
            }

            if (snap.data.snapshot.value == null) {
              return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/qwe3.jpeg",
                          width: 80,
                          height: 80,
                        ),
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 40, bottom: 10),
                      ),
                      Center(child: Text("NO EVENTS")),
                    ],
                  ));
            } else {
              DataSnapshot snapshot9 = snap.data.snapshot;
              final value = snapshot9.value;
              final id = value['id'];
              final place = value['place'];
              final time = DateTime.now();
              String formattedDate =
              DateFormat('dd-MM-yyyy').format(time);
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
                          "SITE: ($id)($place)",
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
                    Container(alignment: Alignment.topLeft,padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text("UPLOAD IMAGES",style:TextStyle(color: Colors.black54,fontSize: 20)),
                          SingleChildScrollView(scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10, left: 10, right:10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ), child: Column(children: [ _image != null
                                    ? Image.asset(
                                  _image.path,
                                  height: .2,
                                )
                                    : Container(),
                                  _image == null
                                      ? RaisedButton(
                                    child: Text('Choose File'),
                                    onPressed: chooseFile,
                                    color: Colors.cyan,
                                  )
                                      : Container(),



                                  (upload123==true)?Container(
                                      margin: EdgeInsets.all(8),
                                      child: CircularProgressIndicator()):Text(''),
                                  _uploadedFileURL != null
                                      ? Column(
                                        children: [
                                          Image.network(
                                    _uploadedFileURL,
                                    height: 150,
                                  ),Text('Uploaded Image'),
                                        ],
                                      )
                                      : Container(),_image != null
                                      ? RaisedButton(
                                    child: Text('Clear Selection'),
                                    onPressed: (){clear();},
                                  )
                                      : Container(),],)),
                                Container(
                                    margin: EdgeInsets.only(top: 10, left: 10, right:10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ), child: Column(children: [ _image1 != null
                                    ? Image.asset(
                                  _image1.path,
                                  height: .2,
                                )
                                    : Container(),
                                  _image1 == null
                                      ? RaisedButton(
                                    child: Text('Choose File'),
                                    onPressed: chooseFile1,
                                    color: Colors.cyan,
                                  )
                                      : Container(),
//                                  (_uploadedFileURL1==null&&_image1!=null)
//                                      ? RaisedButton(
//                                    child: Text('Upload File'),
//                                    onPressed: uploadFile1,
//                                    color: Colors.cyan,
//                                  )
//                                      : Container(),

                                  (upload1231==true)?Container(
                                      margin: EdgeInsets.all(8),
                                      child: CircularProgressIndicator()):Text(''),
                                  _uploadedFileURL1 != null
                                      ? Column(
                                        children: [
                                          Image.network(
                                    _uploadedFileURL1,
                                    height: 150,
                                  ),Text('Uploaded Image'),
                                        ],
                                      )
                                      : Container(),  _image1 != null
                                      ? RaisedButton(
                                    child: Text('Clear Selection'),
                                    onPressed: (){clear1();},
                                  )
                                      : Container(),],)),
                                Container(
                                    margin: EdgeInsets.only(top: 10, left: 10, right:10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ), child: Column(children: [ _image2 != null
                                    ? Image.asset(
                                  _image2.path,
                                  height: .2,
                                )
                                    : Container(),
                                  _image2 == null
                                      ? RaisedButton(
                                    child: Text('Choose File'),
                                    onPressed: chooseFile2,
                                    color: Colors.cyan,
                                  )
                                      : Container(),
//                                  (_uploadedFileURL2==null&&_image2!=null)
//
//                                      ? RaisedButton(
//                                    child: Text('Upload File'),
//                                    onPressed: uploadFile2,
//                                    color: Colors.cyan,
//                                  )
//                                      : Container(),

                                  (upload1232==true)?Container(
                                      margin: EdgeInsets.all(8),
                                      child: CircularProgressIndicator()):Text(''),
                                  _uploadedFileURL2 != null
                                      ? Column(
                                        children: [
                                          Image.network(
                                    _uploadedFileURL2,
                                    height: 150,
                                  ),Text('Uploaded Image'),
                                        ],
                                      )
                                      : Container(), _image2 != null
                                      ? RaisedButton(
                                    child: Text('Clear Selection'),
                                    onPressed: (){clear2();},
                                  )
                                      : Container(),],)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    Container(decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Hexcolor('#FF9900')),
                        margin: EdgeInsets.only(top: 17,bottom: 30),
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 16,
                        child: RaisedButton(
                          elevation: 10,
                          color: Colors.orange,
                          child: Text("SUBMIT",
                              style: TextStyle(fontSize: 17)),
                          onPressed: ()async{if(_uploadedFileURL==""||_uploadedFileURL2==""||_uploadedFileURL1==""||_uploadedFileURL==null||_uploadedFileURL1==null||_uploadedFileURL2==null){Fluttertoast.showToast(
                              msg:"FEILDS LEFT", backgroundColor: Colors.red, textColor: Colors.white);}
   else{ final authenticate = FirebaseAuth.instance;
    final user = await authenticate.currentUser();
    final uid = user.uid;
    FirebaseDatabase.instance.reference().child(
    'users').child(uid.toString()).child("datad").child("data6")
        .set({
    'image1': _uploadedFileURL.toString(),
    'image2': _uploadedFileURL1.toString(),
    'image3': _uploadedFileURL2.toString(),
      'set':'1',


    }).then((value) => { {Fluttertoast.showToast(
    msg:"SUCCESSFULLY UPDATED", backgroundColor: Colors.green, textColor: Colors.white)},
    Navigator.pop(context),
    },);
    } },




                        )),


                  ]),
                ),
              );
            }
          }),
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
