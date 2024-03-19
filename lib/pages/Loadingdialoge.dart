import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future<void> showLoadingDialog(BuildContext context) async {
  // Show the dialog
  showDialog(
    context: context,
    barrierDismissible:
        false, // Prevents dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        shadowColor: Colors.transparent,
        // surfaceTintColor: Colors.transparent,
        content: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LottieBuilder.asset("asset/lotti/ambulence.json", height: 100),
              LottieBuilder.asset(
                "asset/lotti/blue-bar.json",
                height: 70,
                width: 150,
                repeat: false,
              ),
            ],
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
