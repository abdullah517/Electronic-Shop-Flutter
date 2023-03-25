import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_ui/productcontainer.dart';

import 'globalcolours.dart';

class Productsscreen extends StatelessWidget {
  String apptitle;
  CollectionReference<Map<String, dynamic>> collection;
  Productsscreen({required this.collection, required this.apptitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDECF2),
      appBar: AppBar(
        title: Text(apptitle),
        backgroundColor: GlobalColors.mainColor,
      ),
      body: StreamBuilder(
          stream: collection.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('');
            } else {
              return GridView.count(
                childAspectRatio: 0.51,
                crossAxisCount: 2,
                shrinkWrap: true,
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
