part of 'filter_bloc.dart';

abstract class FilterState {}

final class FilterInitial extends FilterState {}
final class FilterChange extends FilterState {}
final class RangChange extends FilterState {
  final double minCarat;
  final double maxCarat;

  RangChange({required this.minCarat, required this.maxCarat});
}
