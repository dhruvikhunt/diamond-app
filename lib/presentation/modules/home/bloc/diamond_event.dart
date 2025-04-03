import 'package:diamond_app/utils/app_enum.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

abstract class DiamondEvent {}

final class LoadDiamonds extends DiamondEvent {}

final class FilterDiamonds extends DiamondEvent {
  final SfRangeValues rangeValues ;
  final Set<String> selectedLabs ;
  final Set<String> selectedShapes ;
  final Set<String> selectedColors ;
  final Set<String> selectedClarities;

  FilterDiamonds({required this.rangeValues, required this.selectedLabs, required this.selectedShapes, required this.selectedColors, required this.selectedClarities});
}

final class SortDiamonds extends DiamondEvent {
  final SortType sortBy;
  final int value;

  SortDiamonds({required this.sortBy, required this.value});
}
final class SubmitSortDiamonds extends DiamondEvent {
}

final class AddToCart extends DiamondEvent {
  final int lotId;

  AddToCart({required this.lotId});
}

