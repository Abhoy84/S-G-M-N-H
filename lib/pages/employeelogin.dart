import 'package:flutter/material.dart';
import 'package:hospital/model/colormodel.dart';
import 'package:hospital/pages/user_selection.dart';

class employeelogin extends StatefulWidget {
  const employeelogin({super.key});

  @override
  State<employeelogin> createState() => _employeeloginState();
}

class _employeeloginState extends State<employeelogin> {
  bool passwordvisiblity = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 15,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => userselection()));
              },
              icon: Icon(Icons.arrow_back),
              iconSize: 30,
              color: C.white,
            ),
          ),
          backgroundColor: C.theme,
          title: Text(
            "Employee login",
            style:
                TextStyle(fontFamily: "lobster", color: C.white, fontSize: 30),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/image/log-6.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(115, 12, 12, 12),
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(
                    style: BorderStyle.solid,
                    width: 5,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontFamily: "mogra",
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: C.white),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 90,
                      height: 80,
                      child: TextFormField(
                        // controller: phonecontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Can't left blank";
                          } else if (value.length != 10) {
                            return "enter 10 deigits";
                          } else if (!RegExp(r'^[6-9]\d{0,9}$')
                              .hasMatch(value)) {
                            return "enter valid mobile number";
                          } else {
                            return null;
                          }
                        },

                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.smartphone_sharp),
                            prefixIconColor: C.white,
                            hintText: "Enter Phone Number",
                            hintStyle: TextStyle(
                              color: C.white,
                              fontWeight: FontWeight.bold,
                            ),
                            labelText: "PHONE NO.",
                            labelStyle: TextStyle(
                              color: C.white,
                              fontWeight: FontWeight.bold,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: C.white,
                                  width: 7,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: C.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 90,
                      height: 70,
                      child: TextFormField(
                        // controller: passcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Can't left blank!";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        obscureText: passwordvisiblity,
                        obscuringCharacter: "*",
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_rounded),
                          prefixIconColor: C.white,
                          suffixIconColor: C.white,
                          suffixIcon: TextButton(
                              onPressed: () {
                                passwordvisiblity = !passwordvisiblity;
                                setState(() {});
                              },
                              child: passwordvisiblity
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: C.white,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: C.white,
                                    )),
                          hintText: "Enter  Password",
                          hintStyle: TextStyle(
                            color: C.white,
                            fontWeight: FontWeight.bold,
                          ),
                          labelText: " PASSWORD",
                          labelStyle: TextStyle(
                            color: C.white,
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: C.white,
                              width: 7,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: C.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        // color: C.black,
                        margin: EdgeInsets.only(right: 170),
                        child: Text(
                          "forgett password?",
                          style: TextStyle(
                              color: C.white,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(00, 7, 24, 152),
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: Offset(0, 5))
                      ]),
                      width: MediaQuery.of(context).size.width - 170,
                      height: 50,
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7))),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: C.theme,
                                fontFamily: "sriracha",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {}),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  child: Text(
                    "CREAT ACCOUNT",
                    style: TextStyle(
                        fontFamily: "SRIRACHA",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: C.white,
                        decoration: TextDecoration.underline,
                        decorationColor: C.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
