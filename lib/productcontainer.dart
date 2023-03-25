import 'package:flutter/material.dart';
import 'package:ecommerce_ui/detailscreen.dart';
import 'package:get/get.dart';

class ProductContainer extends StatelessWidget {
  String imagepath;
  String itemname;
  String itemprice;
  ProductContainer(
      {required this.imagepath,
      required this.itemname,
      required this.itemprice});

  void gotodetailscreen(String image, BuildContext context, String text) {
    Get.to(Detailscreen(image: image, title: text, price: itemprice));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Color(0xFF4C53A5),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    '-50%',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ))
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Image.asset(
                imagepath,
                height: 120,
                width: 120,
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                itemname,
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF4C53A5),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Our best product...',
                style: TextStyle(fontSize: 15, color: Color(0xFF4C53A5)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itemprice + 'PKR',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4C53A5),
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.shopping_cart_checkout,
                        color: Color(0xFF4C53A5),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () => gotodetailscreen(imagepath, context, itemname),
    );
  }
}
