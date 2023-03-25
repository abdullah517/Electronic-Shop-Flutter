import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_ui/globalcolours.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
      height: 125,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
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
                ),
                RatingBar.builder(
                  initialRating: 4,
                  minRating: 1,
                  itemCount: 5,
                  itemSize: 20,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Color(0xFF4C53A5),
                  ),
                  onRatingUpdate: (value) {},
                ),
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: addtocart,
                    icon: Icon(CupertinoIcons.cart_badge_plus),
                    label: Text(
                      'Add to Cart',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: GlobalColors.mainColor),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
