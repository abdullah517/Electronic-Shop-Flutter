import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:semesterproject/Products.dart';

class GetCategory extends StatelessWidget {
  GetCategory({super.key});
  List images = [
    "assets/Air.png",
    "assets/cooler.jpg",
    "assets/refrigerator.jpg",
    "assets/wash.jpg",
    "assets/TV.jpeg",
    "assets/laptop.jpeg"
  ];

  List names = [
    "Air Conditioner",
    "Cooler",
    "Refrigerator",
    "Washing Machine",
    "LED TV",
    "Laptops",
  ];

  void gotoproducts(BuildContext context, String name) {
    if (name == "Air Conditioner") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Productsscreen(
                collection:
                    FirebaseFirestore.instance.collection('AirConditioner'),
                apptitle: name),
          ));
    } else if (name == "Cooler") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Productsscreen(
                collection: FirebaseFirestore.instance.collection('Cooler'),
                apptitle: name),
          ));
    } else if (name == "Refrigerator") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Productsscreen(
                collection:
                    FirebaseFirestore.instance.collection('Refrigerator'),
                apptitle: name),
          ));
    } else if (name == "Washing Machine") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Productsscreen(
                collection:
                    FirebaseFirestore.instance.collection('WashingMachine'),
                apptitle: name),
          ));
    } else if (name == "LED TV") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Productsscreen(
                collection: FirebaseFirestore.instance.collection('LEDTV'),
                apptitle: name),
          ));
    } else if (name == "Laptops") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Productsscreen(
                collection: FirebaseFirestore.instance.collection('Laptops'),
                apptitle: name),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 610,
      width: double.infinity,
      child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return GestureDetector(
              child: Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      height: 160,
                      width: 130,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(images[index]),
                              fit: BoxFit.cover)),
                    ),
                    Text(
                      names[index],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              onTap: () => gotoproducts(context, names[index]),
            );
          })),
    );
  }
}
