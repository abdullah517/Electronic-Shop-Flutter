import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:semesterproject/orderitemslist.dart';
import 'package:semesterproject/ordersuccess.dart';
import 'gradientbutton.dart';
import 'gradientappbar.dart';

class ConfirmOrder extends StatelessWidget {
  String uname, address, phoneno;
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();

  ConfirmOrder(
      {required this.address, required this.phoneno, required this.uname}) {
    controller1.text = uname;
    controller2.text = phoneno;
    controller3.text = address;
  }

  Future<void> myfunc() async {
    final collection = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('CartItems')
        .collection('Cart');
    QuerySnapshot querySnapshot = await collection.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    if (documents.isNotEmpty) {
      for (int i = 0; i < documents.length; i++) {
        collection.doc(documents[i].id).delete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    void placeorder() {
      int orderid = new Random().nextInt(999999);
      final firestore = FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc('Orders')
          .collection('userorders');
      firestore.doc().set({
        'ordereditems': Orderitems.totalitems,
        'orderid': orderid
      }).then((value) {
        myfunc();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrderSuccess()));
      });
    }

    return Scaffold(
        appBar: Getappbar('Order confirmation'),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: controller1,
              readOnly: true,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller2,
              readOnly: true,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller3,
              readOnly: true,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 40,
            ),
            gradientbtn(
              btntext: "Place order",
              func: placeorder,
              width: 190,
            ),
          ],
        ));
  }
}
