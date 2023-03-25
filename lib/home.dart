import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce_ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_ui/Cart.dart';
import 'package:ecommerce_ui/Wishlist.dart';
import 'package:ecommerce_ui/homebody.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final listscreens = [Homepagebody(), Wishlist(), Usercart(), Userprofile()];

  Widget Getbottomnavigationbar() {
    return CurvedNavigationBar(
      onTap: (value) => setState(() {
        currentindex = value;
      }),
      backgroundColor: Colors.transparent,
      color: Color(0xFF4C53A5),
      items: [
        Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.favorite_border,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.shopping_cart,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.person,
          size: 30,
          color: Colors.white,
        ),
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
