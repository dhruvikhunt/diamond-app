import 'package:diamond_app/presentation/common_component/image_assets.dart';
import 'package:diamond_app/presentation/constants/app_assets.dart';
import 'package:diamond_app/presentation/constants/app_box_decoration.dart';
import 'package:diamond_app/presentation/constants/app_colors.dart';
import 'package:diamond_app/presentation/constants/app_font_style.dart';
import 'package:diamond_app/presentation/constants/app_routes.dart';
import 'package:diamond_app/presentation/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../common_component/app_bar_vew.dart';
import '../../../common_component/diamond_card.dart';
import '../bloc/diamond_bloc.dart';
import '../bloc/diamond_event.dart';
import '../bloc/diamond_state.dart';
import '../sort/sort_sheet.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key});

  final DiamondBloc _diamondBloc = DiamondBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: appBarView(
        context,
        title: AppStrings.appName,
        isShowBack: false,
        actions: [
          actionView(
            onTap: () {
              showSort(context);
            },
            image: AppAssets.sort,
          ),
          SizedBox(width: 7),
          actionView(
            onTap: () async {
              final result = await Navigator.pushNamed(
                context,
                AppRoutes.filterScreen,
              );

              final filterData = result as Map<String, dynamic>;

              debugPrint('result:--> $result');

              if (filterData != null) {
                // Extract values
                SfRangeValues rangeValues = filterData['rangeValues'];
                Set<String> selectedLabs = (filterData['selectedLabs']);
                Set<String> selectedShapes = (filterData['selectedShapes']);
                Set<String> selectedColors = (filterData['selectedColors']);
                Set<String> selectedClarities =
                    (filterData['selectedClarities']);

                _diamondBloc.add(
                  FilterDiamonds(
                    rangeValues: rangeValues,
                    selectedClarities: selectedClarities,
                    selectedColors: selectedColors,
                    selectedLabs: selectedLabs,
                    selectedShapes: selectedShapes,
                  ),
                );
                // Use the selected values for filtering in the previous screen
              }
            },
            image: AppAssets.filter,
          ),
          SizedBox(width: 7),

          actionView(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.cartScreen).then((value) {
                _diamondBloc.add(LoadDiamonds());
              });
            },
            image: AppAssets.removeToCart,
          ),

          SizedBox(width: 20),
        ],
      ),
      body: BlocBuilder<DiamondBloc, DiamondState>(
        bloc: _diamondBloc..add(LoadDiamonds()),
        builder: (context, state) {
          if (_diamondBloc.diamondList.isEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.noResultsFound, style: TextStyle().text400Weight(
                    fontSize: 15.sp,
                    textColor:
                    AppColors.black ,
                  ),),

                   SizedBox(height: 20,),

                   GestureDetector(
                     onTap: () {
                       _diamondBloc.add(LoadDiamonds());
                     },
                     child: Container(
                      margin: EdgeInsets.only(right: 10, bottom: 10),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        color:
                         AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        AppStrings.reload,
                        style: TextStyle().text400Weight(
                          fontSize: 13.sp,
                          textColor:
                          AppColors.white ,
                        ),
                      ),
                                     ),
                   ),
                ],
              ),
            );
          }
          return ListView.separated(
            itemCount: _diamondBloc.diamondList.length,
            padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              return DiamondCard(
                diamond: _diamondBloc.diamondList[index],
                onTap: () {
                  _diamondBloc.add(
                    AddToCart(lotId: _diamondBloc.diamondList[index].lotId!),
                  );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 5);
            },
          );
        },
      ),
    );
  }

  Widget actionView({required Function() onTap, required String image}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration().borderDecoration(
          isShowShadow: false,
          radius: 10,
        ),
        padding: EdgeInsets.all(10),
        child: ImageAsset(
          image: image,
          height: 18,
          width: 18,
          color: AppColors.black,
        ),
      ),
    );
  }

  void showSort(context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: AppColors.white,
      builder: (BuildContext context) {
        return SortSheet(diamondBloc: _diamondBloc);
      },
    );
  }
}
