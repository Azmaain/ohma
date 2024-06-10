import 'package:demo_project/components/repository/authentication_repository/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';
import '../repository/authentication_repository/authentication/authentication_repository.dart';



class CompleteScreenController extends GetxController{
    static CompleteScreenController get instance => Get.find();
    
    //TextField Controllers to get data from TextFields
    final address = TextEditingController();
    final firstName = TextEditingController();
    final lastName = TextEditingController();
    final phoneNo = TextEditingController();
    //final userRepo = Get.put(UserRepository());

    Future<void> createUser(UserModel user) async {
       print("User Data: $user");
      UserRepository userRepository = UserRepository();
      await userRepository.createUser(user);
      phoneAuthentication(user.phoneNo);
    }

    void phoneAuthentication(String phoneNo){
      AuthenticationRepository.instance.phoneAuthentication(phoneNo);
    }

}