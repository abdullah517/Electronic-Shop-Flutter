import 'package:ecommerce_ui/globalcolours.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_ui/login.dart';
import 'package:ecommerce_ui/myorders.dart';
import 'package:get/get.dart';

class Userprofile extends StatelessWidget {
  Userprofile({super.key});

  FirebaseAuth _auth = FirebaseAuth.instance;

  void logout(BuildContext context) {
    _auth.signOut().then((value) => Get.to(Login()));
  }

  void gotomyorders(BuildContext context) {
    Get.to(MyOrders());
  }

  Widget Getbutton(
      BuildContext context, String text, Widget icon, Function logout) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.08,
      child: ElevatedButton(
        onPressed: () {
          if (text == "Log Out") {
            logout(context);
          } else if (text == "My Orders") {
            gotomyorders(context);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            Text(
              text,
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF4C53A5),
                  fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF4C53A5),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF5F6F9)),
      ),
    );
  }

  Widget Getspace(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.03,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Getspace(context),
              CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage("assets/p.jpg"),
              ),
              Text(
                FirebaseAuth.instance.currentUser!.email.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4C53A5),
                ),
              ),
              Getspace(context),
              Getbutton(
                  context,
                  "My Account",
                  Icon(
                    Icons.person,
                    size: 25,
                    color: Color(0xFF4C53A5),
                  ),
                  logout),
              Getspace(context),
              Getbutton(
                  context,
                  "Notifications",
                  Icon(
                    Icons.notifications,
                    size: 25,
                    color: Color(0xFF4C53A5),
                  ),
                  logout),
              Getspace(context),
              Getbutton(
                  context,
                  "My Orders",
                  Icon(
                    Icons.unsubscribe_rounded,
                    size: 25,
                    color: Color(0xFF4C53A5),
                  ),
                  logout),
              Getspace(context),
              Getbutton(
                context,
                "Help Center",
                Icon(
                  Icons.help_center,
                  size: 25,
                  color: Color(0xFF4C53A5),
                ),
                logout,
              ),
              Getspace(context),
              Getbutton(
                  context,
                  "Log Out",
                  Icon(
                    Icons.logout,
                    size: 25,
                    color: Color(0xFF4C53A5),
                  ),
                  logout),
            ],
          ),
        ),
      ),
    );
  }
}
