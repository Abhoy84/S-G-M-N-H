import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hospital/pages/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: splashscreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
