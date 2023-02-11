import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:semesterproject/gradientbutton.dart';

class Detailscreen extends StatefulWidget {
  String image, text, price;

  Detailscreen({required this.image, required this.text, required this.price});

  @override
  State<Detailscreen> createState() =>
      _DetailscreenState(image: image, text: text, price: price);
}

class _DetailscreenState extends State<Detailscreen> {
  final userid = FirebaseAuth.instance.currentUser!.uid;
  String image, text, price;
  bool isfav = false;
  _DetailscreenState(
      {required this.image, required this.text, required this.price}) {
    setisfav();
  }

  Future<void> setisfav() async {
    final firestore = FirebaseFirestore.instance
        .collection(userid)
        .doc('WishlistItems')
        .collection('Wishlist');
    final QuerySnapshot result =
        await firestore.where('Name', isEqualTo: text).get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.isNotEmpty) {
      setState(() {
        isfav = true;
      });
    }
  }

  Future<void> wishlist() async {
    final firestore = FirebaseFirestore.instance
        .collection(userid)
        .doc('WishlistItems')
        .collection('Wishlist');
    final QuerySnapshot result =
        await firestore.where('Name', isEqualTo: text).get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.isEmpty) {
      firestore.doc().set({
        'Name': text,
        'Image': image,
        'Price': price,
      }).then((value) {
        setState(() {
          isfav = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Added to wishlist successfully")));
      });
    } else {
      firestore.doc(documents[0].id).delete().then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Removed from wishlist')));
        setState(() {
          isfav = false;
        });
      });
    }
  }

  Future<void> savecartitem() async {
    String quantity;
    final firestore = FirebaseFirestore.instance
        .collection(userid)
        .doc('CartItems')
        .collection('Cart');
    final QuerySnapshot result =
        await firestore.where('Name', isEqualTo: text).get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.isEmpty) {
      firestore.doc().set({
        'Name': text,
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(300),
          child: AppBar(
            backgroundColor: Colors.grey.shade300,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 35,
              ),
              color: Colors.black,
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.fill)),
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                IconButton(
                    onPressed: () => wishlist(),
                    icon: Icon(
                      isfav ? Icons.favorite : Icons.favorite_border,
                      size: 30,
                    )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Text(
              "Lorem ipsum dolor sit amet consectetur adipisicing elit. Neque, odio!" +
                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Neque, odio!" +
                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Neque, odio!" +
                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Neque, odio!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            gradientbtn(btntext: "Add to Cart", func: savecartitem)
          ],
        ),
      ),
    );
  }
}
