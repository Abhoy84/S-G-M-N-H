import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future<void> sandboxLoadingDialog(BuildContext context) async {
  // Show the dialog
  showDialog(
    context: context,
    barrierDismissible:
        false, // Prevents dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(0, 100, 100, 100),
        shadowColor: Colors.transparent,
        // surfaceTintColor: Colors.transparent,
        content: Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,

              // Customize the loading message
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                LottieBuilder.asset(
                  "asset/lotti/sandbox.json",
                  height: 90,
                  repeat: true,
                ),
                LottieBuilder.asset(
                  "asset/lotti/loadingbar.json",
                  height: 70,
                  width: 150,
                  repeat: false,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  // Delay for 3 seconds
  await Future.delayed(Duration(seconds: 1));

  // Close the dialog
  Navigator.of(context).pop();
}
