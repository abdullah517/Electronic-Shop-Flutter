import 'package:flutter/material.dart';
import 'package:semesterproject/detailscreen.dart';

class ProductContainer extends StatelessWidget {
  String imagepath;
  String itemname;
  String itemprice;
  ProductContainer(
      {required this.imagepath,
      required this.itemname,
      required this.itemprice});

  void gotodetailscreen(String image, BuildContext context, String text) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Detailscreen(
            image: image,
            text: text,
            price: itemprice,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 280,
        width: 150,
        decoration: BoxDecoration(color: Colors.amber.shade100),
        child: Column(
          children: [
            Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imagepath), fit: BoxFit.fill)),
            ),
            Text(
              itemname,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            Text(
              "Price: " + itemprice,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      onTap: () => gotodetailscreen(imagepath, context, itemname),
    );
  }
}
