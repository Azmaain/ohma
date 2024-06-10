

import 'package:demo_project/components/no_account_text.dart';
import 'package:demo_project/screens/login_success/login_success_screen.dart';
import 'package:demo_project/screens/pages/homepage/components/homepage.dart';
import 'package:demo_project/screens/sign_in/components/sign_form.dart';
import 'package:demo_project/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Body extends StatelessWidget {
  Body({Key? key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginSuccessScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Incorrect email or password'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.04,
                ),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.08,
                ),
                SignForm(
                  emailController: emailController,
                  passwordController: passwordController,
                  press: () => login(context),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.08,
                ),
                SizedBox(
                  width: double.infinity,
                  height: getProportionateScreenHeight(56),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                          }
                          return Color.fromARGB(235, 140, 151, 159);
                        },
                      ),
                    ),
                    onPressed: () async {
                      await signInWithGoogle(context);
                    },
                    child: Text(
                      "Sign In with Google",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        color: Color.fromARGB(255, 252, 251, 251),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      print('Google sign in aborted by user');
      return;
    }

    final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
    if (googleAuth == null) {
      print('Google authentication failed');
      return;
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential != null && userCredential.user != null) {
      print(userCredential.user!.email);
      Navigator.pushNamed(context, GoBooking.routeName);
    }
  } catch (error) {
    print('Error signing in with Google: $error');
  }
}
