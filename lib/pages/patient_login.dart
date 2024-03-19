import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:hospital/model/patient_model.dart';
// import 'package:hospital/model/patient_model.dart';
import 'package:hospital/pages/loading.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:hospital/pages/loadingsandbox.dart';

import 'package:hospital/pages/patient_forget_password_otp_send.dart';

import 'package:hospital/pages/splashscreen.dart';
import 'package:hospital/pages/patient_home.dart';
import 'package:hospital/pages/user_selection.dart';

import 'package:hospital/pages/patient_signup.dart';
import 'package:hospital/utils/urlpage.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class patientlogin extends StatefulWidget {
  const patientlogin({super.key});

  @override
  State<patientlogin> createState() => patientloginState();
}

class patientloginState extends State<patientlogin> {
  @override
  void initState() {
    forgetpass = false;
    // TODO: implement initState
    super.initState();
  }

  late SharedPreferences sp;
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  bool passwordvisiblity = true;
  static bool forgetpass = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => userselection()));
              },
              icon: Icon(Icons.arrow_back),
              iconSize: 30,
              color: C.white,
            ),
          ),
          backgroundColor: C.theme,
          title: Text(
            "Patient login",
            style:
                TextStyle(fontFamily: "lobster", fontSize: 30, color: C.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Container(
                    height: 260,
                    child: LottieBuilder.asset("asset/lotti/doctor.json"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 70,
                    decoration: BoxDecoration(
                        color: C.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Color.fromARGB(255, 13, 28, 149))
                        ]),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width - 80,
                      decoration: BoxDecoration(
                        color: C.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: C.theme,
                          width: 5,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontFamily: "mogra",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: C.theme),
                            ),
                          ),
                          Container(
                            height: 80,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              // controller: phonecontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Can't left blank";
                                } else if (value.length != 10) {
                                  return "enter 10 deigits";
                                } else if (!RegExp(r'^[6-9]\d{0,9}$')
                                    .hasMatch(value)) {
                                  return "enter valid mobile number";
                                } else {
                                  return null;
                                }
                              },
                              controller: phonecontroller,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.smartphone_sharp),
                                prefixIconColor: C.theme,
                                hintText: "Enter Phone Number",
                                hintStyle: TextStyle(
                                  color: C.theme,
                                  fontWeight: FontWeight.bold,
                                ),
                                labelText: "PHONE NO.",
                                labelStyle: TextStyle(
                                  color: C.theme,
                                  fontWeight: FontWeight.bold,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: C.theme,
                                      width: 7,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: C.theme,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 90,
                            height: 80,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: passcontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Can't left blank!";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              obscureText: passwordvisiblity,
                              obscuringCharacter: "*",
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_rounded),
                                prefixIconColor: C.theme,
                                suffixIconColor: C.theme,
                                suffixIcon: TextButton(
                                    onPressed: () {
                                      passwordvisiblity = !passwordvisiblity;
                                      setState(() {});
                                    },
                                    child: passwordvisiblity
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: C.theme,
                                          )
                                        : Icon(
                                            Icons.visibility,
                                            color: C.theme,
                                          )),
                                hintText: "Enter  Password",
                                hintStyle: TextStyle(
                                  color: C.theme,
                                  fontWeight: FontWeight.bold,
                                ),
                                labelText: " PASSWORD",
                                labelStyle: TextStyle(
                                  color: C.theme,
                                  fontWeight: FontWeight.bold,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: C.theme,
                                    width: 7,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: C.theme,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          patient_forget_password_otp_send()));
                            },
                            child: Container(
                              // color: C.black,
                              margin:
                                  EdgeInsets.only(right: 170, left: 8, top: 5),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: C.theme,
                                      decorationColor: C.theme,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 169, 170, 177),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  offset: Offset(0, 5))
                            ]),
                            width: MediaQuery.of(context).size.width - 170,
                            height: 50,
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: C.theme,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7))),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontFamily: "sriracha",
                                    fontSize: 20,
                                    color: C.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  patientLogin(phonecontroller.text,
                                      passcontroller.text);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      sandboxLoadingDialog(context).whenComplete(() {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => patientsignup()));
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: Text(
                        "Creat Account",
                        style: TextStyle(
                            fontFamily: "SRIRACHA",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: C.theme,
                            decoration: TextDecoration.underline,
                            decorationColor: C.theme),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future patientLogin(String phone, String pass) async {
    Map data = {'phone': phone, 'password': pass};
    showDialog(
        context: context,
        builder: (context) {
          return loading();
        });
    var response = await http
        .post(Uri.parse(MyUrl.fullurl + "patient_login.php"), body: data);
    var jsondata = jsonDecode(response.body);
    try {
      if (jsondata['status'] == true) {
        sp = await SharedPreferences.getInstance();
        sp.setBool(splashscreenState.PATIENTLOGIN, true);
        PATIENT.name = jsondata['name'];
        PATIENT.id = jsondata['id'];
        PATIENT.phone = jsondata['phone'];
        PATIENT.email = jsondata['email'];
        PATIENT.dob = jsondata['dob'];
        PATIENT.gender = jsondata['gender'];
        PATIENT.password = jsondata['password'];
        PATIENT.image = jsondata['image'];

        Navigator.pop(context);
        Fluttertoast.showToast(msg: jsondata['msg']);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => patienthome()));
      } else {
        // sp.setBool(splashscreenState.PATIENTLOGIN, false);
        Navigator.pop(context);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.topSlide,
          btnOkColor: Colors.red,
          headerAnimationLoop: false,
          showCloseIcon: true,
          title: jsondata['msg'],
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      // sp.setBool(splashscreenState.PATIENTLOGIN, true);
      Navigator.pop(context);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        btnOkColor: Colors.red,
        headerAnimationLoop: false,
        showCloseIcon: true,
        title: e.toString(),
        btnOkOnPress: () {},
      ).show();
    }
  }
}
