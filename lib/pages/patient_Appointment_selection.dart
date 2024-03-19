import 'package:flutter/material.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:hospital/pages/patient_doctor_list.dart';
import 'package:hospital/pages/patient_home.dart';

class patient_appointment_selection extends StatefulWidget {
  const patient_appointment_selection({super.key});

  @override
  State<patient_appointment_selection> createState() =>
      _patient_appointment_selectionState();
}

class _patient_appointment_selectionState
    extends State<patient_appointment_selection> {
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => patient_doctor_list()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 170,
                decoration: BoxDecoration(
                    color: C.white,
                    boxShadow: [
                      BoxShadow(
                          color: C.theme,
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, -1))
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      child: Image.asset("asset/image/book_appointment.png"),
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
                            "Physical Appointment",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 170,
              decoration: BoxDecoration(
                  color: C.white,
                  boxShadow: [
                    BoxShadow(
                        color: C.theme,
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, -1))
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 90,
                    width: 90,
                    child: Image.asset("asset/image/video-call.png"),
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
                          "Video Consultent",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    ));
  }
}
