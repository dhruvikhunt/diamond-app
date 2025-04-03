import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';


extension AppTextStyle on TextStyle {
  TextStyle textViewStyle({
    Color? textColor,
    double? fontSize,
  }) =>
      TextStyle(
        color: textColor ?? AppColors.black,
        fontSize: fontSize ?? 14.sp,
      );

  TextStyle textErrorStyle() =>
      TextStyle(
        color: AppColors.errorRed,
        fontSize: 12.sp,
      );

  TextStyle text300Weight({
    Color? textColor,
    double? fontSize,
  }) =>
      TextStyle(
        color: textColor ?? AppColors.black,
        fontSize: fontSize ?? 14.sp,
        fontWeight: FontWeight.w300,
      );

  TextStyle text400Weight({
    Color? textColor,
    double? fontSize,
  }) =>
      TextStyle(
        color: textColor ?? AppColors.black,
        fontSize: fontSize ?? 14.sp,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
      );

  TextStyle text500Weight({
    Color? textColor,
    double? fontSize,
  }) =>
      TextStyle(
        color: textColor ?? AppColors.black,
        fontSize: fontSize ?? 14.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle text600Weight({
    Color? textColor,
    double? fontSize,
  }) =>
      TextStyle(
        color: textColor ?? AppColors.black,
        fontSize: fontSize ?? 14.sp,
        fontWeight: FontWeight.w600,
      );

  TextStyle text700Weight({
    Color? textColor,
    double? fontSize,
  }) =>
      TextStyle(
        color: textColor ?? AppColors.black,
        fontSize: fontSize ?? 14.sp,
        fontWeight: FontWeight.w700,
      );

  TextStyle textBold({
    double? fontSize,
  }) =>
      TextStyle(
        fontSize: fontSize ?? 14.sp,
        fontWeight: FontWeight.bold,
      );
}
