import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:semesterproject/gradientbutton.dart';

class Wishlistscreen extends StatelessWidget {
  String image, price, name;
  Wishlistscreen(
      {required this.name, required this.image, required this.price});

  final userid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    Future<void> savecartitem() async {
      String quantity;
      final firestore = FirebaseFirestore.instance
          .collection(userid)
          .doc('CartItems')
          .collection('Cart');
      final QuerySnapshot result =
          await firestore.where('Name', isEqualTo: name).get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.isEmpty) {
        firestore.doc().set({
          'Name': name,
          'Image': image,
          'Price': price,
          'Quantity': '1'
        }).then((value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Added to cart")));
        });
      } else {
        firestore.doc(documents[0].id).get().then((value) {
          quantity = value.data()!['Quantity'];
          quantity = (int.parse(quantity) + 1).toString();
          firestore.doc(documents[0].id).update({'Quantity': quantity});
        });
      }
    }

    Future<void> addtocart() async {
      savecartitem();
      final firestore = FirebaseFirestore.instance
          .collection(userid)
          .doc('WishlistItems')
          .collection('Wishlist');
      QuerySnapshot snapshot =
          await firestore.where('Name', isEqualTo: name).get();
      final List<DocumentSnapshot> documents = snapshot.docs;
      if (documents.isNotEmpty) {
        firestore.doc(documents[0].id).delete();
      }
    }

    return Container(
      padding: EdgeInsets.all(2),
      height: 220,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text(
                  "Price:" + price,
                  style:
                      TextStyle(color: Colors.deepOrangeAccent, fontSize: 20),
                ),
                RatingBar.builder(
                  initialRating: 2,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 4,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                gradientbtn(
                  btntext: 'Add to Cart',
                  func: addtocart,
                  width: 160,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
