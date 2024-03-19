import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:hospital/model/colormodel.dart';
import 'package:hospital/pages/patient_Appointment_selection.dart';
import 'package:hospital/pages/patient_booktest_selection.dart';
import 'package:hospital/pages/patient_navbar.dart';

class patienthome extends StatefulWidget {
  const patienthome({super.key});

  @override
  State<patienthome> createState() => patienthomeState();
}

class patienthomeState extends State<patienthome> {
  List imageList = [
    {"id": 1, "image_path": 'asset/image/p1.png'},
    {"id": 2, "image_path": 'asset/image/p2.jpg'},
    {"id": 3, "image_path": 'asset/image/p3.jpg'},
    {"id": 4, "image_path": 'asset/image/p4.png'},
    {"id": 5, "image_path": 'asset/image/p5.jpg'}
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: C.white),
          title: Text(
            "Hi, what would you like to do?",
            style: TextStyle(color: C.white),
          ),
          backgroundColor: C.theme,
        ),
        drawer: patientnavbar(),
        body: Column(
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => patient_appointment_selection()));
                  },
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width - 50,
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
                          child:
                              Image.asset("asset/image/book_appointment.png"),
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
                                "Book Appointment",
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
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => patient_booktest_selection()));
                  },
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width / 3.3,
                    decoration: BoxDecoration(
                      color: C.white,
                      boxShadow: [
                        BoxShadow(
                            color: C.theme,
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 3))
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: EdgeInsets.only(bottom: 20),
                              height: 80,
                              child:
                                  Image.asset("asset/image/book_test32.png")),
                          Text("Book Tests",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ))
                        ]),
                  ),
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width / 3.3,
                  decoration: BoxDecoration(
                    color: C.white,
                    boxShadow: [
                      BoxShadow(
                          color: C.theme,
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 3))
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            height: 80,
                            child: Image.asset(
                              "asset/image/bill2.png",
                            )),
                        Text("Bills &\n Payments",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ))
                      ]),
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width / 3.3,
                  decoration: BoxDecoration(
                    color: C.white,
                    boxShadow: [
                      BoxShadow(
                          color: C.theme,
                          spreadRadius: 0,
                          blurRadius: 3,
                          offset: Offset(0, 3))
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            height: 80,
                            child: Image.asset("asset/image/vaccine.png")),
                        Text("Vaccine\n Immunization",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ))
                      ]),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width / 2.2,
                  decoration: BoxDecoration(
                    color: C.white,
                    boxShadow: [
                      BoxShadow(
                          color: C.theme,
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 3))
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.all(5),
                            height: 40,
                            child: Image.asset(
                              "asset/image/records2.png",
                              color: C.deepblue,
                            )),
                        Text("My Health Records",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ))
                      ]),
                ),
                Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width / 2.2,
                  decoration: BoxDecoration(
                    color: C.white,
                    boxShadow: [
                      BoxShadow(
                          color: C.theme,
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 3))
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.all(5),
                            height: 40,
                            child: Image.asset(
                              "asset/image/booking.png",
                              color: C.deepblue,
                            )),
                        Text("My Bookings",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ))
                      ]),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Stack(children: [
                InkWell(
                  child: CarouselSlider(
                    items: imageList
                        .map(
                          (item) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(
                                    item['image_path'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(color: C.theme, width: 2)),
                          ),
                        )
                        .toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      autoPlay: true,
                      aspectRatio: 2,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  // top: 0,
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () =>
                            carouselController.animateToPage(entry.key),
                        child: Container(
                          width: currentIndex == entry.key ? 20 : 10,
                          height: 10,
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == entry.key
                                  ? C.theme
                                  : C.brownShade),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
