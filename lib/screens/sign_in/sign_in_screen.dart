import 'package:demo_project/screens/sign_in/components/body.dart';
import 'package:flutter/material.dart';
//import '../components/body.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  static String routeName = '/sign_in';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("               Sign In"),
      ),
      body: Body(),
    );
  }
}