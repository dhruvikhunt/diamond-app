part of 'cart_bloc.dart';

abstract class CartState {}

final class CartInitial extends CartState {}

final class CartSuccess extends CartState {
  final List<DiamondModel> cart;

  CartSuccess({required this.cart});
}
