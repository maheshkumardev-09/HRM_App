import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/attachment_upload_box.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/requests/controllers/requests_controller.dart';
import 'package:hrm_app/features/requests/widgets/custom_request_titel_.dart';
import 'package:hrm_app/features/requests/widgets/row_button.dart';
import 'package:intl/intl.dart';

class PurchaseRequestView extends StatelessWidget {
  PurchaseRequestView({super.key});
  final requestController = Get.find<RequestsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: Column(
            children: [
              CustomRequestTitel(subTitle: 'Purchase Request'),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Subject/Name',
                widget: CustomTextFiled(
                  label: 'Request purpose',
                  controller: requestController.subjectController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'product',
                widget: Obx(
                  () => CustomDropdownField(
                    value: requestController.selectedProduct.value.isEmpty
                        ? null
                        : requestController.selectedProduct.value,
                    hintText: 'Select',
                    items: requestController.productOptions,
                    onChanged: (vlaue) {
                      requestController.selectedProduct.value = vlaue!;
                    },
                  ),
                ),
              ),

              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Quantity',
                widget: CustomTextFiled(
                  label: '0.00',
                  controller: requestController.quantityController,
                  keyboardType: TextInputType.number,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Purchase Date',
                widget: Obx(
                  () => CustomTextFiled(
                    label: requestController.purchaseDate.value == null
                        ? 'dd/mm/yyyy'
                        : DateFormat(
                            'dd/MM/YYYY',
                          ).format(requestController.purchaseDate.value!),
                    readOnly: true,
                    onTap: () => requestController.pickPurchaseDate(context),
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 20.w),
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Purchase Amount',
                widget: CustomTextFiled(
                  label: '0.00',
                  controller: requestController.purchaseAmountController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Purchase Reason',
                widget: CustomTextFiled(
                  label: 'Explain the purchase...',
                  controller: requestController.descriptionController,
                  maxLines: 5,
                ),
              ),
              AppSpacing.vertical15,
              Obx(
                () => AttachmentUploadBox(
                  title: 'Invoice/Quote Atteachment',
                  selectedFile: requestController.selectedFile.value,
                  onTap: () => requestController.pickFile(),
                ),
              ),
              AppSpacing.vertical30,
              Obx(
                () => RowButton(
                  extraFields: {
                    'Product': requestController.selectedProduct.value,
                    'Quantity': requestController.quantityController.text
                        .trim(),
                    'Purchase Date':
                        requestController.purchaseDate.value != null
                        ? DateFormat(
                            'dd/MM/yyyy',
                          ).format(requestController.purchaseDate.value!)
                        : '',
                    'Purchase Amount': requestController
                        .purchaseAmountController
                        .text
                        .trim(),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
