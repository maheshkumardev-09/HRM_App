import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_card_tow_title.dart';
import 'package:hrm_app/components/custom_card_one_title.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
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
        padding: EdgeInsets.all(20.w),
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
              AppSpacing.vertical20,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(15.r),

                  color: Colors.grey.shade200,
                ),
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Colors.green.shade50,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.personIcon,
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.cover,
                      ),
                      AppSpacing.horizontal10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'customer:',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                AppSpacing.horizontal8,
                                Text(
                                  saleslist.clientName,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            AppSpacing.vertical8,
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
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Products',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppSpacing.vertical20,
                    CustomCardOneTitle(
                      titel: 'Prodect',
                      widget: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.grey.shade200,
                        ),
                        child: Text(product.productName),
                      ),
                    ),
                    AppSpacing.vertical20,
                    CustomCardOneTitle(
                      titel: 'Description',
                      widget: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.grey.shade200,
                        ),
                        child: Text(
                          'Alumnd windows with tranaprent glass',
                          maxLines: 1,
                        ),
                      ),
                    ),
                    AppSpacing.vertical20,
                    CustomRowCard(
                      title: 'Ordered',
                      title2: 'Delivered',
                      widget: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.grey.shade200,
                        ),
                        child: Text(product.quantity.toString()),
                      ),
                      widget2: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.grey.shade200,
                        ),
                        child: Text(product.availableQty.toString()),
                      ),
                    ),
                    AppSpacing.vertical20,
                    CustomRowCard(
                      title: 'Invoiced',
                      title2: 'Unit Price',
                      widget: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.grey.shade200,
                        ),
                        child: Text('1.0'),
                      ),
                      widget2: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.grey.shade200,
                        ),
                        child: Text('SR ${product.unitPrice.toString()}'),
                      ),
                    ),
                    AppSpacing.vertical20,
                    CustomCardOneTitle(
                      titel: 'Subtotal',
                      widget: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.grey.shade200,
                        ),
                        child: Text('SR ${product.subtotal.toString()}'),
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
              AppSpacing.vertical30,
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  title: 'Back to Quotation',
                  titleColor: Colors.black54,
                  buttonColor: Colors.grey.shade200,
                  onTap: () => Get.back(),
                ),
              ),
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
