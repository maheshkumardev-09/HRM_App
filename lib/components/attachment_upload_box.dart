import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/constants/app_colors.dart';

class AttachmentUploadBox extends StatelessWidget {
  final String title;
  final File? selectedFile;
  final VoidCallback? onTap;
  const AttachmentUploadBox({
    super.key,
    required this.title,
    this.selectedFile,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: AppColors.containerBackColor,
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        spacing: 15.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          GestureDetector(
            onTap: () => onTap,
            child: Container(
              padding: EdgeInsets.all(15.w),
              height: 114.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: selectedFile == null
                  ? Column(
                      spacing: 5.h,
                      children: [
                        Container(
                          height: 34.h,
                          width: 34.w,
                          decoration: BoxDecoration(
                            color: AppColors.containerBackColordark,
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                          child: Icon(
                            Icons.file_upload_outlined,
                            color: AppColors.primaryColor,
                            size: 16.w,
                          ),
                        ),
                        Text(
                          'Cilck to Upload',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'PDF,PNG,JPG,upto 10MB',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      selectedFile!.path.split('/').last,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
