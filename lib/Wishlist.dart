import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_ui/wishlistscreen.dart';

class Wishlist extends StatelessWidget {
  Wishlist({super.key});
  final collection = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .doc('WishlistItems')
      .collection('Wishlist');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDECF2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Wishlist',
          style: TextStyle(
              color: Color(0xFF4C53A5),
              fontSize: 23,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
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
            return ListView.builder(
              itemBuilder: (context, index) => Wishlistscreen(
                image: snapshot.data!.docs[index]['Image'],
                name: snapshot.data!.docs[index]['Name'],
                price: snapshot.data!.docs[index]['Price'],
              ),
              itemCount: snapshot.data!.docs.length,
            );
          }
        },
      ),
    );
  }
}
