part of 'filter_bloc.dart';

abstract class FilterEvent {}

final class LoadFilterData extends FilterEvent {}

final class ChangeRange extends FilterEvent {
  final SfRangeValues values;

  ChangeRange({required this.values});
}

class ToggleSelection extends FilterEvent {
  final String value;
  final FilterType filterType;

  ToggleSelection({required this.value, required this.filterType});
}
