import 'package:flutter/material.dart';

PreferredSizeWidget Getappbar(String apptitle) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.limeAccent,
    ),
    title: Text(
      apptitle,
      style: TextStyle(fontSize: 30, color: Colors.limeAccent),
    ),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purpleAccent, Colors.indigoAccent]),
      ),
    ),
  );
}
