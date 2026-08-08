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

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final _authControllr = Get.find<AuthController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSpacing.vertical76,
            Image.asset(AppImages.logo, width: 113.w, height: 163.h),
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
                      'Welcome to app',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppSpacing.vertical8,
                    Text(
                      "Create your Account",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AppSpacing.vertical30,
                    CustomTextFiled(
                      label: 'Name',
                      keyboardType: TextInputType.name,
                      controller: _authControllr.nameController,
                      showBorder: false,
                      fillColor: AppColors.textfieldColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name required";
                        }
                        return null;
                      },
                    ),
                    AppSpacing.vertical16,
                    CustomTextFiled(
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      controller: _authControllr.emailController,
                      fillColor: AppColors.textfieldColor,
                      showBorder: false,
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
                        hidepassword: _authControllr.isPassword.value,
                        label: 'passwod',
                        keyboardType: TextInputType.visiblePassword,
                        fillColor: AppColors.textfieldColor,
                        showBorder: false,
                        controller: _authControllr.passwordController,
                        suffixIcon: IconButton(
                          onPressed: () => _authControllr.passwordToggle(),
                          icon: _authControllr.isPassword.value
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
                            return "Password must be 6 characters";
                          }

                          return null;
                        },
                      ),
                    ),
                    AppSpacing.vertical30,
                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: _authControllr.isLoading.value
                          ? CircularProgressIndicator(
                              color: AppColors.whiteColor,
                            )
                          : CustomButton(
                              title: 'Signup',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  _authControllr.signUp();
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
                            'I have a already account? ',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          AppSpacing.horizontal2,
                          GestureDetector(
                            onTap: () {
                              _authControllr.clearFields();
                              Get.toNamed(AppRoutes.loginview);
                            },
                            child: Text(
                              'LogIn',
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
