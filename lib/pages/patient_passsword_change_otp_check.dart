import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:hospital/pages/loading.dart';

import 'package:hospital/pages/patient_password_change_otp_send.dart';
import 'package:hospital/pages/patient_reset_password_phone.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class password_change_otp_check extends StatefulWidget {
  const password_change_otp_check({super.key});

  @override
  State<password_change_otp_check> createState() =>
      _password_change_otp_checkState();
}

class _password_change_otp_checkState extends State<password_change_otp_check> {
  @override

  // ignore: override_on_non_overriding_member
  String otp = '';
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
                    builder: (context) => password_change_otp()));
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
                // submittedPinTheme: submittedPinTheme,
                // validator: (s) {
                //   return s == '2222' ? null : 'Pin is incorrect';
                // },
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
          verificationId: password_change_otpState.verifyid, smsCode: otp);

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: " verification Successfull");
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => patient_reset_password_by_phone()));
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
        btnOkOnPress: () {},
      ).show();
    }
  }
}
