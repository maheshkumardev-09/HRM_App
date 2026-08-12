import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_card_tow_title.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
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
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpacing.vertical30,
              CustomTitel(title: 'Create New Quotation'),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: AppColors.primaryColor),
                  color: AppColors.containerBackColor,
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
                    AppSpacing.vertical10,
                    CustomTextFiled(
                      label: 'Selact Customer',
                      prefixIcon: Icon(Icons.person),
                      controller: quotationController.customerController,
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.keyboard_arrow_down),
                      ),
                      fillColor: AppColors.textfieldColor,
                    ),
                    AppSpacing.vertical15,
                    Text(
                      'Quotation Date',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    AppSpacing.vertical10,
                    CustomTextFiled(
                      label: 'dd/mm/yy',
                      controller: quotationController.dateController,
                      prefixIcon: GestureDetector(
                        onTap: () => quotationController.pickDate(context),
                        child: Icon(Icons.calendar_today_outlined),
                      ),
                      showBorder: false,
                      readOnly: true,
                      fillColor: AppColors.textfieldColor,
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
                            borderRadius: BorderRadius.circular(25.r),
                            color: AppColors.whiteColor,
                            border: Border.all(color: AppColors.borderColor),
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
                              AppSpacing.vertical15,
                              Text(
                                'Product',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AppSpacing.vertical10,
                              CustomDropdownField(
                                hintText: 'Select Product',
                                value: controllers['product']!.text.isEmpty
                                    ? null
                                    : controllers['product']!.text,
                                items: salesController.ProdectNames,
                                onChanged: (value) {
                                  if (value != null) {
                                    controllers['product']!.text = value;
                                    quotationController.productControllers
                                        .refresh();
                                  }
                                },
                              ),
                              AppSpacing.vertical15,
                              CustomRowCard(
                                title: 'Quantity',
                                title2: 'Unit Price',
                                widget: CustomDropdownField(
                                  hintText: '10',
                                  value: controllers['quantity']!.text.isEmpty
                                      ? null
                                      : controllers['quantity']!.text,
                                  items: List.generate(
                                    100,
                                    (index) => (index++).toString(),
                                  ),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controllers['quantity']!.text = value;
                                      quotationController.productControllers
                                          .refresh();
                                    }
                                  },
                                ),
                                widget2: CustomTextFiled(
                                  keyboardType: TextInputType.number,
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
                                  keyboardType: TextInputType.number,
                                  label: ' SR 500.00',
                                  controller: controllers['taxes']!,
                                ),
                                widget2: CustomTextFiled(
                                  keyboardType: TextInputType.number,
                                  label: '10',
                                  controller: controllers['availableQty']!,
                                ),
                              ),
                              AppSpacing.vertical15,
                              Text(
                                'Subtotal',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AppSpacing.vertical10,
                              CustomTextFiled(
                                label: 'SR 1500.00',
                                controller: controllers['subtotal']!,
                                readOnly: true,
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
                child: SizedBox(
                  height: 44.h,
                  width: 132.w,
                  child: CustomButton(
                    title: '+ Add Product',
                    onTap: () {
                      quotationController.addProductLine();
                    },
                  ),
                ),
              ),
              AppSpacing.vertical30,
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: CustomButton(
                        title: 'Cancel',
                        titleColor: Colors.black54,
                        buttonColor: Colors.grey.shade300,
                        onTap: () {
                          Get.back();
                        },
                      ),
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
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      child: Text(
                        'Create Quotation',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical30,
            ],
          ),
        ),
      ),
    );
  }
}
