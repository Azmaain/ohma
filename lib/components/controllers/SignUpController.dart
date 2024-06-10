import 'package:demo_project/components/repository/authentication_repository/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SignUpController extends GetxController{
    static SignUpController get instance => Get.find();

    //TextField Controllers to get data from TextFields
    final email = TextEditingController();
    final pass = TextEditingController();
    final repass = TextEditingController();

    

    void registerUser(String email,String password){
      String? error = AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password) as String?;
      if(error != null){
      AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
      }
    }

    


}