import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:hospital/model/patient_model.dart';
import 'package:hospital/pages/patient_account.dart';
import 'package:hospital/utils/urlpage.dart';

class patientnavbar extends StatefulWidget {
  const patientnavbar({super.key});

  @override
  State<patientnavbar> createState() => _patientnavbarState();
}

class _patientnavbarState extends State<patientnavbar> {
  double iconspace = 25;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => patient_account()));
          },
          child: Container(
            height: 65,
            decoration: BoxDecoration(color: C.theme),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: C.white,
                  child: CircleAvatar(
                      radius: 27,
                      backgroundImage: NetworkImage(
                          MyUrl.fullurl + MyUrl.imageurl + PATIENT.image)),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 220,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: PATIENT.gender.toUpperCase() == 'MALE'
                        ? Text(
                            "Mr. " + PATIENT.name + "\t\t",
                            style: TextStyle(
                              color: C.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            "Mrs." + PATIENT.name + "\t\t",
                            style: TextStyle(
                              color: C.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 28,
                  color: C.white,
                )
              ],
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 15,
            ),
            InkWell(
                child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.person,
                  size: 35,
                ),
                SizedBox(
                  width: iconspace,
                ),
                Text(
                  "My Health Record",
                  style: TextStyle(fontSize: 18),
                )
              ],
            )),
            SizedBox(
              height: 30,
            ),
            InkWell(
                child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.calendar_month,
                  size: 30,
                ),
                SizedBox(
                  width: iconspace,
                ),
                Container(
                  width: 200,
                  child: Text(
                    "My Bookings",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                  color: Color.fromARGB(255, 116, 114, 114),
                ),
              ],
            )),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 1,
              color: C.brownShade,
              child: Row(),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
                child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.add_card_outlined,
                  size: 30,
                ),
                SizedBox(
                  width: iconspace,
                ),
                Text(
                  "Book Appointment",
                  style: TextStyle(fontSize: 18),
                )
              ],
            )),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
                child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Container(
                    height: 28,
                    width: 28,
                    child: Image.asset("asset/image/bill.png")),
                SizedBox(
                  width: iconspace,
                ),
                Text(
                  "Bill & Payments",
                  style: TextStyle(fontSize: 20),
                )
              ],
            )),
            SizedBox(
              height: 30,
            ),
            InkWell(
                child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.vaccines_outlined,
                  size: 30,
                ),
                SizedBox(
                  width: iconspace,
                ),
                Text(
                  "Vaccine Immunization",
                  style: TextStyle(fontSize: 18),
                )
              ],
            )),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 1,
              color: C.brownShade,
              child: Row(),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
                child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.question_mark,
                  size: 30,
                ),
                SizedBox(
                  width: iconspace,
                ),
                Text(
                  "FAQs",
                  style: TextStyle(fontSize: 18),
                )
              ],
            )),
            SizedBox(
              height: 30,
            ),
            InkWell(
                child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.feedback_outlined,
                  size: 30,
                ),
                SizedBox(
                  width: iconspace,
                ),
                Text(
                  "Feedback ",
                  style: TextStyle(fontSize: 18),
                )
              ],
            )),
            SizedBox(
              height: 30,
            ),
            InkWell(
                child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.settings,
                  size: 30,
                ),
                SizedBox(
                  width: iconspace,
                ),
                Text(
                  "Setting",
                  style: TextStyle(fontSize: 18),
                )
              ],
            )),
            SizedBox(
              height: 30,
            ),
            InkWell(
                child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Container(
                    height: 28,
                    width: 28,
                    child: Image.asset("asset/image/like.png")),
                SizedBox(
                  width: iconspace,
                ),
                Text(
                  "Like us?Give us a 5 stars",
                  style: TextStyle(fontSize: 18),
                )
              ],
            )),
          ],
        )
      ]),
    );
  }
}
