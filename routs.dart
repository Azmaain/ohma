import 'package:demo_project/screens/complete_profile/complete_profile_screeen.dart';
import 'package:demo_project/screens/forgot_password/forgot_password.dart';
import 'package:demo_project/screens/login_success/login_success_screen.dart';
import 'package:demo_project/screens/otp/otp_screen.dart';
import 'package:demo_project/screens/pages/homepage/components/homepage.dart';
import 'package:demo_project/screens/sign_in/sign_in_screen.dart';
import 'package:demo_project/screens/sign_up/sign_up_screen.dart';
import 'package:demo_project/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

//We use name route
//All our routes will be available here
final Map<String,WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignIn.routeName: (context) => const SignIn(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName:  (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(), 
  GoBooking.routeName: (context) => const GoBooking(),
};