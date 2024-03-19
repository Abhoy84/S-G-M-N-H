import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:hospital/pages/loading.dart';
import 'package:hospital/pages/patient_change_phone_otp_send.dart';
import 'package:hospital/pages/patient_password_change_by_oldpass.dart';
import 'package:hospital/pages/patient_home.dart';
// import 'package:hospital/pages/patientlogin.dart';
import 'package:hospital/utils/urlpage.dart';
import 'package:hospital/model/patient_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class patient_account extends StatefulWidget {
  const patient_account({super.key});

  @override
  State<patient_account> createState() => _patient_accountState();
}

class _patient_accountState extends State<patient_account> {
  late SharedPreferences sp;
  File? patientimage;
  bool passwordtype = false;
  bool patientnametype = false;
  bool patientphonetype = false;
  bool patientemailtype = false;
  bool patientgendertype = false;
  bool patientdobtype = false;
  bool patientpasstype = false;
  String setage = '';
  DateTime? agedate;
  String age = '';

  TextEditingController patient_name = TextEditingController();
  TextEditingController patient_phone = TextEditingController();
  TextEditingController patient_email = TextEditingController();
  TextEditingController patient_gender = TextEditingController();
  TextEditingController patient_password = TextEditingController();
  TextEditingController patient_dob = TextEditingController();

  DateTime currentdate = DateTime.now();
  String? setdate;
  String selectgender = PATIENT.gender;
  static String showdate = "";
  @override
  void initState() {
    // TODO: implement initState
    patient_name.text = PATIENT.name;
    patient_phone.text = PATIENT.phone;
    patient_email.text = PATIENT.email;
    patient_gender.text = PATIENT.gender;
    patient_dob.text = chanegedateformate(convertStringToDateTime(PATIENT.dob));
    patient_password.text = "********";
    Fluttertoast.showToast(msg: PATIENT.dob.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => patienthome()));
              },
              icon: Icon(Icons.arrow_back),
              iconSize: 30,
              color: C.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Patient dtails",
            style: TextStyle(
                color: C.white,
                fontFamily: 'lobster',
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: C.theme,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 100, left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 3.0,
                          blurRadius: 7.0,
                          offset: Offset(0, 0),
                        ),
                      ],
                      color: C.theme,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 70,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 17),
                          width: MediaQuery.of(context).size.width,
                          child: const Text(
                            "Patient name",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 104,
                              padding: const EdgeInsets.only(bottom: 15),
                              child: TextFormField(
                                enabled: patientnametype,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                controller: patient_name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Cannot left Blank!';
                                  } else {
                                    return null;
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  fillColor: Color.fromARGB(0, 255, 255, 255),
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  patientnametype = !patientnametype;
                                });
                              },
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 17),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Mobile Number",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 104,
                              padding: const EdgeInsets.only(bottom: 15),
                              child: TextFormField(
                                enabled: patientphonetype,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                controller: patient_phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Cannot left Blank!';
                                  } else {
                                    return null;
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  fillColor: Color.fromARGB(0, 255, 255, 255),
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.smartphone,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                patientphonetype
                                    ? patientphonetype = false
                                    : showDialog(
                                        context: context,
                                        barrierDismissible:
                                            true, // Prevents dismissing the dialog by tapping outside
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Color.fromARGB(
                                                0, 255, 255, 255),
                                            shadowColor: Colors.transparent,
                                            // surfaceTintColor: Colors.transparent,
                                            content: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,

                                                // Customize the loading message
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,

                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: 10,
                                                      left: 10,
                                                    ),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Warning!",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: C.red,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "If you change your phone number you need relogin.",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: C.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: TextButton(
                                                          onPressed: (() {
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                          child: Text(
                                                            "cancle",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: C.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 90,
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: TextButton(
                                                          onPressed: (() {
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacement(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                patient_change_phone_otp_send()));
                                                          }),
                                                          child: Text(
                                                            "OK",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: C.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 17),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "E-mail id",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 104,
                              padding: const EdgeInsets.only(bottom: 15),
                              child: TextFormField(
                                enabled: patientemailtype,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                controller: patient_email,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Cannot left Blank!';
                                  } else {
                                    return null;
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  fillColor: Color.fromARGB(0, 255, 255, 255),
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  patientemailtype = !patientemailtype;
                                });
                              },
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 17),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "DATE-OF-BIRTH",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 104,
                              child: Text(
                                // ignore: unnecessary_null_comparison
                                showdate != null ? showdate : PATIENT.dob,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: C.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                DateTime? pickdate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1970),
                                  lastDate: DateTime.now(),
                                );
                                if (pickdate != null) {
                                  showdate =
                                      "  ${DateFormat('yMMMd').format(pickdate)}";
                                  setdate =
                                      "${DateFormat('yMd').format(pickdate)}";
                                  age = calculateAge(pickdate);
                                } else {
                                  showdate =
                                      "  ${DateFormat('yMMMEd').format(convertStringToDateTime(PATIENT.dob))}";
                                  setdate =
                                      "${DateFormat('yMd').format(convertStringToDateTime(PATIENT.dob))}";
                                  age = calculateAge(
                                      convertStringToDateTime(PATIENT.dob));
                                }
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 17),
                              width: MediaQuery.of(context).size.width / 4.1,
                              child: Text(
                                "Age",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 30),
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                "Gender",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                                width: 75,
                                margin: EdgeInsets.only(bottom: 20),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  age == ''
                                      ? calculateAgeFromString(PATIENT.dob)
                                      : age,
                                  style: TextStyle(
                                      color: C.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )),
                            SizedBox(
                              width: 49,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 251,
                              padding: const EdgeInsets.only(bottom: 15),
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                controller: patient_gender,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Cannot left Blank!';
                                  } else {
                                    return null;
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  fillColor: Color.fromARGB(0, 255, 255, 255),
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible:
                                      true, // Prevents dismissing the dialog by tapping outside
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          Color.fromARGB(0, 255, 255, 255),
                                      shadowColor: Colors.transparent,
                                      // surfaceTintColor: Colors.transparent,
                                      content: Container(
                                        margin: EdgeInsets.only(left: 50),
                                        padding:
                                            EdgeInsets.only(left: 0, top: 10),
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          // Customize the loading message
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,

                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                patient_gender.text = 'Male';
                                                setState(() {});
                                              },
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "Male",
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: C.theme),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Container(
                                              height: 2,
                                              width: 200,
                                              color: C.theme,
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                patient_gender.text = 'Female';
                                                setState(() {});
                                              },
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "Female",
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: C.theme),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Container(
                                              height: 2,
                                              width: 200,
                                              color: C.theme,
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                patient_gender.text = 'Other';
                                                setState(() {});
                                              },
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "Other",
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: C.theme),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 17),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Password",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 104,
                              padding: const EdgeInsets.only(bottom: 15),
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                controller: patient_password,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  fillColor: Color.fromARGB(0, 255, 255, 255),
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            patient_password_change()));
                              },
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 130,
                    child: InkWell(
                      onTap: () {
                        profileImageEditButton(context);
                      },
                      child: Container(
                        width: 140.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: C.theme, width: 5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5.0,
                              blurRadius: 10.0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(
                              MyUrl.fullurl + MyUrl.imageurl + PATIENT.image),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 170,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: C.theme,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Text(
                    "UPDATE",
                    style: TextStyle(
                        fontSize: 30, fontFamily: 'mogra', color: C.white),
                  ),
                  onPressed: () {
                    patientDtailsUpdate(
                            patient_name.text,
                            patient_phone.text,
                            patient_email.text,
                            setdate!,
                            patient_gender.text,
                            PATIENT.id)
                        .whenComplete(() {
                      setState(() {});
                    });
                  },
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future pickImage(ImageSource imageType) async {
    try {
      final photo =
          await ImagePicker().pickImage(source: imageType, imageQuality: 50);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        patientimage = tempImage;
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future patientImageChange(File Uphoto, String userid) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return loading();
      },
    );

    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse(MyUrl.fullurl + "patient_image.php"));

      request.files.add(await http.MultipartFile.fromBytes(
          'image', Uphoto.readAsBytesSync(),
          filename: Uphoto.path.split("/").last));
      request.fields['pid'] = userid;

      var response = await request.send();

      var responded = await http.Response.fromStream(response);
      var jsondata = jsonDecode(responded.body);
      if (jsondata['status'] == 'true') {
        sp = await SharedPreferences.getInstance();

        PATIENT.image = jsondata['imgtitle'];
        sp.setString("image", PATIENT.image);

        setState(() {});

        Navigator.pop(context);
        Navigator.pop(context);

        Fluttertoast.showToast(
          gravity: ToastGravity.CENTER,
          msg: jsondata['msg'],
        );
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(
          gravity: ToastGravity.CENTER,
          msg: jsondata['msg'],
        );
      }
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        gravity: ToastGravity.CENTER,
        msg: e.toString(),
      );
    }
  }

  void profileImageEditButton(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: C.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  height: 7,
                  width: 70,
                  decoration: BoxDecoration(
                      color: C.brownShade,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    showFullImageDialog();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.photo_library_rounded,
                        size: 40,
                        color: C.theme,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "See profile picture",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: C.theme),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 2.0,
                                        blurRadius: 3.0,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                    color: C.theme,
                                    borderRadius: BorderRadius.circular(15)),
                                alignment: Alignment.centerLeft,
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    pickImage(ImageSource.camera)
                                        .whenComplete(() {
                                      if (patientimage != null) {
                                        patientImageChange(
                                            patientimage!, PATIENT.id);
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.camera,
                                    size: 40,
                                    color: C.white,
                                  ),
                                  label: Text(
                                    "choose from Camera",
                                    style:
                                        TextStyle(color: C.white, fontSize: 20),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 2.0,
                                        blurRadius: 3.0,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                    color: C.theme,
                                    borderRadius: BorderRadius.circular(15)),
                                alignment: Alignment.centerLeft,
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    pickImage(ImageSource.gallery)
                                        .whenComplete(() {
                                      if (patientimage != null) {
                                        patientImageChange(
                                            patientimage!, PATIENT.id);
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent),
                                  icon: Icon(
                                    Icons.photo_library_outlined,
                                    size: 40,
                                    color: C.white,
                                  ),
                                  label: Text(
                                    "choose from Gallery",
                                    style:
                                        TextStyle(color: C.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 18,
                      ),
                      CircleAvatar(
                        backgroundColor: C.theme,
                        child: Icon(
                          Icons.edit,
                          color: C.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Change profile picture",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: C.theme),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  void showFullImageDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            // Handle tap, for example, by popping the screen
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: C.brownShade,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5.0,
                  blurRadius: 10.0,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Image(
              image:
                  NetworkImage(MyUrl.fullurl + MyUrl.imageurl + PATIENT.image),
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
        );
      },
    );
  }

  String calculateAgeFromString(String birthdayString) {
    List<String> dateParts = birthdayString.split('/');
    if (dateParts.length != 3) {
      return 'Invalid Date';
    }

    int birthYear = int.parse(dateParts[2]);
    int birthMonth = int.parse(dateParts[0]);
    int birthDay = int.parse(dateParts[1]);

    DateTime birthdate = DateTime(birthYear, birthMonth, birthDay);
    DateTime currentDate = DateTime.now();

    int ageInYears = currentDate.year - birthdate.year;
    int ageInMonths = currentDate.month - birthdate.month;
    int ageInDays = currentDate.day - birthdate.day;

    if (currentDate
        .isBefore(DateTime(currentDate.year, birthdate.month, birthdate.day))) {
      ageInYears--;
      ageInMonths = 12 - birthdate.month + currentDate.month;
      ageInDays = currentDate
          .difference(
              DateTime(currentDate.year, birthdate.month, birthdate.day))
          .inDays;
    }

    if (ageInDays == 1) {
      return '1 day';
    } else if (ageInDays > 1) {
      return '$ageInDays days';
    } else if (ageInYears > 0 && ageInMonths > 0) {
      return '$ageInYears years';
    } else if (ageInYears > 0) {
      return '$ageInYears years';
    } else if (ageInMonths > 0) {
      return '$ageInMonths months';
    } else {
      return 'Invalid Date';
    }
  }

  String calculateAge(DateTime birthday) {
    // ignore: unused_local_variable
    String finalage = '';
    DateTime birthdate = birthday;
    DateTime currentDate = DateTime.now();

    int ageInYears = currentDate.year - birthdate.year;
    int ageInMonths = currentDate.month - birthdate.month;
    int ageInDays = currentDate.day - birthdate.day;

    if (currentDate.month < birthdate.month ||
        (currentDate.month == birthdate.month &&
            currentDate.day < birthdate.day)) {
      ageInYears--;
      ageInMonths = 12 - birthdate.month + currentDate.month;
      ageInDays = currentDate.day + (30 - birthdate.day);
    }
    if (ageInDays < 1) {
      return finalage = "1day";
    } else if (ageInYears < 1 && ageInMonths < 1) {
      return finalage = '$ageInDays days';
    } else if (ageInYears < 1) {
      return finalage = '$ageInMonths months';
    } else {
      return finalage = '$ageInYears years';
    }
  }

  DateTime convertStringToDateTime(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      Fluttertoast.showToast(msg: dateTime.toString());
      return dateTime;
    } catch (e) {
      print('Error parsing date string: $e');

      return DateTime.now(); // Return null in case of an error
    }
  }

  String chanegedateformate(DateTime s) {
    String viewdate = '';

    viewdate = "${DateFormat('yMMMd').format(s)}";

    return viewdate;
  }

  Future patientDtailsUpdate(String name, String phone, String email,
      String dob, String gender, String pid) async {
    Map data = {
      "name": name,
      "phone": phone,
      "email": email,
      "dob": dob,
      "gender": gender,
      "pid": pid
    };
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return loading();
      },
    );

    try {
      var response = await http.post(
          Uri.parse(MyUrl.fullurl + "patient_details_update.php"),
          body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata['status'] == "true") {
        PATIENT.name = patient_name.text;
        PATIENT.email = patient_email.text;
        PATIENT.dob = setdate!;
        PATIENT.gender = patient_gender.text;
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: jsondata['bob'],
        );
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
