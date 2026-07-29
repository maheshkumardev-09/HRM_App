import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/auth/models/user_moel.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:hrm_app/services/storage_service.dart';

class AuthControllr extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPassword = true.obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> logIn() async {
    try {
      UserMoel? user = await StorageService.getUser();
      if (user == null) {
        Get.snackbar("Account Not Found", "Please sign up first");
        return;
      }
      if (user.email == emailController.text &&
          user.password == passwordController.text) {
        Get.snackbar("Success", "Login Successfully");
        Get.offAllNamed(AppRoutes.navbar);
      }
    } catch (e) {
      Get.snackbar('Error', "Invalid Email Password");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    try {
      UserMoel user = UserMoel(name: name, email: email, password: password);
      await StorageService.saveUser(user);
      Get.snackbar("Success", "Account Created");
      Get.offAllNamed(AppRoutes.navbar);
    } catch (e) {
      Get.snackbar('Error', 'fill all fildes ');
    } finally {
      isLoading.value = false;
    }
  }

  void passwordToggle() {
    isPassword.value = !isPassword.value;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
