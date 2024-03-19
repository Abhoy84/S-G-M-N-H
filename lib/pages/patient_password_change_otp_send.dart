import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:hospital/model/patient_model.dart';
import 'package:hospital/pages/loading.dart';
import 'package:hospital/pages/patient_passsword_change_otp_check.dart';
import 'package:hospital/pages/patient_password_change_by_oldpass.dart';
import 'package:lottie/lottie.dart';

class password_change_otp extends StatefulWidget {
  const password_change_otp({super.key});

  @override
  State<password_change_otp> createState() => password_change_otpState();
}

class password_change_otpState extends State<password_change_otp> {
  static String verifyid = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => patient_password_change()));
            },
            icon: Icon(Icons.arrow_back),
            iconSize: 30,
            color: C.white,
          ),
        ),
        backgroundColor: C.theme,
        title: Text(
          "Reset Password",
          style: TextStyle(color: C.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 260,
              child: LottieBuilder.asset(
                "asset/lotti/blue.json",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Phone OTP Verification",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "We need to verify your phone for changing your password!",
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
              alignment: Alignment.center,
              height: 60,
              width: MediaQuery.of(context).size.width - 60,
              child: Text(
                "OTP will be send in " +
                    hidePhonenumber(PATIENT.phone) +
                    " number for reset password ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 150,
              child: ElevatedButton(
                  onPressed: () {
                    sentOtp();
                  },
                  child: Text(
                    "SEND - OTP",
                    style: TextStyle(
                        fontSize: 25, color: C.white, fontFamily: 'mogra'),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: C.theme,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)))),
            )
          ],
        ),
      ),
    ));
  }

  String hidePhonenumber(String phone) {
    if (phone.length != 10) {
      throw ArgumentError("Input should be a 10-digit string");
    }

    // Extract first two digits, last two digits, and the middle part
    String firstTwoDigits = phone.substring(0, 2);
    String middlePart = phone.substring(2, 8);
    String lastTwoDigits = phone.substring(8);

    // Replace characters in the middle part with '*'
    String maskedMiddlePart = '*' * middlePart.length;

    // Concatenate the parts to get the masked string
    String maskedString = '$firstTwoDigits$maskedMiddlePart$lastTwoDigits';

    return maskedString;
  }

  Future sentOtp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return loading();
        });
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + PATIENT.phone,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
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
        },
        codeSent: (String verificationId, int? resendToken) {
          verifyid = verificationId;
          Navigator.pop(context);

          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => password_change_otp_check()));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
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
