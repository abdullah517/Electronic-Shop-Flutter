import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:semesterproject/calculate.dart';

class CartScreen extends StatelessWidget {
  String image, name, price, quantity;
  int index;
  final firestore = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .doc('CartItems')
      .collection('Cart');

  CartScreen(
      {required this.image,
      required this.name,
      required this.price,
      required this.quantity,
      required this.index}) {
    if (index == 0) {
      Carttotal.totalprice = 0;
    }
    Carttotal.totalprice += int.parse(quantity) * int.parse(price);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 200,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 170,
              height: 200,
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => deleteitem(),
                    icon: Icon(
                      Icons.delete,
                      size: 30,
                    )),
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text(
                  "Price:" + price,
                  style:
                      TextStyle(color: Colors.deepOrangeAccent, fontSize: 18),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: TextButton(
                          onPressed: () => updatequantity('+'),
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    SizedBox(
                        height: 60,
                        width: 80,
                        child: TextButton(
                            onPressed: null,
                            child: Text(
                              quantity,
                              style: TextStyle(fontSize: 20),
                            ))),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: TextButton(
                          onPressed: () => int.parse(quantity) > 1
                              ? updatequantity('-')
                              : null,
                          child: Text(
                            '-',
                            style: TextStyle(fontSize: 23),
                          )),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updatequantity(String text) async {
    final QuerySnapshot result =
        await firestore.where('Name', isEqualTo: name).get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.isNotEmpty) {
      if (text == '+') {
        quantity = (int.parse(quantity) + 1).toString();
        firestore.doc(documents[0].id).update({'Quantity': quantity});
        Carttotal.totalprice += int.parse(price);
      } else if (text == '-') {
        quantity = (int.parse(quantity) - 1).toString();
        firestore.doc(documents[0].id).update({'Quantity': quantity});
        Carttotal.totalprice -= int.parse(price);
      }
    }
  }

  Future<void> deleteitem() async {
    final QuerySnapshot result =
        await firestore.where('Name', isEqualTo: name).get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.isNotEmpty) {
      Carttotal.totalprice -= int.parse(quantity) * int.parse(price);
      firestore.doc(documents[0].id).delete();
    }
  }
}
