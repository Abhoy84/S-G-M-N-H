import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:hospital/model/patient_model.dart';
import 'package:hospital/pages/loading.dart';
import 'package:hospital/pages/patient_account.dart';
import 'package:hospital/pages/patient_change_phone_otp_check.dart';

class patient_change_phone_otp_send extends StatefulWidget {
  const patient_change_phone_otp_send({super.key});

  @override
  State<patient_change_phone_otp_send> createState() =>
      patient_change_phone_otp_sendState();
}

class patient_change_phone_otp_sendState
    extends State<patient_change_phone_otp_send> {
  static String verifyid = '';
  static String newphone = '';
  TextEditingController phonecontroller = TextEditingController();
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
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => patient_account()));
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
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Image.asset("asset/image/change-password2.png"),
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
                "We need to verify your phone for changing your phone number!",
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
              height: 80,
              width: MediaQuery.of(context).size.width - 70,
              child: TextFormField(
                // controller: emailcontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Can't left blank";
                  } else if (value.length != 10) {
                    return "enter 10 deigits";
                  } else if (!RegExp(r'^[6-9]\d{0,9}$').hasMatch(value)) {
                    return "enter valid mobile number";
                  } else {
                    return null;
                  }
                },
                controller: phonecontroller,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.smartphone_rounded),
                    prefixIconColor: C.theme,
                    hintText: "Enter new phone number",
                    hintStyle: TextStyle(
                      color: C.theme,
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: "new mobile number".toUpperCase(),
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
                        borderRadius: BorderRadius.circular(10))),
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
                    if (PATIENT.phone != phonecontroller.text) {
                      sentOtp();
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.topSlide,
                        btnOkColor: Colors.red,
                        headerAnimationLoop: false,
                        title: "Please enter a new phone number!!",
                        btnOkOnPress: () {},
                      ).show();
                    }
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
            title: "something went wrong!!",
            btnOkOnPress: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => patient_account()));
            },
          ).show();
        },
        codeSent: (String verificationId, int? resendToken) {
          verifyid = verificationId;
          newphone = phonecontroller.text;
          Navigator.pop(context);

          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => patient_change_phone_otp_check()));
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
        btnOkOnPress: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => patient_account()));
        },
      ).show();
    }
  }
}
