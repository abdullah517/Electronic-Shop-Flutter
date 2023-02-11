import 'package:flutter/material.dart';

class Homeheader extends StatelessWidget {
  const Homeheader({super.key});

  Container Getconatiner(String path, BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.12,
        height: MediaQuery.of(context).size.width * 0.10,
        child: Image.asset(
          path,
          height: 0.13,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.60,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade300),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: " Search Product...",
                  hintStyle: TextStyle(fontSize: 20),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 23,
                  )),
            ),
          ),
        ),
        Getconatiner('assets/bell.png', context),
        Getconatiner('assets/shopping-cart.png', context)
      ],
    );
  }
}
