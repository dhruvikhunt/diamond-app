import 'package:diamond_app/data/models/diamond_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../domain/local_data_source.dart';
import '../../../../utils/app_enum.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    on<LoadFilterData>(_loadFilterData);
    on<ToggleSelection>(_toggleSelection);
    on<ChangeRange>(_changeRange);
  }

  SfRangeValues rangeValues = SfRangeValues(0, 0);
  double maxValue = 1;

  List<String> labList = [];
  List<String> shapeList = [];
  List<String> colorList = [];
  List<String> clarityList = [];

  Set<String> selectedLabs = {};
  Set<String> selectedShapes = {};
  Set<String> selectedColors = {};
  Set<String> selectedClarities = {};
  List<DiamondModel> diamondList = [];
  LocalDataSource dataSource = LocalDataSourceImplementer();

  _loadFilterData(LoadFilterData event, Emitter<FilterState> emit) async {
    List<DiamondModel> diamondItems = await dataSource.loadDiamondData();
    if (diamondItems.isNotEmpty) {
      diamondList = diamondItems;


      maxValue = diamondList
          .map((d) => d.carat ?? 0)
          .reduce((a, b) => a > b ? a : b);
      rangeValues = SfRangeValues(
        diamondList.map((d) => d.carat ?? 0).reduce((a, b) => a < b ? a : b),
        diamondList.map((d) => d.carat ?? 0).reduce((a, b) => a > b ? a : b),
      );
      labList =
          diamondList
              .map((e) => e.lab ?? '') // Extract lab values
              .toSet() // Remove duplicates
              .toList();
      shapeList =
          diamondList
              .map((e) => e.shape ?? '') // Extract lab values
              .toSet() // Remove duplicates
              .toList();
      colorList =
          diamondList
              .map((e) => e.color ?? '') // Extract lab values
              .toSet() // Remove duplicates
              .toList();
      clarityList =
          diamondList
              .map((e) => e.clarity ?? '') // Extract lab values
              .toSet() // Remove duplicates
              .toList();
      emit(FilterChange());
    }
  }

  _toggleSelection(ToggleSelection event, Emitter<FilterState> emit) {
    switch (event.filterType) {
      case FilterType.lab:
        _toggleItem(selectedLabs, event.value);
        break;
      case FilterType.shape:
        _toggleItem(selectedShapes, event.value);
        break;
      case FilterType.color:
        _toggleItem(selectedColors, event.value);
        break;
      case FilterType.clarity:
        _toggleItem(selectedClarities, event.value);
        break;
    }
    emit(FilterChange());
  }

  void _toggleItem(Set<String> set, String value) {
    if (set.contains(value)) {
      set.remove(value);
    } else {
      set.add(value);
    }
  }

  _changeRange(ChangeRange event, Emitter<FilterState> emit) {
    rangeValues = event.values;

    emit(FilterChange());
  }
}
