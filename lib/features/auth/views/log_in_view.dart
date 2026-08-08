import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/auth/controllers/auth_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';

class LogInView extends StatelessWidget {
  LogInView({super.key});
  final _authController = Get.find<AuthController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSpacing.vertical76,
            Image.asset(AppImages.logo, width: 113.w, height: 168.h),
            AppSpacing.vertical76,
            Container(
              height: 592.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 40.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34.r),
                  topRight: Radius.circular(34.r),
                ),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppSpacing.vertical8,
                    Text(
                      'Please Sign in to your account',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    AppSpacing.vertical30,
                    CustomTextFiled(
                      label: 'Email',
                      showBorder: false,
                      keyboardType: TextInputType.emailAddress,
                      fillColor: AppColors.textfieldColor,
                      controller: _authController.emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email required";
                        }

                        if (!GetUtils.isEmail(value)) {
                          return "Enter valid email";
                        }

                        return null;
                      },
                    ),
                    AppSpacing.vertical16,
                    Obx(
                      () => CustomTextFiled(
                        keyboardType: TextInputType.visiblePassword,
                        hidepassword: _authController.isPassword.value,
                        label: 'Passwod',
                        fillColor: AppColors.textfieldColor,
                        controller: _authController.passwordController,
                        showBorder: false,
                        suffixIcon: IconButton(
                          onPressed: () => _authController.passwordToggle(),
                          icon: _authController.isPassword.value
                              ? Icon(
                                  Icons.visibility,
                                  color: AppColors.gary500Color,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: AppColors.gary500Color,
                                ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password required";
                          }
                          if (value.length < 6) {
                            return "Minimum 6 characters";
                          }
                          return null;
                        },
                      ),
                    ),
                    AppSpacing.vertical16,
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                    ),
                    AppSpacing.vertical35,
                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: _authController.isLoading.value
                          ? CircularProgressIndicator(
                              color: AppColors.whiteColor,
                            )
                          : CustomButton(
                              title: 'Login',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  _authController.logIn();
                                }
                              },
                            ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'I don\'t have a account? ',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          AppSpacing.horizontal2,
                          GestureDetector(
                            onTap: () {
                              _authController.clearFields();
                              Get.toNamed(AppRoutes.signupview);
                            },
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryColor,
                                decorationThickness: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
