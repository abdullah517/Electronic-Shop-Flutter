import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_ui/globalcolours.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_ui/cartscreen.dart';
import 'package:ecommerce_ui/confirmorder.dart';
import 'package:ecommerce_ui/userinfo.dart';
import 'lists.dart';

class Usercart extends StatefulWidget {
  Usercart({super.key}) {
    BillPrice.counttotalprice();
  }

  @override
  State<Usercart> createState() => _UsercartState();
}

class _UsercartState extends State<Usercart> {
  final collection = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .doc('CartItems')
      .collection('Cart');

  Future<void> updatequantity(
      String sign, String name, String quantity, String price) async {
    final QuerySnapshot result =
        await collection.where('Name', isEqualTo: name).get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.isNotEmpty) {
      if (sign == '+') {
        quantity = (int.parse(quantity) + 1).toString();
        collection.doc(documents[0].id).update({'Quantity': quantity});
        BillPrice.totalprice += int.parse(price);
        setState(() {});
      } else if (sign == '-') {
        if (int.parse(quantity) > 1) {
          quantity = (int.parse(quantity) - 1).toString();
          collection.doc(documents[0].id).update({'Quantity': quantity});
          BillPrice.totalprice -= int.parse(price);
          setState(() {});
        }
      }
    }
  }

  Future<void> deleteitem(String name, String quantity, String price) async {
    final QuerySnapshot result =
        await collection.where('Name', isEqualTo: name).get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.isNotEmpty) {
      BillPrice.totalprice -= (int.parse(price) * int.parse(quantity));
      setState(() {});
      collection.doc(documents[0].id).delete();
    }
  }

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
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Cart',
            style: TextStyle(
                color: Color(0xFF4C53A5),
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          actions: [
            Icon(
              Icons.more_vert,
              size: 25,
              color: Color(0xFF4C53A5),
            )
          ],
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
                  "No items found",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFFEDECF2),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35)),
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            for (int index = 0;
                                index < snapshot.data!.docs.length;
                                index++)
                              CartScreen(
                                image: snapshot.data!.docs[index]['Image'],
                                name: snapshot.data!.docs[index]['Name'],
                                price: snapshot.data!.docs[index]['Price'],
                                quantity: snapshot.data!.docs[index]
                                    ['Quantity'],
                                deleteitem: deleteitem,
                                updatequantity: updatequantity,
                              ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF4C53A5),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Add Coupon Code',
                                style: TextStyle(
                                    color: Color(0xFF4C53A5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4C53A5)),
                    ),
                    Text(
                      BillPrice.totalprice.toString() + 'PKR',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: BillPrice.totalprice == 0 ? null : changescreen,
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: GlobalColors.mainColor),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
