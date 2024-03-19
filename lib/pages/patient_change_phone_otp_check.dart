import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:hospital/model/patient_model.dart';
import 'package:hospital/pages/loading.dart';
import 'package:hospital/pages/patient_account.dart';
import 'package:hospital/pages/patient_change_phone_otp_send.dart';
import 'package:hospital/utils/urlpage.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;

class patient_change_phone_otp_check extends StatefulWidget {
  const patient_change_phone_otp_check({super.key});

  @override
  State<patient_change_phone_otp_check> createState() =>
      _patient_change_phone_otp_checkState();
}

class _patient_change_phone_otp_checkState
    extends State<patient_change_phone_otp_check> {
  @override

  // ignore: override_on_non_overriding_member
  var otp;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  final focusedPinTheme = PinTheme(
    width: 60,
    height: 60,
    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Color.fromARGB(0, 159, 157, 160),
      border: Border.all(color: C.theme, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  final submittedPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Enter OTP",
            style: TextStyle(color: C.white),
          ),
          centerTitle: true,
          backgroundColor: C.theme,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => patient_change_phone_otp_send()));
              },
              icon: Icon(Icons.arrow_back),
              iconSize: 30,
              color: C.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 260,
              child: LottieBuilder.asset(
                "asset/lotti/blue-otp.json",
              ),
            ),
            Text(
              "Phone Verification",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "We need to verify your phone before getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 70,
              child: Pinput(
                length: 6,
                defaultPinTheme: focusedPinTheme,
                focusedPinTheme: focusedPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onChanged: (value) {
                  otp = value;
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 150,
              child: ElevatedButton(
                  onPressed: () async {
                    checkOtp();
                  },
                  child: Text(
                    "verify - OTP".toUpperCase(),
                    style: TextStyle(
                        fontSize: 25, color: C.white, fontFamily: 'mogra'),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: C.theme,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)))),
            )
          ],
        )),
      ),
    );
  }

  Future checkOtp() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return loading();
        });
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: patient_change_phone_otp_sendState.verifyid,
          smsCode: otp);

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: " verification Successfull");
      changPhoneNumber(PATIENT.id, patient_change_phone_otp_sendState.newphone);
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //     builder: (context) => patient_reset_password_by_phone()));
    } catch (e) {
      Navigator.of(context);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        btnOkColor: Colors.red,
        headerAnimationLoop: false,
        showCloseIcon: false,
        title: "Something went wrong!!",
        btnOkOnPress: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => patient_account()));
        },
      ).show();
    }
  }

  Future changPhoneNumber(String pid, String phone) async {
    Map data = {'pid': pid, 'phone': phone};
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return loading();
        });
    try {
      var response = await http.post(
          Uri.parse(MyUrl.fullurl + "patient_change_phone.php"),
          body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == true) {
        Navigator.pop(context);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.topSlide,
          btnOkColor: Colors.green,
          headerAnimationLoop: false,
          showCloseIcon: false,
          title: jsondata['msg'],
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
          btnOkOnPress: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => patient_account()));
          },
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
        title: 'somthing went wrong!!',
        btnOkOnPress: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => patient_account()));
        },
      ).show();
    }
  }
}
