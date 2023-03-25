import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_ui/myorderscreen.dart';

import 'globalcolours.dart';

class MyOrders extends StatelessWidget {
  MyOrders({super.key});

  final collection = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .doc('Orders')
      .collection('userorders');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        backgroundColor: GlobalColors.mainColor,
      ),
      body: StreamBuilder(
        stream: collection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("");
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No orders found",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => Myorderscreen(
                detail: snapshot.data!.docs[index]['ordereditems'],
                orderid: snapshot.data!.docs[index]['orderid'],
              ),
              itemCount: snapshot.data!.docs.length,
            );
          }
        },
      ),
    );
  }
}
