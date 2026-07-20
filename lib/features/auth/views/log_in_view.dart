import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/auth/controllers/auth_controllr.dart';
import 'package:hrm_app/routes/app_routes.dart';

class LogInView extends StatelessWidget {
  LogInView({super.key});
  final _authController = Get.find<AuthControllr>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpacing.vertical60,
              Image.asset(AppImages.logo, width: 120.w, height: 160.h),
              AppSpacing.vertical60,
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                ),
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
                    AppSpacing.vertical10,
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
                      controller: _authController.emailController,
                    ),
                    AppSpacing.vertical20,
                    Obx(
                      () => CustomTextFiled(
                        hidepassword: _authController.isPassword.value,
                        label: 'passwod',
                        controller: _authController.passwordController,
                        suffixIcon: IconButton(
                          onPressed: () => _authController.passwordToggle(),
                          icon: _authController.isPassword.value
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                      ),
                    ),
                    AppSpacing.vertical10,
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    AppSpacing.vertical20,
                    SizedBox(
                      width: 350.w,
                      height: 40.h,
                      child: CustomButton(
                        title: 'Login',
                        onTap: () => _authController.logIn(),
                      ),
                    ),
                    AppSpacing.vertical30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('I don\'t have a account? '),
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.signupview),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
