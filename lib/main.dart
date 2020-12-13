import 'package:civil/Photo.dart';
import 'package:civil/employee.dart';
import 'package:civil/expense.dart';
import 'package:civil/jcb.dart';
import 'package:civil/machine.dart';
import 'package:civil/other.dart';
import 'package:civil/processed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:civil/MainScreen.dart';

import 'package:civil/LogIn.dart';




void main() => runApp(MaterialApp(
  home: LogIn(),
  routes: <String, WidgetBuilder>{
    "page2": (BuildContext context) => LogIn(),
    "page3": (BuildContext context) => jcb(),
    "page4": (BuildContext context) => employee(),
    "page6": (BuildContext context) => machine(),
    "page7": (BuildContext context) => expense(),
    "page8": (BuildContext context) => processed(),
    "page11": (BuildContext context) => Photo(),
    "page112": (BuildContext context) => other(),

    "page5": (BuildContext context) => MainScreen(),
  },
  debugShowCheckedModeBanner: false,
));
