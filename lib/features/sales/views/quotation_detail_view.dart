import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_card_tow_title.dart';
import 'package:hrm_app/components/custom_card_one_title.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/sales/controllers/sales_controller.dart';
import 'package:hrm_app/features/sales/models/sales_model.dart';
import 'package:intl/intl.dart';

class QuotationDetailView extends StatelessWidget {
  QuotationDetailView({super.key});
  final salescontroller = Get.find<SalesController>();

  final SalesModel saleslist = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final product = saleslist.products.first;
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpacing.vertical30,
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
                ],
              ),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(25.r),
                  color: AppColors.containerBackColor,
                ),
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: AppColors.containerBackColordark,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.personIcon,
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.cover,
                      ),
                      AppSpacing.horizontal15,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'customer:',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: saleslist.clientName,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppSpacing.vertical10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat(
                                    'yyy-MM-dd',
                                  ).format(saleslist.date),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: salescontroller.getStatusColor(
                                      saleslist.status,
                                    ),
                                  ),
                                  child: Text(
                                    saleslist.status,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
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
              AppSpacing.vertical20,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Products',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AppSpacing.vertical20,
                    CustomCardOneTitle(
                      titel: 'Prodect',
                      widget: CustomTextFiled(
                        label: product.productName,
                        controller: TextEditingController(),
                        readOnly: true,
                        fillColor: AppColors.textfieldColor,
                        showBorder: false,
                      ),
                    ),
                    AppSpacing.vertical15,
                    CustomCardOneTitle(
                      titel: 'Description',
                      widget: CustomTextFiled(
                        label: 'Alumnd windows with tranaprent glass',
                        controller: TextEditingController(),
                        showBorder: false,
                        fillColor: AppColors.textfieldColor,
                        readOnly: true,
                      ),
                    ),
                    AppSpacing.vertical15,
                    CustomRowCard(
                      title: 'Ordered',
                      title2: 'Delivered',
                      widget: CustomTextFiled(
                        label: product.quantity.toString(),
                        controller: TextEditingController(),
                        fillColor: AppColors.textfieldColor,
                        showBorder: false,
                        readOnly: true,
                      ),
                      widget2: CustomTextFiled(
                        label: product.availableQty.toString(),
                        controller: TextEditingController(),
                        fillColor: AppColors.textfieldColor,
                        showBorder: false,
                        readOnly: true,
                      ),
                    ),
                    AppSpacing.vertical20,
                    CustomRowCard(
                      title: 'Invoiced',
                      title2: 'Unit Price',
                      widget: CustomTextFiled(
                        label: '1.0',
                        controller: TextEditingController(),
                        fillColor: AppColors.textfieldColor,
                        showBorder: false,
                        readOnly: true,
                      ),
                      widget2: CustomTextFiled(
                        label: 'SR ${product.unitPrice.toString()}',
                        controller: TextEditingController(),
                        fillColor: AppColors.textfieldColor,
                        showBorder: false,
                        readOnly: true,
                      ),
                    ),
                    AppSpacing.vertical20,
                    CustomCardOneTitle(
                      titel: 'Subtotal',
                      widget: CustomTextFiled(
                        label: 'SR ${product.subtotal.toString()}',
                        controller: TextEditingController(),
                        fillColor: AppColors.textfieldColor,
                        showBorder: false,
                        readOnly: true,
                      ),
                    ),
                    AppSpacing.vertical20,
                    _rowWidget('Untaxed Amount', product.subtotal.toString()),
                    AppSpacing.vertical20,
                    _rowWidget('Tax', product.taxes.toString()),
                    AppSpacing.vertical20,
                    _rowWidget(
                      'Tota(Incl Tax):',
                      (product.subtotal + product.taxes).toString(),
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical35,
              SizedBox(
                height: 48.h,
                width: double.infinity,
                child: CustomButton(
                  title: 'Back to Quotation',
                  titleColor: Colors.black54,
                  buttonColor: AppColors.textfieldColor,
                  onTap: () => Get.back(),
                ),
              ),
              AppSpacing.vertical30,
            ],
          ),
        ),
      ),
    );
  }

  Widget _rowWidget(String title, String unit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        Text(
          '$unit SR',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
