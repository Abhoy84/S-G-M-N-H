import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hospital/pages/Admin_home.dart';
import 'package:hospital/pages/Loadingdialoge.dart';
import 'package:hospital/pages/employeelogin.dart';
import 'package:hospital/pages/patient_login.dart';

class userselection extends StatefulWidget {
  const userselection({super.key});

  @override
  State<userselection> createState() => _userselectionState();
}

class _userselectionState extends State<userselection> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => admin_homepage()));
              },
              icon: Icon(Icons.admin_panel_settings),
              color: C.white,
              iconSize: 40,
            )
          ],
          backgroundColor: C.theme,
          title: Text(
            "Welcome",
            style: TextStyle(color: C.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: C.white,
            ),
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: C.white,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/image/log-4.jpg"),
                      fit: BoxFit.fill),
                ),
                child: Container(
                  color: Color.fromARGB(0, 29, 27, 27),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        radius: 147,
                        backgroundColor: C.theme,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            "asset/image/doctor3.png",
                          ),
                          backgroundColor: Color.fromARGB(0, 0, 0, 0),
                          radius: 140,
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Stack(children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: C.theme,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 9,
                                  spreadRadius: 4,
                                  color: Color.fromARGB(255, 113, 121, 163),
                                )
                              ]),
                          child: Row(children: [
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                  border: Border.all(color: C.white, width: 3),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Image.asset(
                                "asset/image/patient.png",
                                color: C.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20, top: 25),
                              width: 190,
                              height: 90,
                              decoration: BoxDecoration(),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText("PATIENT",
                                      textStyle: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              370,
                                          fontFamily: "Mogra",
                                          fontWeight: FontWeight.bold),
                                      colors: [
                                        Color.fromARGB(255, 255, 255, 255),
                                        Color.fromARGB(255, 255, 225, 0),
                                        Colors.white,
                                      ],
                                      speed: Duration(seconds: 2))
                                ],
                                repeatForever: true,
                                pause: Duration(microseconds: 100),
                              ),
                            )
                          ]),
                        ),
                        InkWell(
                          onTap: () {
                            showLoadingDialog(context).whenComplete(() {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => patientlogin()));
                            });
                          },
                          child: Container(
                            height: 100,
                            width: 300,
                            color: Colors.transparent,
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 70,
                      ),
                      Stack(children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: C.theme,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 9,
                                  spreadRadius: 4,
                                  color: Color.fromARGB(255, 113, 121, 163),
                                )
                              ]),
                          child: Row(children: [
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              padding: EdgeInsets.all(8),
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                  border: Border.all(color: C.white, width: 3),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Image.asset(
                                "asset/image/doctor.png",
                                color: C.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, top: 25),
                              width: 190,
                              height: 90,
                              decoration: BoxDecoration(),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText("EMPLOYEE",
                                      textStyle: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              370,
                                          fontFamily: "Mogra",
                                          fontWeight: FontWeight.bold),
                                      colors: [
                                        Color.fromARGB(255, 255, 255, 255),
                                        Color.fromARGB(255, 255, 225, 0),
                                        Colors.white,
                                      ],
                                      speed: Duration(seconds: 2))
                                ],
                                repeatForever: true,
                                pause: Duration(microseconds: 100),
                              ),
                            )
                          ]),
                        ),
                        InkWell(
                          onTap: () {
                            showLoadingDialog(context).whenComplete(() {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => employeelogin()));
                            });
                          },
                          child: Container(
                            height: 100,
                            width: 300,
                            color: Colors.transparent,
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 150,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
