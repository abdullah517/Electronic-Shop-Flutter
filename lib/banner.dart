import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

List images = ["assets/banner.png", "assets/offer1.jpg", "assets/hm.jpg"];

SizedBox Getbanner() {
  return SizedBox(
      height: 200,
      width: 330,
      child: Swiper(
        itemCount: images.length,
        itemBuilder: (context, index) => Image.asset(
          images[index],
          fit: BoxFit.fill,
        ),
        autoplay: true,
      ));
}
