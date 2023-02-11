import 'package:flutter/material.dart';

class Getcompanies extends StatelessWidget {
  Getcompanies({super.key});

  Column Getcolumn(int index) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 72,
          decoration: BoxDecoration(
              color: Color(0XFFFFECDF),
              borderRadius: BorderRadius.circular(10)),
          child: Image.asset(imagepath[index]),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          names[index],
          style: TextStyle(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  List names = ["Dawlance", "Gree", "Panasonic", "Mitsubishi", "Haier"];
  List imagepath = [
    "assets/q1.png",
    "assets/q2.png",
    "assets/q3.png",
    "assets/q4.png",
    "assets/q5.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...List.generate(names.length, (index) => Getcolumn(index)),
      ],
    );
  }
}
