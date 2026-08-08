import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/auth/models/user_moel.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:hrm_app/services/storage_service.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPassword = true.obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> logIn() async {
    try {
      isLoading.value = true;
      UserMoel? user = await StorageService.getUser();
      if (user == null) {
        Get.snackbar("Account Not Found", "Please signup first");
        return;
      }
      if (user.email == emailController.text.trim() &&
          user.password == passwordController.text.trim()) {
        await StorageService.setLoggedIn(true);
        clearFields();
        Get.snackbar("Success", "Login Successfully");
        Get.offAllNamed(AppRoutes.navbar);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp() async {
    try {
      isLoading.value = true;
      UserMoel user = UserMoel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await StorageService.saveUser(user);
      await StorageService.setLoggedIn(true);
      clearFields();
      Get.snackbar("Success", "Account Created");
      Get.offAllNamed(AppRoutes.navbar);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await StorageService.setLoggedIn(false);
    Get.offAllNamed(AppRoutes.loginview);
  }

  void passwordToggle() {
    isPassword.value = !isPassword.value;
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
