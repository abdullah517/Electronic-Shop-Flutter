import 'package:flutter/material.dart';
import 'package:ecommerce_ui/home.dart';
import 'button.dart';

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
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4C53A5)),
            ),
            SizedBox(
              height: 20,
            ),
            Mybutton(btntext: "Back to homepage", func: changescreen)
          ],
        ),
      ),
    );
  }
}
