import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  String image, name, price, quantity;
  Function updatequantity, deleteitem;

  final firestore = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .doc('CartItems')
      .collection('Cart');

  CartScreen(
      {required this.image,
      required this.name,
      required this.price,
      required this.quantity,
      required this.deleteitem,
      required this.updatequantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Radio(
            value: "",
            groupValue: "",
            onChanged: (value) {},
            activeColor: Color(0xFF4C53A5),
          ),
          Container(
            height: 70,
            width: 70,
            child: Image.asset(image),
            margin: EdgeInsets.only(right: 15),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C53A5)),
                  ),
                ),
                Text(
                  price + "PKR",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5)),
                )
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => deleteitem(name, quantity, price),
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                Row(
                  children: [
                    roundbutton(CupertinoIcons.plus, '+'),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        quantity,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4C53A5)),
                      ),
                    ),
                    roundbutton(CupertinoIcons.minus, '-'),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget roundbutton(IconData icn, String txt) {
    return Container(
        width: 25,
        height: 30,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 10)
            ]),
        child: IconButton(
            onPressed: () => updatequantity(txt, name, quantity, price),
            icon: Icon(
              icn,
              size: 14,
            )));
  }
}
