import 'package:diamond_app/data/models/diamond_model.dart';
import 'package:flutter/material.dart';

import '../modules/cart/cart_screen.dart';
import '../modules/filter/filter_screen.dart';
import '../modules/home/result/result_screen.dart';


class AppRoutes {
  static const String resultScreen = '/resultScreen';
  static const String cartScreen = '/cartScreen';
  static const String filterScreen = '/filterScreen';
}

class RouteGenerator {
  Route<dynamic> getRoute(RouteSettings routeSettings) {
    var args = routeSettings.arguments;
    switch (routeSettings.name) {
      case AppRoutes.resultScreen:
        return MaterialPageRoute(builder: (_) => ResultScreen());
      case AppRoutes.cartScreen:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case AppRoutes.filterScreen:
        return MaterialPageRoute(builder: (_) => FilterScreen());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(

          ),
    );
  }
}
