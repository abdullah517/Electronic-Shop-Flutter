import 'package:flutter/material.dart';

InputBorder getfocusedborder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: BorderSide(color: Colors.lime, width: 3.0),
  );
}

InputBorder getenabledborder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: BorderSide(
      color: Colors.black54,
      width: 2.0,
    ),
  );
}

InputBorder geterrorborder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(color: Colors.red, width: 3.0));
}

InputBorder geterrorfocusedborder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(color: Colors.red, width: 3.0));
}
