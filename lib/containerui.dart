import 'package:ecommerce_ui/customcircle.dart';
import 'package:flutter/material.dart';
import 'globalcolours.dart';

Widget getcontainer(BuildContext context, String text1, String text2) {
  return Container(
      color: GlobalColors.mainColor,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width * 0.20,
            top: MediaQuery.of(context).size.height * 0.03,
            child: Customcircle(
              height: 25.0,
              width: 25.0,
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.03,
            top: MediaQuery.of(context).size.height * -0.065,
            child: Customcircle(
              height: 110.0,
              width: 110.0,
              borderwidth: 3.0,
              color: Colors.amberAccent.withOpacity(0.5),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              text1 + '\n' + text2,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 43,
                  color: Colors.white),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.15,
            bottom: MediaQuery.of(context).size.height * 0.05,
            child: Customcircle(
              height: 25.0,
              width: 25.0,
            ),
          ),
        ],
      ));
}
