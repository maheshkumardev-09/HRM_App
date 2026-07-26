import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_row_card.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custum_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/sales/controllers/quotation_controller.dart';
import 'package:hrm_app/features/sales/controllers/sales_controller.dart';

class NewQuotationView extends StatelessWidget {
  NewQuotationView({super.key});
  final salesController = Get.find<SalesController>();
  final quotationController = Get.find<QuotationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showMenu: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTitel(title: 'Create New Quotation', ontap: () {}),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.primaryColor),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    AppSpacing.vertical8,
                    CustomTextFiled(
                      label: 'Selact Customer',
                      prefixicon: Icon(Icons.person_outline),
                      controller: quotationController.customerController,
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.keyboard_arrow_down),
                      ),
                    ),
                    AppSpacing.vertical15,
                    Text(
                      'Quotation Date',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    AppSpacing.vertical8,
                    CustomTextFiled(
                      label: 'dd/mm/yy',
                      controller: quotationController.dateController,
                      suffixIcon: GestureDetector(
                        onTap: () => quotationController.pickDate(context),
                        child: Icon(Icons.calendar_today_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical20,
              Obx(
                () => Column(
                  children: quotationController.productControllers
                      .asMap()
                      .entries
                      .map((entry) {
                        final index = entry.key;
                        final controllers = entry.value;
                        return Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.grey.shade100,
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    quotationController.removeProductLine(
                                      index,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(6.w),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 18.w,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Product',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AppSpacing.vertical8,
                              CustomTextFiled(
                                label: 'Select Product',
                                controller: controllers['product']!,
                                suffixIcon: GestureDetector(
                                  onTap: () {},
                                  child: Icon(Icons.keyboard_arrow_down),
                                ),
                              ),
                              AppSpacing.vertical15,
                              CustomRowCard(
                                title: 'Quantity',
                                title2: 'Unit Price',
                                widget: CustomTextFiled(
                                  label: '25',
                                  controller: controllers['quantity']!,
                                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                                  onChanged: (v) => quotationController
                                      .calculateSubtotal(index), // ✅ yahan
                                ),
                                widget2: CustomTextFiled(
                                  label: 'SR 1000.00',
                                  controller: controllers['unitPrice']!,
                                  onChanged: (v) => quotationController
                                      .calculateSubtotal(index),
                                ),
                              ),
                              AppSpacing.vertical15,
                              CustomRowCard(
                                title: 'Taxes',
                                title2: 'Ava Qty',
                                widget: CustomTextFiled(
                                  label: ' SR 500.00',
                                  controller: controllers['taxes']!,
                                ),
                                widget2: CustomTextFiled(
                                  label: '10',
                                  controller: controllers['availableQty']!,
                                ),
                              ),
                              AppSpacing.vertical8,
                              Text(
                                'Subtotal',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AppSpacing.vertical8,
                              CustomTextFiled(
                                label: 'SR 1500.00',
                                controller: controllers['subtotal']!,
                                readonly: true,
                                onChanged: (v) => quotationController
                                    .calculateSubtotal(index),
                              ),
                            ],
                          ),
                        );
                      })
                      .toList(),
                ),
              ),
              AppSpacing.vertical20,
              Align(
                alignment: Alignment.centerRight,
                child: CustomButton(title: '+Add Product', onTap: () {}),
              ),
              AppSpacing.vertical30,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: 'Cancel',
                      titleColor: Colors.black54,
                      buttonColor: Colors.grey.shade300,
                      onTap: () {},
                    ),
                  ),
                  AppSpacing.horizontal10,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        quotationController.createQuotation();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Create Quotation',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
