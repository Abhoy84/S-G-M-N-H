import 'package:flutter/material.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:hospital/pages/patient_home.dart';

class patient_booktest_selection extends StatefulWidget {
  const patient_booktest_selection({super.key});

  @override
  State<patient_booktest_selection> createState() =>
      _patient_booktest_selectionState();
}

class _patient_booktest_selectionState
    extends State<patient_booktest_selection> {
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
                  MaterialPageRoute(builder: (context) => patienthome()));
            },
            icon: Icon(Icons.arrow_back),
            color: C.white,
            iconSize: 30,
          ),
        ),
        backgroundColor: C.theme,
        centerTitle: true,
        title: Text(
          "Select Appointment",
          style: TextStyle(color: C.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                  color: C.white,
                  boxShadow: [
                    BoxShadow(
                        color: C.theme,
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 5))
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: C.ble, width: 3)),
                    child: Image.asset(
                      "asset/image/blood2.png",
                      color: C.ble,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Blood Test",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: Text("In-hospital or Video consultent"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
