import 'package:demo_project/components/default_button.dart';
import 'package:demo_project/screens/pages/homepage/components/homepage.dart';
import 'package:demo_project/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight! * 0.04),
        Image.asset(
          "assets/images/Login_Success.png",
          height: SizeConfig.screenHeight! * 0.4,
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.08),
        Text(
          " Login Successful!",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth! * 0.6,
          child: DefaultButton(
            text: "Go to homepage",
            press: () {
              Navigator.pushNamed(context,GoBooking.routeName);
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
