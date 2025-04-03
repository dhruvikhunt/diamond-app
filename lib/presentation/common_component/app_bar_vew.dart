import 'package:diamond_app/presentation/constants/app_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import 'image_assets.dart';

AppBar appBarView(
  BuildContext context, {
  String? title,
  bool isShowBack = true,
  List<Widget>? actions,
}) {
  return AppBar(
    surfaceTintColor: AppColors.transparent,
    backgroundColor: AppColors.white,
    actionsPadding: EdgeInsets.zero,
    leadingWidth: !isShowBack
        ? 0
        :  40,
    leading:
        !isShowBack
            ? SizedBox.shrink()
            : InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Transform.scale(
                  scale: 0.5,
                  child: ImageAsset(image: AppAssets.back),
                ),
              ),
            ),
    centerTitle: false,
    title:
        title?.isNotEmpty == true
            ? Text(
              title!,
              style: TextStyle().text500Weight(fontSize: 18.sp),
              textScaler: TextScaler.noScaling,
            )
            : SizedBox.shrink(),
    actions: actions,
  );
}
