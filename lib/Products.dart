import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:semesterproject/gradientappbar.dart';
import 'package:semesterproject/productcontainer.dart';

class Productsscreen extends StatelessWidget {
  String apptitle;
  CollectionReference<Map<String, dynamic>> collection;
  Productsscreen({required this.collection, required this.apptitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Getappbar(apptitle),
      body: StreamBuilder(
          stream: collection.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('');
            } else {
              return GridView.count(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
                childAspectRatio: (0.27 / .4),
                children: snapshot.data!.docs.map((doc) {
                  return ProductContainer(
                      imagepath: doc['Image'],
                      itemname: doc['Name'],
                      itemprice: doc['Price']);
                }).toList(),
              );
            }
          }),
    );
  }
}
