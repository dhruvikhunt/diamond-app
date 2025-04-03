import 'package:diamond_app/presentation/common_component/image_assets.dart';
import 'package:diamond_app/presentation/constants/app_assets.dart';
import 'package:diamond_app/presentation/constants/app_box_decoration.dart';
import 'package:diamond_app/presentation/constants/app_colors.dart';
import 'package:diamond_app/presentation/constants/app_font_style.dart';
import 'package:diamond_app/presentation/constants/app_strings.dart';
import 'package:diamond_app/presentation/modules/home/bloc/diamond_bloc.dart';
import 'package:diamond_app/utils/app_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/diamond_event.dart';
import '../bloc/diamond_state.dart';

class SortSheet extends StatelessWidget {
  final DiamondBloc diamondBloc;

  const SortSheet({super.key, required this.diamondBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.topRight,
              child: ImageAsset(image: AppAssets.close),
            ),
          ),
          SizedBox(height: 20),

          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.sorting,
                        style: TextStyle().text500Weight(fontSize: 20.sp),
                      ),
                    ),
                    Text(AppStrings.asc, style: TextStyle().text400Weight(fontSize: 20.sp)),
                    SizedBox(width: 20),
                    Text(
                      AppStrings.desc,
                      style: TextStyle().text400Weight(fontSize: 20.sp),
                    ),
                  ],
                ),
                BlocBuilder<DiamondBloc, DiamondState>(
                  bloc: diamondBloc,
                  builder: (context, state) {
                    return Column(
                      children: [
                        // Sort by Carat
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                AppStrings.byCaratWeight,
                                style: TextStyle().text500Weight(),
                              ),
                            ),
                            Radio<int>(
                              value: 1,
                              groupValue: diamondBloc.caratSelected,
                              activeColor: AppColors.primary,
                              onChanged: _onCaratSelected,
                            ),
                            const SizedBox(width: 10),
                            Radio<int>(
                              value: 2,
                              groupValue: diamondBloc.caratSelected,
                              activeColor: AppColors.primary,
                              onChanged: _onCaratSelected,
                            ),
                          ],
                        ),

                        // Sort by Price
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                AppStrings.byPrice,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Radio<int>(
                              value: 1,
                              groupValue: diamondBloc.priceSelected,
                              activeColor: AppColors.primary,
                              onChanged: _onPriceSelected,
                            ),
                            const SizedBox(width: 10),
                            Radio<int>(
                              value: 2,
                              groupValue: diamondBloc.priceSelected,
                              activeColor: AppColors.primary,
                              onChanged: _onPriceSelected,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              diamondBloc.add(SubmitSortDiamonds());
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration().borderDecoration(
                color: AppColors.primary,
                isShowShadow: false,
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: Text(
                'Submit',
                style: TextStyle().text500Weight(
                  textColor: AppColors.white,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onCaratSelected(int? value) {
    diamondBloc.add(SortDiamonds(sortBy: SortType.byCarat, value: value!));
  }

  void _onPriceSelected(int? value) {
    diamondBloc.add(SortDiamonds(sortBy: SortType.byPrice, value: value!));
  }
}
