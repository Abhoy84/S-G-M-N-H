import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:hospital/model/patient_model.dart';
import 'package:hospital/pages/loading.dart';
import 'package:hospital/pages/patient_account.dart';
import 'package:hospital/pages/patient_password_change_otp_send.dart';
import 'package:hospital/utils/urlpage.dart';
import 'package:http/http.dart' as http;

class patient_password_change extends StatefulWidget {
  const patient_password_change({super.key});

  @override
  State<patient_password_change> createState() =>
      _patient_password_changeState();
}

class _patient_password_changeState extends State<patient_password_change> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController oldpasscontroller = TextEditingController();
  TextEditingController newpasscontroller = TextEditingController();
  bool oldpasswordvisibility = false;
  bool newpasswordvisibility = false;
  bool confirmpasswordvisibility = false;
  String newpassword = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Change Password",
            style: TextStyle(color: C.white),
          ),
          backgroundColor: C.theme,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => patient_account()));
              },
              icon: Icon(Icons.arrow_back),
              iconSize: 30,
              color: C.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Form(
          key: formkey,
          child: Column(
            children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("asset/image/change-password2.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                child: Container(
                  height: 60,
                  child: TextFormField(
                    obscureText: oldpasswordvisibility,
                    keyboardType: TextInputType.number,
                    obscuringCharacter: "*",
                    controller: oldpasscontroller,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.key),
                      prefixIconColor: C.theme,
                      hintText: "Enter current Password",
                      suffixIcon: TextButton(
                          onPressed: () {
                            oldpasswordvisibility = !oldpasswordvisibility;
                            setState(() {});
                          },
                          child: oldpasswordvisibility
                              ? Icon(
                                  Icons.visibility_off,
                                  color: C.theme,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: C.theme,
                                )),
                      hintStyle: TextStyle(
                        color: C.theme,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      labelText: "Enter current Password",
                      labelStyle: TextStyle(
                        color: C.theme,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: C.theme,
                            width: 2,
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                child: Container(
                  height: 60,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Can't left blank!";
                      } else if (value.length < 4) {
                        return "Contains atleast 8 characters!";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => newpassword = value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    obscureText: newpasswordvisibility,
                    obscuringCharacter: "*",
                    controller: newpasscontroller,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      prefixIconColor: C.theme,
                      hintText: "Creat new Password",
                      suffixIcon: TextButton(
                          onPressed: () {
                            newpasswordvisibility = !newpasswordvisibility;
                            setState(() {});
                          },
                          child: newpasswordvisibility
                              ? Icon(
                                  Icons.visibility_off,
                                  color: C.theme,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: C.theme,
                                )),
                      hintStyle: TextStyle(
                        color: C.theme,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      labelText: "Creat new Password",
                      labelStyle: TextStyle(
                        color: C.theme,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: C.theme,
                            width: 2,
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
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: Container(
                  height: 60,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Can't left blank!";
                      } else if (newpassword != value) {
                        return "password does not match";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: confirmpasswordvisibility,
                    keyboardType: TextInputType.number,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.check_box),
                      filled: true,
                      prefixIconColor: C.theme,
                      hintText: "Confirm  Password",
                      suffixIcon: TextButton(
                          onPressed: () {
                            confirmpasswordvisibility =
                                !confirmpasswordvisibility;
                            setState(() {});
                          },
                          child: confirmpasswordvisibility
                              ? Icon(
                                  Icons.visibility_off,
                                  color: C.theme,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: C.theme,
                                )),
                      hintStyle: TextStyle(
                        color: C.theme,
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: "Confirm new Password",
                      labelStyle: TextStyle(
                        color: C.theme,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: C.theme,
                            width: 2,
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
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => password_change_otp()));
                      },
                      child: Text(
                        "Try another way",
                        style: TextStyle(
                            color: C.theme,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 230,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: C.theme,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Text(
                    "UPDATE",
                    style: TextStyle(
                        fontSize: 25, fontFamily: 'mogra', color: C.white),
                  ),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      if (PATIENT.password == oldpasscontroller.text) {
                        changepassword(newpasscontroller.text, PATIENT.phone);
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.topSlide,
                          btnOkColor: Colors.red,
                          headerAnimationLoop: false,
                          showCloseIcon: true,
                          title: 'Incorrect old password!!',
                          desc:
                              "your previous password is incorrect.check again!",
                          btnOkOnPress: () {},
                        ).show();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Future changepassword(String pass, String phone) async {
    Map data = {"password": pass, "phone": phone};
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return loading();
      },
    );

    try {
      var response = await http.post(
          Uri.parse(MyUrl.fullurl + "patient_change_password.php"),
          body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == true) {
        PATIENT.password = newpasscontroller.text;
        Navigator.pop(context);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.topSlide,
          headerAnimationLoop: false,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          showCloseIcon: false,
          title: "Update successfull",
          desc: "It may be take few seconds to refresh!.",
          btnOkOnPress: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => patient_account()));
          },
        ).show();
      } else {
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
