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

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final _authControllr = Get.find<AuthControllr>();
  final TextEditingController namecontroler = TextEditingController();
  final TextEditingController emailControllr = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpacing.vertical60,
              Image.asset(AppImages.logo, width: 120.w, height: 150.h),
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
                      'Welcome to app',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppSpacing.vertical10,
                    Text(
                      'Create you\'r Account',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    AppSpacing.vertical30,
                    CustomTextFiled(
                      label: 'Name',
                      controller: _authControllr.nameController,
                    ),
                    AppSpacing.vertical20,
                    CustomTextFiled(
                      label: 'Email',
                      controller: _authControllr.emailController,
                    ),
                    AppSpacing.vertical20,
                    Obx(
                      () => CustomTextFiled(
                        hidepassword: _authControllr.isPassword.value,
                        label: 'passwod',

                        controller: _authControllr.passwordController,
                        suffixIcon: IconButton(
                          onPressed: () => _authControllr.passwordToggle(),
                          icon: _authControllr.isPassword.value
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                      ),
                    ),
                    AppSpacing.vertical20,
                    SizedBox(
                      width: 350.w,
                      height: 40.h,
                      child: CustomButton(
                        title: 'Signup',
                        onTap: () => _authControllr.signUp(),
                      ),
                    ),
                    AppSpacing.vertical30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('I have a already account? '),
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.loginview),
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
