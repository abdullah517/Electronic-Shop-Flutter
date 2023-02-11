import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:semesterproject/login.dart';
import 'package:semesterproject/myorders.dart';

class Userprofile extends StatelessWidget {
  Userprofile({super.key});

  FirebaseAuth _auth = FirebaseAuth.instance;

  void logout(BuildContext context) {
    _auth.signOut().then((value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => login(),
        )));
  }

  void gotomyorders(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyOrders()));
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
              style: TextStyle(fontSize: 18),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
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
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Text(
              "Profile",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
            ),
            Getspace(context),
            CircleAvatar(
              radius: 90,
              backgroundImage: AssetImage("assets/p.jpg"),
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Getspace(context),
            Getbutton(
                context,
                "My Account",
                Icon(
                  Icons.person,
                  size: 25,
                ),
                logout),
            Getspace(context),
            Getbutton(
                context,
                "Notifications",
                Icon(
                  Icons.notifications,
                  size: 25,
                ),
                logout),
            Getspace(context),
            Getbutton(
                context,
                "My Orders",
                Icon(
                  Icons.unsubscribe_rounded,
                  size: 25,
                ),
                logout),
            Getspace(context),
            Getbutton(
              context,
              "Help Center",
              Icon(
                Icons.help_center,
                size: 25,
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
                ),
                logout),
          ],
        ),
      ),
    );
  }
}
