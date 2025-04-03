import 'package:diamond_app/data/models/diamond_model.dart';
import 'package:diamond_app/presentation/common_component/app_bar_vew.dart';
import 'package:diamond_app/presentation/constants/app_box_decoration.dart';
import 'package:diamond_app/presentation/constants/app_colors.dart';
import 'package:diamond_app/presentation/constants/app_font_style.dart';
import 'package:diamond_app/presentation/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../utils/app_enum.dart';
import 'bloc/filter_bloc.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class FilterScreen extends StatelessWidget {

  FilterScreen({super.key,});

  final FilterBloc _filterBloc = FilterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: appBarView(context, title: AppStrings.filter),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<FilterBloc, FilterState>(
                bloc:
                    _filterBloc
                      ..add(LoadFilterData()),
                builder: (context, state) {
                  return ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Carat',
                        style: TextStyle().text500Weight(
                          textColor: AppColors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                      SfRangeSliderTheme(
                        data: SfRangeSliderThemeData(
                          tooltipBackgroundColor: AppColors.primary,
                          tooltipTextStyle: TextStyle().text400Weight(textColor: AppColors.white,fontSize: 12.sp)
                        ),
                        child: SfRangeSlider(
                          min: 0.0,
                          max: _filterBloc.maxValue,
                          values: _filterBloc.rangeValues,
                          showTicks: true,
                          showLabels: true,
                          enableTooltip: true,
                          minorTicksPerInterval: 1,
                          onChanged: (dynamic value) {
                            _filterBloc.add(ChangeRange(values: value));
                          },
                          activeColor: AppColors.primary,
                          inactiveColor: AppColors.primary.withValues(alpha: 0.2),
                        ),
                      ),
                      SizedBox(height: 10),

                      _buildFilterSection(
                        context,
                        AppStrings.lab,
                        _filterBloc.labList,
                        _filterBloc.selectedLabs,
                        FilterType.lab,
                      ),
                      _buildFilterSection(
                        context,
                        AppStrings.shape,
                        _filterBloc.shapeList,
                        _filterBloc.selectedShapes,
                        FilterType.shape,
                      ),
                      _buildFilterSection(
                        context,
                        AppStrings.color,
                        _filterBloc.colorList,
                        _filterBloc.selectedColors,
                        FilterType.color,
                      ),
                      _buildFilterSection(
                        context,
                        AppStrings.clarity,
                        _filterBloc.clarityList,
                        _filterBloc.selectedClarities,
                        FilterType.clarity,
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
            InkWell(
              onTap: () {
                // diamondBloc.add(SubmitSortDiamonds());
                Navigator.pop(context,{
                'rangeValues': _filterBloc.rangeValues,
                'selectedLabs': _filterBloc.selectedLabs,
                'selectedShapes': _filterBloc.selectedShapes,
                'selectedColors': _filterBloc.selectedColors,
                'selectedClarities': _filterBloc.selectedClarities,
                });
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
                  AppStrings.search,
                  style: TextStyle().text500Weight(
                    textColor: AppColors.white,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(
    BuildContext context,
    String title,
    List<String> items,
    Set<String> selectedItems,
    FilterType filterType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle().text500Weight(fontSize: 18.sp)),
        SizedBox(height: 5),
        Wrap(
          children:
              items.map((item) {
                bool isSelected = selectedItems.contains(item);
                return GestureDetector(
                  onTap: () {
                    _filterBloc.add(
                      ToggleSelection(value: item, filterType: filterType),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? AppColors.primary
                              : AppColors.grey.withValues(alpha: .2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item,
                      style: TextStyle().text400Weight(
                        fontSize: 13.sp,
                        textColor:
                            isSelected ? AppColors.white : AppColors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
