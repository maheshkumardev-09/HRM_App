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
  final Rx<UserMoel?> currentUser = Rx<UserMoel?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    currentUser.value = await StorageService.getUser();
  }

  Future<void> ensureUserLoaded() async {
    if (currentUser.value == null) {
      await _loadCurrentUser();
    }
  }

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
        currentUser.value = user;
        clearFields();
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
        id: '1',
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await StorageService.saveUser(user);
      await StorageService.setLoggedIn(true);
      currentUser.value = user;
      clearFields();
      Get.offAllNamed(AppRoutes.navbar);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await StorageService.setLoggedIn(false);
    currentUser.value = null;
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
