import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_ui/Products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Category extends StatelessWidget {
  Category({super.key});

  List texts = [
    'Microwave oven',
    'LED TV',
    'Refrigerator',
    'Air Conditioner',
    'WashingMachine',
    'Cooler'
  ];

  void gotoproducts(String name) {
    if (name == 'Microwave oven') {
      Get.to(Productsscreen(
          collection: FirebaseFirestore.instance.collection('Oven'),
          apptitle: name));
    } else if (name == 'LED TV') {
      Get.to(Productsscreen(
          collection: FirebaseFirestore.instance.collection('LEDTV'),
          apptitle: name));
    } else if (name == 'Refrigerator') {
      Get.to(Productsscreen(
          collection: FirebaseFirestore.instance.collection('Refrigerator'),
          apptitle: name));
    } else if (name == 'Air Conditioner') {
      Get.to(Productsscreen(
          collection: FirebaseFirestore.instance.collection('AirConditioner'),
          apptitle: name));
    } else if (name == 'WashingMachine') {
      Get.to(Productsscreen(
          collection: FirebaseFirestore.instance.collection('WashingMachine'),
          apptitle: name));
    } else if (name == 'Cooler') {
      Get.to(Productsscreen(
          collection: FirebaseFirestore.instance.collection('Cooler'),
          apptitle: name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 1; i <= 6; i++)
            InkWell(
              onTap: () {
                gotoproducts(texts[i - 1]);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/$i.png',
                      width: 40,
                      height: 40,
                    ),
                    Text(
                      texts[i - 1],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF4C53A5)),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
