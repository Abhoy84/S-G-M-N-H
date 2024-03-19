import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:hospital/model/doctormodel.dart';
import 'package:hospital/pages/Admin_add_doctor_image.dart';
import 'package:hospital/pages/Admin_home.dart';
import 'package:hospital/pages/loading.dart';
import 'package:hospital/utils/urlpage.dart';
import 'package:http/http.dart' as http;

class admin_add_doctor extends StatefulWidget {
  const admin_add_doctor({super.key});

  @override
  State<admin_add_doctor> createState() => _admin_add_doctorState();
}

class _admin_add_doctorState extends State<admin_add_doctor> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _degreeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String _category = "select Catagory";
  List<String> doctor_catagory = [
    "select Catagory",
    "Immunologists",
    "Anesthesiologists",
    "Cardiologists",
    "Dermatologists",
    "Endocrinologists",
    "Gastroenterologists",
    "Nephrologists",
    "Neurologists",
    "Pathologists",
    "Urologists",
    "Radiologists",
    "Pulmonologists",
    "Osteopaths",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: C.theme,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => admin_homepage()));
            },
            icon: Icon(Icons.arrow_back),
            color: C.white,
            iconSize: 30,
          ),
        ),
        title: Text(
          "Add-Doctor",
          style: TextStyle(color: C.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _degreeController,
                  decoration: InputDecoration(labelText: 'Degree'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid degree';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  value: _category,
                  onChanged: (value) {
                    setState(() {
                      _category = value as String;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Category'),
                  items: doctor_catagory
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value == "select Catagory") {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      doctor_signup(
                              _nameController.text,
                              _phoneController.text,
                              _emailController.text,
                              _ageController.text,
                              _degreeController.text,
                              _category)
                          .whenComplete(() {
                        getDoctordetails(_phoneController.text);
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future doctor_signup(String name, String phone, String email, String age,
      String degree, String category) async {
    Map data = {
      "name": name,
      "phone": phone,
      "email": email,
      "age": age,
      "degree": degree,
      "category": category
    };
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return loading();
      },
    );

    try {
      var response = await http
          .post(Uri.parse(MyUrl.fullurl + "doctor_signup.php"), body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata['status'] == true) {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: jsondata['msg'],
        );
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

  Future getDoctordetails(String phone) async {
    Map data = {'phone': phone};
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return loading();
      },
    );
    try {
      var response = await http.post(
          Uri.parse(MyUrl.fullurl + "get_doctor_details.php"),
          body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata['status'] == 'true') {
        Navigator.pop(context);
        DOCTOR.name = jsondata['data'][0]['d_name'];
        DOCTOR.id = jsondata['data'][0]['d_id'].toString();
        DOCTOR.phone = jsondata['data'][0]['d_phone'];
        DOCTOR.email = jsondata['data'][0]['d_email'];
        DOCTOR.degree = jsondata['data'][0]['d_degree'];
        DOCTOR.image = jsondata['data'][0]['d_image'];
        DOCTOR.category = jsondata['data'][0]['d_category'];
        DOCTOR.age = jsondata['data'][0]['d_age'];
        DOCTOR.status = jsondata['data'][0]['d_status'];

        AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            headerAnimationLoop: false,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            showCloseIcon: false,
            title: "Signin successfull",
            desc: "Thank you! for connect with us.",
            btnOkOnPress: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => admin_add_doctor_image()));
            }).show();
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
