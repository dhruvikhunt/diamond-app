
import 'dart:async';

import 'package:diamond_app/data/models/diamond_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/local_data_source.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  LocalDataSource dataSource = LocalDataSourceImplementer();
  List<DiamondModel> cartItems = [];
  CartBloc() : super(CartInitial()) {
    on<LoadCart>(_loadCart);
    on<RemoveFromCart>(_removeFromCart);
  }

  _loadCart(LoadCart event, Emitter<CartState> emit) async {
    cartItems = await dataSource.loadDiamondData();
    emit(CartSuccess(cart: cartItems,));
  }

  _removeFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    cartItems.map((e) {
      if(e.lotId == event.lotId){
        e.inCart = false;
      }
    },).toList();
    dataSource.saveDiamondData(response: cartItems);
    emit(CartSuccess(cart: cartItems));
  }
}
