import 'package:demo_project/components/repository/authentication_repository/authentication/authentication_repository.dart';
import 'package:demo_project/screens/pages/homepage/home_screen.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const HomeScreen()) : Get.back();
  }
}