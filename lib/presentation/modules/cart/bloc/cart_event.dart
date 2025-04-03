part of 'cart_bloc.dart';

abstract class CartEvent {}

class LoadCart extends CartEvent {}

class RemoveFromCart extends CartEvent {
  final int lotId;
  RemoveFromCart({required this.lotId});
}