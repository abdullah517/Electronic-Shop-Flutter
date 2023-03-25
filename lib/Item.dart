import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_ui/productcontainer.dart';
import 'package:flutter/material.dart';

class Itemwidget extends StatelessWidget {
  const Itemwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('TopProducts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('');
        } else {
          return GridView.count(
            physics: NeverScrollableScrollPhysics(),
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
      },
    );
  }
}
