import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:hospital/model/doctordtails.dart';

import 'package:hospital/pages/loading.dart';
import 'package:hospital/pages/patient_Appointment_selection.dart';
import 'package:hospital/utils/urlpage.dart';
import 'package:http/http.dart' as http;

class patient_doctor_list extends StatefulWidget {
  const patient_doctor_list({super.key});

  @override
  State<patient_doctor_list> createState() => _patient_doctor_listState();
}

class _patient_doctor_listState extends State<patient_doctor_list> {
  List<Doctor> doctorlist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => patient_appointment_selection()));
            },
            icon: Icon(Icons.arrow_back),
            color: C.white,
            iconSize: 30,
          ),
        ),
        backgroundColor: C.theme,
        title: Text(
          "Doctor List",
          style: TextStyle(color: C.white),
        ),
      ),
      body: FutureBuilder(
        future: getDoctordetails('all'),
        builder: (BuildContext context, AsyncSnapshot data) {
          if (data.hasData) {
            return ListView.builder(
                itemCount: doctorlist.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 190,
                    width: MediaQuery.of(context).size.width - 20,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: C.black,
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 3))
                      ],
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 255, 255, 255),
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      // border: Border.all(color: C.theme, width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 0),
                              decoration: BoxDecoration(
                                // color: C.theme,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: MediaQuery.of(context).size.width - 260,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor: C.theme,
                                    child: CircleAvatar(
                                      backgroundColor: C.white,
                                      radius: 57,
                                      backgroundImage: NetworkImage(
                                          MyUrl.fullurl +
                                              MyUrl.doctorimageurl +
                                              doctorlist[index].image),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 180,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: AutoSizeText(
                                      "Dr." + doctorlist[index].name,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: AutoSizeText(
                                      doctorlist[index].degree,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: AutoSizeText(
                                      doctorlist[index].category,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width - 20.2,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 138, 94, 250),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                'View All Details',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: C.white),
                                maxLines: 1,
                              ),
                            ),
                            height: 40,
                          ),
                        )
                      ],
                    ),
                  );
                });
          } else {
            return Center(
              child: loading(),
            );
          }
        },
      ),
    ));
  }

  Future getDoctordetails(String phone) async {
    Map data = {'phone': phone};
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) {
    //     return loading();
    //   },
    // );
    try {
      var response = await http.post(
          Uri.parse(MyUrl.fullurl + "get_doctor_details.php"),
          body: data);
      var jsondata = jsonDecode(response.body.toString());
      if (jsondata['status'] == 'alltrue') {
        // Navigator.pop(context);

        doctorlist.clear();

        for (int i = 0; i < jsondata['data'].length; i++) {
          Doctor details = Doctor(
            jsondata['data'][i]['d_name'] ?? '',
            jsondata['data'][i]['d_phone'] ?? '',
            jsondata['data'][i]['d_id'].toString(),
            jsondata['data'][i]['d_category'] ?? '',
            jsondata['data'][i]['d_degree'] ?? '',
            jsondata['data'][i]['d_email'] ?? '',
            jsondata['data'][i]['d_age'] ?? '',
            jsondata['data'][i]['d_image'] ?? '',
            jsondata['data'][i]['d_status'] ?? '',
          );
          doctorlist.add(details);
        }
      } else {
        Navigator.pop(context);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.topSlide,
          btnOkColor: Colors.red,
          headerAnimationLoop: false,
          showCloseIcon: true,
          title: jsondata['msg'],
          btnOkOnPress: () {},
        ).show();
      }
      return doctorlist;
    } catch (e) {
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
    }
  }
}
