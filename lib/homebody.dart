import 'package:flutter/material.dart';
import 'package:semesterproject/Category.dart';
import 'package:semesterproject/banner.dart';
import 'package:semesterproject/company.dart';
import 'package:semesterproject/header.dart';

class Homepagebody extends StatefulWidget {
  const Homepagebody({super.key});

  @override
  State<Homepagebody> createState() => _HomepagebodyState();
}

class _HomepagebodyState extends State<Homepagebody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Homeheader(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Getbanner(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Getcompanies(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Categories",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          GetCategory(),
        ],
      ),
    ));
  }
}
