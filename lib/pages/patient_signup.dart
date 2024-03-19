import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:hospital/model/colormodel.dart';
import 'package:hospital/pages/loading.dart';
import 'package:hospital/pages/patient_otp.dart';
import 'package:hospital/pages/patient_login.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hospital/utils/urlpage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class patientsignup extends StatefulWidget {
  const patientsignup({super.key});

  @override
  State<patientsignup> createState() => patientsignupState();
}

class patientsignupState extends State<patientsignup> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool passwordvisiblity = true;
  bool confirmpasswordvisiblity = true;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  String selectgender = 'Male';
  bool nextpage = false;
  static String showdate = "";
  String? setdate;
  DateTime currentdate = DateTime.now();

  static String? username;
  static String? userphone;
  static String? useremail;
  static String? userpassword;
  static String? usergender;
  static String? userdob;
  static String? userage;
  static String verifyid = '';
  bool tap = false;
  String setage = '';
  DateTime? agedate;
  String password = '';
  String confirmpassword = '';
  String age = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => patientlogin()));
              },
              icon: Icon(Icons.arrow_back),
              color: C.white,
              iconSize: 30,
            ),
          ),
          title: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                "Patient Signup",
                speed: Duration(seconds: 1),
                textStyle: TextStyle(
                  fontFamily: 'lobster',
                  fontSize: 30,
                ),
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 255, 225, 0),
                  Colors.white
                ],
              )
            ],
            pause: Duration(milliseconds: 100),
            repeatForever: true,
          ),
          centerTitle: true,
          backgroundColor: C.theme,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Image.asset("asset/image/doctor-nurse.png"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      color: C.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 5, 19, 106),
                            spreadRadius: 2,
                            blurRadius: 15,
                            offset: Offset(0, 3)),
                      ]),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 90,
                        height: 80,
                        child: TextFormField(
                          controller: namecontroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Can't left blank";
                            } else {
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              prefixIconColor: C.theme,
                              hintText: "Enter Full Name",
                              hintStyle: TextStyle(
                                color: C.theme,
                                fontWeight: FontWeight.bold,
                              ),
                              labelText: "PATIENT NAME",
                              labelStyle: TextStyle(
                                color: C.theme,
                                fontWeight: FontWeight.bold,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: C.theme,
                                    width: 5,
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
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 90,
                        height: 80,
                        child: TextFormField(
                          controller: phonecontroller,
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                    width: 5,
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
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 90,
                        height: 80,
                        child: TextFormField(
                          controller: emailcontroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Can't left blank";
                            } else if (!RegExp(
                                    r'[^0-9]+[a-zA-Z0-9]+@+gmail+\.+com')
                                .hasMatch(value)) {
                              return 'Please enter Valide email id';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              prefixIconColor: C.theme,
                              hintText: "Enter E-mail",
                              hintStyle: TextStyle(
                                color: C.theme,
                                fontWeight: FontWeight.bold,
                              ),
                              labelText: "E-MAIL",
                              labelStyle: TextStyle(
                                color: C.theme,
                                fontWeight: FontWeight.bold,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: C.theme,
                                    width: 5,
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
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          tap = true;
                          DateTime? pickdate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1930),
                              lastDate: DateTime.now());
                          if (pickdate != null) {
                            showdate =
                                "${DateFormat('yMMMd').format(pickdate)}";
                            setdate = "${DateFormat('yMd').format(pickdate)}";
                            agedate = pickdate;
                          } else {
                            showdate =
                                "${DateFormat('yMMMd').format(currentdate)}";
                            setdate =
                                "${DateFormat('yMd').format(currentdate)}";
                            agedate = pickdate;
                          }
                          setState(() {
                            calculateAge(agedate!);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width - 95,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: C.theme, width: 3),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.calendar_month,
                                color: C.theme,
                                size: 27,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                tap == false ? "DATE-OF-BIRTH" : showdate,
                                style: TextStyle(
                                  color: C.theme,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: MediaQuery.of(context).size.width - 95,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: C.theme, width: 3),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.access_time,
                              color: C.theme,
                              size: 27,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              setage != '' ? setage : "Age",
                              style: TextStyle(
                                color: C.theme,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 15,
                            ),
                            child: Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return C.theme;
                                  }
                                  return C.theme;
                                },
                              ),
                              activeColor: C.theme,
                              focusColor: C.theme,
                              value: 'Male',
                              groupValue: selectgender,
                              onChanged: (value) {
                                setState(() {
                                  selectgender = value!;
                                });
                              },
                            ),
                          ),
                          Container(
                            child: Text(
                              "Male",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: C.theme),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            child: Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return C.theme;
                                  }
                                  return C.theme;
                                },
                              ),
                              activeColor: C.theme,
                              focusColor: C.theme,
                              groupValue: selectgender,
                              value: "Female",
                              onChanged: (value) {
                                setState(() {
                                  selectgender = value!;
                                });
                              },
                            ),
                          ),
                          Container(
                            child: Text(
                              "Female",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: C.theme),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            child: Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return C.theme;
                                  }
                                  return C.theme;
                                },
                              ),
                              activeColor: C.theme,
                              focusColor: C.theme,
                              groupValue: selectgender,
                              value: "Other",
                              onChanged: (value) {
                                setState(() {
                                  selectgender = value!;
                                });
                              },
                            ),
                          ),
                          Container(
                            child: Text(
                              "Other",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: C.theme),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 90,
                        height: 80,
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
                          onChanged: (value) => password = value,
                          keyboardType: TextInputType.number,
                          obscureText: passwordvisiblity,
                          obscuringCharacter: "*",
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            hintText: "Enter new Password",
                            hintStyle: TextStyle(
                              color: C.theme,
                              fontWeight: FontWeight.bold,
                            ),
                            labelText: "CREAT PASSWORD",
                            labelStyle: TextStyle(
                              color: C.theme,
                              fontWeight: FontWeight.bold,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: C.theme,
                                width: 5,
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
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        width: MediaQuery.of(context).size.width - 90,
                        height: 80,
                        child: TextFormField(
                          controller: passwordcontroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Can't left blank";
                            } else if (password != value) {
                              return "password does not match";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => confirmpassword = value,
                          keyboardType: TextInputType.number,
                          obscureText: confirmpasswordvisiblity,
                          obscuringCharacter: "*",
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              suffixIcon: TextButton(
                                child: confirmpasswordvisiblity
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: C.theme,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: C.theme,
                                      ),
                                onPressed: () {
                                  confirmpasswordvisiblity =
                                      !confirmpasswordvisiblity;
                                  setState(() {});
                                },
                              ),
                              prefixIcon: Icon(Icons.check_box_rounded),
                              prefixIconColor: C.theme,
                              hintText: "re-enter password",
                              hintStyle: TextStyle(
                                color: C.theme,
                                fontWeight: FontWeight.bold,
                              ),
                              labelText: "CONFIRM PASSWORD",
                              labelStyle: TextStyle(
                                color: C.theme,
                                fontWeight: FontWeight.bold,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: C.theme,
                                    width: 5,
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
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(children: [
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 169, 170, 177),
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: Offset(0, 5))
                    ]),
                    width: MediaQuery.of(context).size.width - 170,
                    height: 60,
                    margin: EdgeInsets.only(top: 40, bottom: 100),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: C.theme,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7))),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            "SIGN-UP",
                            speed: Duration(seconds: 1),
                            textStyle: TextStyle(
                                fontFamily: 'Mogra',
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                            colors: [
                              Color.fromARGB(255, 255, 255, 255),
                              Color.fromARGB(255, 255, 225, 0),
                              Colors.white
                            ],
                          )
                        ],
                        pause: Duration(milliseconds: 100),
                        repeatForever: true,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (formkey.currentState!.validate() && agedate != null) {
                        username = namecontroller.text;
                        userphone = phonecontroller.text;
                        useremail = emailcontroller.text;
                        userdob = setdate;
                        userage = setage;
                        usergender = selectgender;
                        userpassword = passwordcontroller.text;
                        sentOtp(phonecontroller.text);
                      } else {
                        Fluttertoast.showToast(msg: "Please enter all fields!");
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 42, bottom: 102, left: 3),
                      height: 55,
                      width: MediaQuery.of(context).size.width - 178,
                      color: Color.fromARGB(0, 100, 100, 100),
                    ),
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateAge(DateTime birthday) {
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
      setState(() {
        setage = '1 day';
      });
    } else if (ageInYears < 1 && ageInMonths < 1) {
      setState(() {
        setage = '$ageInDays days';
      });
    } else if (ageInYears < 1) {
      setState(() {
        setage = '$ageInMonths months';
      });
    } else {
      setState(() {
        setage = '$ageInYears years';
      });
    }
  }

  Future patientsignup(String name, String phone, String email, String dob,
      String age, String gender, String password) async {
    Map data = {
      "name": name,
      "phone": phone,
      "email": email,
      "dob": dob,
      "age": age,
      "gender": gender,
      "password": password
    };
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return loading();
      },
    );

    try {
      var response = await http
          .post(Uri.parse(MyUrl.fullurl + "patient_signup.php"), body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata['status'] == true) {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: jsondata['msg'],
        );
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.topSlide,
          headerAnimationLoop: false,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          showCloseIcon: false,
          title: "Signin successfull",
          desc: "Thank you! for connect with us.",
          btnOkOnPress: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => patientlogin()));
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

  Future sentOtp(String number) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return loading();
        });
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91" + number,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          verifyid = verificationId;
          Navigator.pop(context);

          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => patient_phone_verification_otp_check()));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Navigator.of(context);
      Fluttertoast.showToast(msg: e.toString());
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        btnOkColor: Colors.red,
        headerAnimationLoop: false,
        showCloseIcon: true,
        title: "Something Went Wrong!!",
        btnOkOnPress: () {},
      ).show();
    }
  }
}
