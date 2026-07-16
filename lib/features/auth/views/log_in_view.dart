import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';

class LogInView extends StatelessWidget {
  LogInView({super.key});
  final TextEditingController emailControllr = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60.h),
              Image.asset(
                'assets/logo/app_logo.png',
                width: 120.w,
                height: 160.h,
              ),
              SizedBox(height: 60.h),
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
                      'WelCome Back',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Please in to Sign your account',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    CustomTextFiled('Email', controller: emailControllr, obscureText: false,),
                    AppSpacing.mani,
                    CustomTextFiled(
                      'passwod',
                      controller: passwordController,
                      obscureText:true,
                      suffixIcon: Icon(Icons.visibility),
                    ),
                    AppSpacing.mani,
                    SizedBox(
                      width: 350.w,
                      height: 40.h,
                      child: CustomButton(title: 'LogIn', onTap: () {}),
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
