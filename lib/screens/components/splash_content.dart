import 'package:demo_project/constrants.dart';
import 'package:demo_project/size_config.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    super.key,
    required this.text,
    required this.image,
  });
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "GoBooking",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
        ), //assets/images/Image Popular Product 3.png
        Spacer(flex: 2),
        Image.asset(
          image!,
          //height: getProportionateScreenHeight(265),
          //width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
