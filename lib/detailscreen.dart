import 'package:clippy_flutter/arc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_ui/globalcolours.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Detailscreen extends StatefulWidget {
  String image, title, price;

  Detailscreen({required this.image, required this.title, required this.price});

  @override
  State<Detailscreen> createState() =>
      _DetailscreenState(image: image, text: title, price: price);
}

class _DetailscreenState extends State<Detailscreen> {
  final userid = FirebaseAuth.instance.currentUser!.uid;
  String image, text, price;
  bool isfav = false;
  _DetailscreenState(
      {required this.image, required this.text, required this.price}) {
    setisfav();
  }

  List<Color> Clrs = [
    Colors.red,
    Colors.green,
    Colors.indigo,
    Colors.blue,
    Colors.orange
  ];

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF4C53A5)),
        title: Text(
          'Product',
          style: TextStyle(
              color: Color(0xFF4C53A5),
              fontSize: 23,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: wishlist,
                icon: Icon(
                  isfav ? Icons.favorite : Icons.favorite_border,
                  size: 30,
                  color: Colors.red,
                )),
          )
        ],
      ),
      backgroundColor: Color(0xFFEDECF2),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Image.asset(
              image,
              height: 265,
            ),
          ),
          Arc(
            height: 30,
            edge: Edge.TOP,
            arcType: ArcType.CONVEY,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 20),
                      child: Row(
                        children: [
                          Text(
                            text,
                            style: TextStyle(
                                fontSize: 28,
                                color: Color(0xFF4C53A5),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Color(0xFF4C53A5),
                            ),
                            onRatingUpdate: (value) {},
                          ),
                          Row(
                            children: [
                              roundbutton(CupertinoIcons.plus),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  '01',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4C53A5)),
                                ),
                              ),
                              roundbutton(CupertinoIcons.minus)
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Our best Product.You can buy it from here.A nice product makes your life easy.This is the description of the product.I hope you like it.',
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFF4C53A5),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            'Color:',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4C53A5)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              for (int i = 0; i < 5; i++)
                                Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Clrs[i],
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 8)
                                      ]),
                                ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price + "PKR",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C53A5)),
                  ),
                  SizedBox(
                    width: 170,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: savecartitem,
                      icon: Icon(CupertinoIcons.cart_badge_plus),
                      label: Text(
                        'Add to Cart',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: GlobalColors.mainColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget roundbutton(IconData icn) {
    return Container(
        width: 25,
        height: 30,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10)
            ]),
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              icn,
              size: 14,
            )));
  }
}
