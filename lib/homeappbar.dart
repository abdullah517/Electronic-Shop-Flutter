import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          Icon(
            Icons.sort,
            size: 30,
            color: Color(0xFF4C53A5),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Electro Elite',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4C53A5)),
            ),
          ),
          Spacer(),
          Badge(
            badgeStyle:
                BadgeStyle(badgeColor: Colors.red, padding: EdgeInsets.all(7)),
            badgeContent: Text(
              '3',
              style: TextStyle(color: Colors.white),
            ),
            child: InkWell(
              onTap: () {},
              child: Icon(Icons.shopping_bag_outlined,
                  size: 35, color: Color(0xFF4C53A5)),
            ),
          )
        ],
      ),
    );
  }
}
