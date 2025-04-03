import '../../../../data/models/diamond_model.dart';

abstract class DiamondState {}

final class DiamondInitial extends DiamondState {}

final class SortChange extends DiamondState {
}
final class DiamondSuccess extends DiamondState {
  final List<DiamondModel> diamonds;

  DiamondSuccess({required this.diamonds});
}
