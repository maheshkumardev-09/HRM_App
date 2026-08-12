import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_card_tow_title.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/sales/controllers/quotation_controller.dart';
import 'package:hrm_app/features/sales/controllers/sales_controller.dart';
import 'package:hrm_app/features/sales/models/sales_model.dart';

class EditQuotationView extends StatelessWidget {
  EditQuotationView({super.key});
  final salesController = Get.find<SalesController>();

  final quotationController = Get.find<QuotationController>();
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final SalesModel sale = args['sale'];
    final int index = args['index'];
    quotationController.loadExistingData(sale);
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpacing.vertical30,
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Edit Quotation:',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'S00052',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical30,
              Obx(
                () => Column(
                  children: quotationController.productControllers
                      .asMap()
                      .entries
                      .map((entry) {
                        final i = entry.key;
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
                              Text(
                                'Product ',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AppSpacing.vertical10,
                              CustomDropdownField(
                                hintText: 'Consultancy Service',
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
                                title: 'Quontity',
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
                                      quotationController.calculateSubtotal(i);
                                      quotationController.productControllers
                                          .refresh();
                                    }
                                  },
                                ),
                                widget2: CustomTextFiled(
                                  keyboardType: TextInputType.number,
                                  label: 'SR 1000.0',
                                  controller: controllers['unitPrice']!,
                                  onChanged: (v) =>
                                      quotationController.calculateSubtotal(i),
                                ),
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
                    title: '+ Add Prodect',
                    onTap: () {
                      quotationController.addProductLine();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: SizedBox(
                height: 44.h,
                child: CustomButton(
                  title: 'Cancel',
                  titleColor: Colors.black54,
                  buttonColor: AppColors.textfieldColor,
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
            ),
            AppSpacing.horizontal10,
            Expanded(
              child: SizedBox(
                height: 44.h,
                child: CustomButton(
                  title: 'Save',
                  onTap: () {
                    salesController.updateQuotation(index, sale);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
