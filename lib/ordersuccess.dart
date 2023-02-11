import 'package:flutter/material.dart';
import 'package:semesterproject/gradientbutton.dart';
import 'package:semesterproject/home.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    void changescreen() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/succesicon.png"),
            Text(
              "Your order is placed successfully",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            gradientbtn(btntext: "Back to homepage", func: changescreen)
          ],
        ),
      ),
    );
  }
}
