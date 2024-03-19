import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class loading extends StatelessWidget {
  const loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: Container(
            height: 250,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color.fromARGB(0, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: LottieBuilder.asset("asset/lotti/loding-2.json",
                        height: 230)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
