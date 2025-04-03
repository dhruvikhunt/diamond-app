import 'dart:async';

import 'package:diamond_app/data/models/diamond_model.dart';
import 'package:diamond_app/utils/app_enum.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/local_data_source.dart';
import 'diamond_event.dart';
import 'diamond_state.dart';

class DiamondBloc extends Bloc<DiamondEvent, DiamondState> {
  List<DiamondModel> diamondList = [];
  List<DiamondModel> mainDiamondList = [];
  LocalDataSource dataSource = LocalDataSourceImplementer();

  int? caratSelected;

  int? priceSelected;

  SortType? sortType;

  DiamondBloc() : super(DiamondInitial()) {
    on<LoadDiamonds>(_loadDiamonds);
    on<AddToCart>(_addToCart);

    on<FilterDiamonds>(_filterDiamonds);

    on<SortDiamonds>(_sortDiamonds);
    on<SubmitSortDiamonds>(_submitSortDiamonds);
  }

  Future<void> _loadDiamonds(
    LoadDiamonds event,
    Emitter<DiamondState> emit,
  ) async {
    await loadExcelFromAssets();
    emit(DiamondSuccess(diamonds: diamondList));
  }

  Future<void> loadExcelFromAssets() async {
    List<DiamondModel> diamondItems = await dataSource.loadDiamondData();
    if (diamondItems.isNotEmpty) {
      mainDiamondList = diamondItems;
      diamondList = mainDiamondList;
    } else {
      try {
        ByteData data = await rootBundle.load('assets/dataset.xlsx');
        List<int> bytes = data.buffer.asUint8List();
        var excel = Excel.decodeBytes(bytes);

        List<DiamondModel> tempData = [];

        // Read first sheet
        for (var table in excel.tables.keys) {
          for (int row = 1; row < excel.tables[table]!.rows.length; row++) {
            var rowData = excel.tables[table]!.rows[row];

            if (rowData.isNotEmpty) {
              List<String> values =
                  rowData.map((cell) => cell?.value.toString() ?? "").toList();

              if (values.length >= 15) {
                // Ensure minimum required fields exist
                DiamondModel diamond = DiamondModel(
                  qty: int.tryParse(values[0]) ?? 0,
                  lotId: int.tryParse(values[1]) ?? 0,
                  size: values[2],
                  carat: double.tryParse(values[3]) ?? 0.0,
                  lab: values[4],
                  shape: values[5],
                  color: values[6],
                  clarity: values[7],
                  cut: values[8],
                  polish: values[9],
                  symmetry: values[10],
                  fluorescence: values[11],
                  discount: double.tryParse(values[12]) ?? 0.0,
                  perCaratRate: double.tryParse(values[13]) ?? 0.0,
                  finalAmount: double.tryParse(values[14]) ?? 0.0,
                  keyToSymbol:
                      values[15] == 'null' || values[15] == ''
                          ? ''
                          : values[15],
                  labComment:
                      values[16] == 'null' || values[16] == ''
                          ? ''
                          : values[16],
                  inCart: false,
                );

                tempData.add(diamond);
              }
            }
          }
          break; // Read only first sheet
        }

        diamondList = tempData;
        dataSource.saveDiamondData(response: diamondList);
      } catch (e) {
        diamondList = [];
      }
    }
  }

  _addToCart(AddToCart event, Emitter<DiamondState> emit) {
    diamondList.map((e) {
      if (e.lotId == event.lotId) {
        e.inCart = !e.inCart;
      }
    }).toList();
    dataSource.saveDiamondData(response: diamondList);
    emit(DiamondSuccess(diamonds: diamondList));
  }

  _filterDiamonds(FilterDiamonds event, Emitter<DiamondState> emit) {
    List<DiamondModel> filteredDiamonds =
    mainDiamondList.where((diamond) {
          // Check Carat Range
          bool inCaratRange =
              (diamond.carat ?? 0) >= event.rangeValues.start &&
              (diamond.carat ?? 0) <= event.rangeValues.end;

          // Check Lab Filter
          bool matchesLab =
              event.selectedLabs.isEmpty ||
              event.selectedLabs.contains(diamond.lab);

          // Check Shape Filter
          bool matchesShape =
              event.selectedShapes.isEmpty ||
              event.selectedShapes.contains(diamond.shape);

          // Check Color Filter
          bool matchesColor =
              event.selectedColors.isEmpty ||
              event.selectedColors.contains(diamond.color);

          // Check Clarity Filter
          bool matchesClarity =
              event.selectedClarities.isEmpty ||
              event.selectedClarities.contains(diamond.clarity);

          return inCaratRange &&
              matchesLab &&
              matchesShape &&
              matchesColor &&
              matchesClarity;
        }).toList();

    diamondList = filteredDiamonds;

    emit(DiamondSuccess(diamonds: diamondList));
  }

  _sortDiamonds(SortDiamonds event, Emitter<DiamondState> emit) {
    // List<DiamondModel> sortedDiamonds = List.from(diamondList);
    sortType = event.sortBy;
    if (event.sortBy == SortType.byPrice) {
      priceSelected = event.value;
    } else if (event.sortBy == SortType.byCarat) {
      caratSelected = event.value;
    }
    emit(SortChange());
  }

  _submitSortDiamonds(SubmitSortDiamonds event, Emitter<DiamondState> emit) {
    if (sortType == SortType.byPrice) {
      diamondList.sort(
        (a, b) =>
            priceSelected == 1
                ? a.finalAmount!.compareTo(b.finalAmount!)
                : b.finalAmount!.compareTo(a.finalAmount!),
      );
    } else if (sortType == SortType.byCarat) {
      diamondList.sort(
        (a, b) =>
            caratSelected == 1
                ? a.carat!.compareTo(b.carat!)
                : b.carat!.compareTo(a.carat!),
      );
    }
    emit(DiamondSuccess(diamonds: diamondList));
  }
}
