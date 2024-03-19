import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:hospital/model/colormodel.dart';

import 'package:hospital/pages/user_selection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => splashscreenState();
}

class splashscreenState extends State<splashscreen> {
  static const PATIENTLOGIN = "patientlogin";
  static const EMPLOYEELOGIN = "employeelogin";
  late SharedPreferences sp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nextpage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 100,
            color: C.splash,
            child: Container(
              padding: EdgeInsets.only(left: 150, right: 150, top: 50),
              child: Image.asset(
                "asset/image/sg.png",
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                  child: Text(
                "Version: 1.0.0",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: C.white),
              )),
            ),
            color: C.splash,
          ),
        ],
      ),
    );
  }

  void nextpage() async {
    sp = await SharedPreferences.getInstance();
    // var ispatientlogin = sp.getBool(PATIENTLOGIN);
    // var isemployeelogin = sp.getBool(EMPLOYEELOGIN);

    Timer(
      Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => userselection()));
        // if (ispatientlogin!) {
        //   Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(builder: (context) => userselection()));
        // } else if (isemployeelogin!) {
        //   Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(builder: (context) => userselection()));
        // } else {
        //   Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(builder: (context) => userselection()));
        // }
      },
    );
  }
}
