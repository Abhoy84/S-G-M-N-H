import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:hospital/pages/Admin_add_doctor.dart';
import 'package:hospital/pages/user_selection.dart';

class admin_homepage extends StatefulWidget {
  const admin_homepage({super.key});

  @override
  State<admin_homepage> createState() => _admin_homepageState();
}

class _admin_homepageState extends State<admin_homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: C.theme,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => userselection()));
              },
              icon: Icon(Icons.arrow_back),
              color: C.white,
              iconSize: 30,
            ),
          ),
          title: Text(
            "Admin-home",
            style: TextStyle(color: C.white),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => admin_add_doctor()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: C.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            color: C.black,
                            spreadRadius: 1,
                            offset: Offset(0, 1))
                      ]),
                  child: Center(
                    child: AutoSizeText(
                      "Add Doctor",
                      style: TextStyle(
                          color: C.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
