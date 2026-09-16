import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/requests/controllers/requests_controller.dart';
import 'package:hrm_app/features/requests/widgets/custom_request_titel_.dart';
import 'package:hrm_app/features/requests/widgets/row_button.dart';
import 'package:intl/intl.dart';

class TravelTicketView extends StatelessWidget {
  TravelTicketView({super.key});
  final requestController = Get.find<RequestsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomRequestTitel(subTitle: 'Travel Ticket Request'),
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
                titel: 'Departure',
                widget: CustomTextFiled(
                  label: 'Enter Departure Piont',
                  controller: requestController.departureController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Arrival',
                widget: CustomTextFiled(
                  label: 'Enter Destination',
                  controller: requestController.arrivalController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Travel Date',
                widget: Obx(
                  () => CustomTextFiled(
                    label: requestController.travelDate.value == null
                        ? 'dd/mm/yyyy'
                        : DateFormat(
                            'dd/MM/YYYY',
                          ).format(requestController.travelDate.value!),
                    suffixIcon: Icon(Icons.calendar_today_outlined),
                    readOnly: true,
                    onTap: () => requestController.pickTravelDate(context),
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Departure Time',
                widget: Obx(
                  () => CustomTextFiled(
                    label: requestController.departureTime.value == null
                        ? '--:--:--'
                        : requestController.departureTime.value!.format(
                            context,
                          ),
                    suffixIcon: Icon(Icons.av_timer_outlined),
                    readOnly: true,
                    onTap: () => requestController.pickDepartureTime(context),
                  ),
                ),
              ),

              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Travel Note',
                widget: CustomTextFiled(
                  label: 'Mention Any Specific Details',
                  maxLines: 5,
                  controller: requestController.descriptionController,
                ),
              ),
              AppSpacing.vertical15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Round Trip',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(
                    () => Transform.scale(
                      scale: 1.w,
                      child: Switch(
                        value: requestController.isRoundTrip.value,
                        onChanged: (value) {
                          requestController.isRoundTrip.value = value;
                        },
                        activeThumbColor: AppColors.whiteColor,
                        inactiveThumbColor: AppColors.whiteColor,
                        activeTrackColor: AppColors.primaryColor,
                        inactiveTrackColor: AppColors.containerBackColordark,
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Return Date',
                widget: Obx(
                  () => CustomTextFiled(
                    label: requestController.returnDate.value == null
                        ? 'dd/mm/yyyy'
                        : DateFormat(
                            'dd/MM/YYYY',
                          ).format(requestController.returnDate.value!),
                    suffixIcon: Icon(Icons.calendar_today_outlined),
                    readOnly: true,
                    onTap: () => requestController.pickReturnDate(context),
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Return Time',
                widget: Obx(
                  () => CustomTextFiled(
                    readOnly: true,
                    label: requestController.returnTime.value == null
                        ? '--:--:--'
                        : requestController.returnTime.value!.format(context),
                    suffixIcon: Icon(Icons.av_timer_outlined),
                    onTap: () => requestController.pickReturnTime(context),
                  ),
                ),
              ),
              AppSpacing.vertical15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Business Trip',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(
                    () => Transform.scale(
                      scale: 1.w,
                      child: Switch(
                        value: requestController.isBusinessTrip.value,
                        onChanged: (value) {
                          requestController.isBusinessTrip.value = value;
                        },
                        activeThumbColor: AppColors.whiteColor,
                        inactiveThumbColor: AppColors.whiteColor,
                        activeTrackColor: AppColors.primaryColor,
                        inactiveTrackColor: AppColors.containerBackColordark,
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical30,
              Obx(
                () => RowButton(
                  extraFields: {
                    'Departure': requestController.departureController.text
                        .trim(),
                    'Arrival': requestController.arrivalController.text.trim(),
                    'Travel Date': requestController.travelDate.value != null
                        ? DateFormat(
                            'dd/MM/yyyy',
                          ).format(requestController.travelDate.value!)
                        : '',
                    'Departure Time':
                        requestController.departureTime.value != null
                        ? requestController.departureTime.value!.format(context)
                        : '',
                    'Round Trip': requestController.isRoundTrip.value
                        .toString(),
                    'Return Date': requestController.returnDate.value != null
                        ? DateFormat(
                            'dd/MM/yyyy',
                          ).format(requestController.returnDate.value!)
                        : '',
                    'Return Time': requestController.returnTime.value != null
                        ? requestController.returnTime.value!.format(context)
                        : '',
                    'Business Trip': requestController.isBusinessTrip.value
                        .toString(),
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
