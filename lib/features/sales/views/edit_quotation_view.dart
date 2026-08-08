import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_card_tow_title.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_spacing.dart';

class EditQuotationView extends StatelessWidget {
  const EditQuotationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Edit Quotation:',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'S00052',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  GestureDetector(child: Icon(Icons.more_vert)),
                ],
              ),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AppSpacing.vertical8,
                    CustomTextFiled(
                      label: 'Consuitoncy',
                      controller: TextEditingController(),
                      suffixIcon: Icon(Icons.keyboard_arrow_down),
                    ),
                    AppSpacing.vertical16,
                    CustomRowCard(
                      title: 'Quontity',
                      title2: 'Unit Price',
                      widget: CustomTextFiled(
                        label: '1.0',
                        controller: TextEditingController(),
                        suffixIcon: Icon(Icons.keyboard_arrow_down),
                      ),
                      widget2: CustomTextFiled(
                        label: 'SR 1000.0',
                        controller: TextEditingController(),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical20,
              Align(
                alignment: Alignment.centerRight,
                child: CustomButton(title: '+Add Prodect', onTap: () {}),
              ),
              SizedBox(height: 200.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: 'Cancel',
                      titleColor: Colors.black54,
                      buttonColor: Colors.grey.shade200,
                      onTap: () {},
                    ),
                  ),
                  AppSpacing.horizontal10,
                  Expanded(
                    child: CustomButton(title: 'Save', onTap: () {}),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
