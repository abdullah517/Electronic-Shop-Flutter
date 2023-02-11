import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:semesterproject/home.dart';
import 'package:semesterproject/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool islogin() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    islogin() ? Homepage() : login())));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.purpleAccent,
              Colors.lightBlue,
              Colors.indigoAccent
            ])),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img.png"), fit: BoxFit.cover)),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Fazal Electronics",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 45,
                    color: Colors.lime),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
