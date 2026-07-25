import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/components/custom2.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custum_app_bar.dart';
import 'package:hrm_app/constants/app_spacing.dart';

class NewQuotationView extends StatelessWidget {
  const NewQuotationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showMenu: false),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTitel(title: 'Create New Quotation', ontap: () {}),
                  AppSpacing.vertical20,
                  Container(
                    padding: EdgeInsets.all(15.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.grey.shade200,
                    ),
                    child: Column(
                      children: [
                        Text('Customer'),
                        AppSpacing.vertical15,
                        Container(
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.grey.shade100,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: Colors.grey.shade200,
                              ),
                              AppSpacing.horizontal12,
                              Text('Selact customer type'),
                            ],
                          ),
                        ),
                        AppSpacing.vertical20,
                        Text('Quotation Date'),
                        AppSpacing.vertical15,
                        Custom2(
                          titel: 'dd/mm/yy',
                          icon: Icons.calendar_today_outlined,
                          onTap: () {},
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
    );
  }
}
