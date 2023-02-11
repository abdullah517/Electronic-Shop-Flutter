import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:semesterproject/calculate.dart';
import 'package:semesterproject/cartscreen.dart';
import 'package:semesterproject/confirmorder.dart';
import 'package:semesterproject/gradientbutton.dart';
import 'package:semesterproject/userinfo.dart';
import 'orderitemslist.dart';

class Usercart extends StatefulWidget {
  const Usercart({super.key});

  @override
  State<Usercart> createState() => _UsercartState();
}

class _UsercartState extends State<Usercart> {
  final collection = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .doc('CartItems')
      .collection('Cart');

  Future<void> saveorderitems() async {
    Orderitems.totalitems = [];
    QuerySnapshot querySnapshot = await collection.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    if (documents.isNotEmpty) {
      for (int i = 0; i < documents.length; i++) {
        Orderitems.totalitems
            .add("${documents[i]['Name']} * ${documents[i]['Quantity']}");
      }
    }
  }

  Future<void> changescreen() async {
    saveorderitems();
    final firestore = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid);
    var documentsnapshot = await firestore.doc('user information').get();
    if (documentsnapshot.exists) {
      Map<String, dynamic>? data = documentsnapshot.data();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmOrder(
                  address: " Address: ${data?['Address']}",
                  phoneno: " Phone No: ${data?['Phone number']}",
                  uname: " Name: ${data?['Username']}")));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Userinfo()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: collection.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("");
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No items found",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return ListView.builder(
            itemBuilder: (context, index) {
              if (index == snapshot.data!.docs.length) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                );
              } else if (index == snapshot.data!.docs.length + 1) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Total: Rs. " + Carttotal.totalprice.toString(),
                      style: TextStyle(
                          fontSize: 25, color: Colors.deepOrangeAccent),
                    ),
                    gradientbtn(
                      btntext: "Checkout",
                      func: changescreen,
                      width: 150,
                    )
                  ],
                );
              } else {
                return CartScreen(
                  image: snapshot.data!.docs[index]['Image'],
                  name: snapshot.data!.docs[index]['Name'],
                  price: snapshot.data!.docs[index]['Price'],
                  quantity: snapshot.data!.docs[index]['Quantity'],
                  index: index,
                );
              }
            },
            itemCount: snapshot.data!.docs.length + 2,
          );
        }
      },
    );
  }
}
