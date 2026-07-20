import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/features/auth/models/user_moel.dart';
import 'package:hrm_app/routes/app_routes.dart';

class AuthControllr extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPassword = true.obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var userData = UserMoel(
    email: 'kumarmahesh123mengh@gmail.com',
    name: 'Ahamad',
    profileImage: AppImages.profileImage,
    designation: 'Software Engineer',
  ).obs;

  Future<void> logIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    try {
      isLoading.value = true;
      if (email.isEmpty || password.isEmpty) {
        Get.snackbar('Error', 'Please Enter your email and password ');
        Get.toNamed(AppRoutes.homeview);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    try {
      isLoading.value = true;
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        Get.snackbar('Errr', 'please Enter Your name email and password');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    // String email = emailController.text.trim();
  }

  void passwordToggle() {
    isPassword.value = !isPassword.value;
  }
}
