import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:hospital/model/doctormodel.dart';
import 'package:hospital/pages/Admin_add_doctor.dart';
import 'package:hospital/pages/Admin_home.dart';
import 'package:hospital/pages/loading.dart';
import 'package:hospital/utils/urlpage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class admin_add_doctor_image extends StatefulWidget {
  const admin_add_doctor_image({super.key});

  @override
  State<admin_add_doctor_image> createState() => _admin_add_doctor_imageState();
}

class _admin_add_doctor_imageState extends State<admin_add_doctor_image> {
  File? pickedImage;
  bool result = false;
  @override
  void initState() {
    Fluttertoast.showToast(msg: DOCTOR.id);
    // TODO: implement initState
    super.initState();
  }

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
                  MaterialPageRoute(builder: (context) => admin_add_doctor()));
            },
            icon: Icon(Icons.arrow_back),
            color: C.white,
            iconSize: 30,
          ),
        ),
        backgroundColor: C.theme,
        centerTitle: true,
        title: Text(
          "Add Doctor's image",
          style: TextStyle(color: C.white, fontFamily: 'Sriracha'),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          Stack(
            children: [
              Center(
                child: pickedImage != null
                    ? CircleAvatar(
                        radius: 100,
                        backgroundColor: C.blueShade,
                        child: CircleAvatar(
                          backgroundColor: C.white,
                          backgroundImage: FileImage(
                            pickedImage!,
                          ),
                          radius: 95,
                        ),
                      )
                    : CircleAvatar(
                        radius: 100,
                        backgroundColor: C.blueShade,
                        child: CircleAvatar(
                          radius: 95,
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          backgroundImage: NetworkImage(
                            MyUrl.fullurl + MyUrl.doctorimageurl + DOCTOR.image,
                          ),
                        ),
                      ),
              ),
              Positioned(
                  right: MediaQuery.of(context).size.width - 310,
                  top: 160,
                  child: IconButton(
                    icon: Icon(
                      Icons.add_a_photo,
                      color: C.black,
                      size: 30,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    pickImage(ImageSource.camera)
                                        .whenComplete(() {
                                      if (pickedImage != null) {
                                        doctorImageChange(
                                            pickedImage!, DOCTOR.id);
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    'Choose from Camera',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    pickImage(ImageSource.gallery)
                                        .whenComplete(() {
                                      if (pickedImage != null) {
                                        doctorImageChange(
                                            pickedImage!, DOCTOR.id);
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent),
                                  child: const Text(
                                    'Choose from Gallary',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ))
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Container(
              width: MediaQuery.of(context).size.width - 10,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (result) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.topSlide,
                      headerAnimationLoop: false,
                      dismissOnBackKeyPress: false,
                      dismissOnTouchOutside: false,
                      showCloseIcon: false,
                      title: "successfully saved",
                      desc: "Thank you again! for connect with us.",
                      btnOkOnPress: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => admin_homepage()));
                      },
                    ).show();
                  }
                },
                child: AutoSizeText(
                  "Save",
                  style: TextStyle(
                      color: C.white, fontSize: 25, fontFamily: 'mogra'),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: C.theme,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ))
        ],
      ),
    ));
  }

  Future pickImage(ImageSource imageType) async {
    try {
      final photo =
          await ImagePicker().pickImage(source: imageType, imageQuality: 50);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future doctorImageChange(File Uphoto, String userid) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return loading();
      },
    );

    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse(MyUrl.fullurl + "doctor_image.php"));

      request.files.add(await http.MultipartFile.fromBytes(
          'image', Uphoto.readAsBytesSync(),
          filename: Uphoto.path.split("/").last));
      request.fields['did'] = userid;

      var response = await request.send();

      var responded = await http.Response.fromStream(response);
      var jsondata = jsonDecode(responded.body);
      if (jsondata['status'] == 'true') {
        Navigator.pop(context);
        result = true;

        Fluttertoast.showToast(
          gravity: ToastGravity.CENTER,
          msg: jsondata['msg'],
        );
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(
          gravity: ToastGravity.CENTER,
          msg: jsondata['msg'],
        );
      }
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        gravity: ToastGravity.CENTER,
        msg: e.toString(),
      );
    }
  }
}
