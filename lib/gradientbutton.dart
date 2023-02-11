import 'package:flutter/material.dart';

class gradientbtn extends StatelessWidget {
  String btntext;
  Function func;
  double width;
  gradientbtn({required this.btntext, required this.func, this.width = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: width == 0 ? MediaQuery.of(context).size.width * 0.7 : width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purpleAccent, Colors.indigoAccent]),
      ),
      child: TextButton(
        child: Text(
          btntext,
          style: TextStyle(
              fontSize: 25,
              color: Colors.limeAccent,
              fontWeight: FontWeight.w600),
        ),
        onPressed: () => func(),
      ),
    );
  }
}
