import 'package:flutter/material.dart';

class Myorderscreen extends StatelessWidget {
  int orderid;
  List detail;
  Myorderscreen({required this.detail, required this.orderid});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
      child: Column(
        children: [
          Text(
            "Your orderid is: ${orderid.toString()}",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          for (int i = 0; i < detail.length; i++) ...[
            Text(
              detail[i],
              style: TextStyle(fontSize: 18),
            )
          ],
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Cash on Delivery",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.money,
                size: 25,
              )
            ],
          ),
        ],
      ),
    );
  }
}
