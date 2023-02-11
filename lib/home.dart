import 'package:flutter/material.dart';
import 'package:semesterproject/Cart.dart';
import 'package:semesterproject/Profile.dart';
import 'package:semesterproject/Wishlist.dart';
import 'package:semesterproject/homebody.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final listscreens = [
    Homepagebody(),
    Wishlist(),
    Usercart(),
    Userprofile(),
  ];

  Widget Getbottomnavigationbar() {
    return BottomNavigationBar(
      selectedFontSize: 17,
      unselectedFontSize: 17,
      selectedItemColor: Colors.limeAccent,
      unselectedItemColor: Colors.white,
      currentIndex: currentindex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.deepPurpleAccent,
      onTap: (value) => setState(() {
        currentindex = value;
      }),
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'home'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              size: 30,
            ),
            label: 'Wishlist'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              size: 30,
            ),
            label: 'Cart'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: 'Profile')
      ],
    );
  }

  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Getbottomnavigationbar(),
        body: listscreens[currentindex]);
  }
}
