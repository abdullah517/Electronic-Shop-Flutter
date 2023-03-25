import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Orderitems {
  static List totalitems = [];
}

class BillPrice {
  static int totalprice = 0;
  static void counttotalprice() {
    final firestore = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('CartItems')
        .collection('Cart');

    firestore.snapshots().listen((querySnapshot) {
      totalprice = 0;
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        totalprice += (int.parse(data['Price']) * int.parse(data['Quantity']));
      }
    });
  }
}
