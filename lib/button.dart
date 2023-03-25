import 'package:flutter/material.dart';

import 'globalcolours.dart';

class Mybutton extends StatelessWidget {
  String btntext;
  Function func;
  double width;
  Mybutton({required this.func, required this.btntext, this.width = 270});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        onPressed: () => func(),
        child: Text(
          btntext,
          style: TextStyle(fontSize: 17),
        ),
        style:
            ElevatedButton.styleFrom(backgroundColor: GlobalColors.mainColor),
      ),
    );
  }
}
