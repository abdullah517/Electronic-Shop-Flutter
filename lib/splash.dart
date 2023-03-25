import 'dart:async';
import 'package:ecommerce_ui/globalcolours.dart';
import 'package:ecommerce_ui/home.dart';
import 'package:ecommerce_ui/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  bool islogin() {
    FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser != null)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5),
        (() => islogin() ? Get.to(Homepage()) : Get.to(Login())));
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: Center(
        child: Text(
          'Electro Elite',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 40,
              fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
