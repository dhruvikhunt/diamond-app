import 'package:diamond_app/presentation/modules/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/filter/bloc/filter_bloc.dart';
import '../modules/home/bloc/diamond_bloc.dart';



class AppBlocProviders {
  static List<BlocProvider> get providers => [
    BlocProvider(create: (context) => DiamondBloc()),
    BlocProvider(create: (context) => CartBloc()),
    BlocProvider(create: (context) => FilterBloc()),
  ];
}
