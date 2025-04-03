import 'package:flutter/material.dart';

import 'app_colors.dart';

extension AppBoxDecoration on BoxDecoration {
  BoxDecoration borderDecoration({
    bool isShowShadow = true,
    double radius = 15,
    Color? color,
  }) => BoxDecoration(
    color: color?? AppColors.white,

    boxShadow: [
      BoxShadow(
        color: AppColors.grey,
        // Shadow color with opacity
        blurRadius: isShowShadow ? 5 : 0,
        spreadRadius:  1,
        // Softness of the shadow
        // offset: Offset(offSetX, offSetY),
        // Position of the shadow (X, Y)
        blurStyle: BlurStyle.outer,
      ),
    ],
    borderRadius: BorderRadius.circular(radius),
  );
}
