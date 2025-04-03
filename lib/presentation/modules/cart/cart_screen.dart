import 'package:diamond_app/presentation/common_component/app_bar_vew.dart';
import 'package:diamond_app/presentation/constants/app_font_style.dart';
import 'package:diamond_app/presentation/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/diamond_model.dart';
import '../../common_component/diamond_card.dart';
import '../../common_component/image_assets.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import 'bloc/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartBloc _cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: appBarView(context, title: AppStrings.cart),
      body: BlocBuilder<CartBloc, CartState>(
        bloc: _cartBloc..add(LoadCart()),
        builder: (context, state) {
          if (_cartBloc.cartItems.every((element) => element.inCart == false)) {
            return Center(
              child: Text(
                AppStrings.cartIsEmpty,
                style: TextStyle().text400Weight(
                  textColor: AppColors.black,
                  fontSize: 15.sp,
                ),
              ),
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _cartBloc.cartItems.length,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (context, index) {
                    return !_cartBloc.cartItems[index].inCart
                        ? SizedBox.shrink()
                        : DiamondCard(
                          diamond: _cartBloc.cartItems[index],
                          onTap: () {
                            _cartBloc.add(
                              RemoveFromCart(
                                lotId: _cartBloc.cartItems[index].lotId!,
                              ),
                            );
                          },
                        );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 5);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 30,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          AppStrings.totalCarat,
                          style: TextStyle().text400Weight(
                            fontSize: 15.sp,
                            textColor: AppColors.black,
                          ),
                        ),
                        Text(
                          DiamondModel.calculateTotalCarat(
                            _cartBloc.cartItems,
                          ).toStringAsFixed(2),
                          style: TextStyle().text400Weight(
                            fontSize: 15.sp,
                            textColor: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.discount,
                          style: TextStyle().text400Weight(
                            fontSize: 15.sp,
                            textColor: AppColors.black,
                          ),
                        ),
                        Text(
                          DiamondModel.calculateTotalDiscount(
                            _cartBloc.cartItems,
                          ).toStringAsFixed(2),
                          style: TextStyle().text400Weight(
                            fontSize: 15.sp,
                            textColor: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.amount,
                          style: TextStyle().text400Weight(
                            fontSize: 15.sp,
                            textColor: AppColors.black,
                          ),
                        ),
                        Text(
                          DiamondModel.calculateAmount(
                            _cartBloc.cartItems,
                          ).toStringAsFixed(2),
                          style: TextStyle().text400Weight(
                            fontSize: 15.sp,
                            textColor: AppColors.black,
                          ),
                        ),
                      ],
                    ),

                    Divider(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.totalAmount,
                          style: TextStyle().text400Weight(
                            fontSize: 15.sp,
                            textColor: AppColors.black,
                          ),
                        ),
                        Text(
                          DiamondModel.calculateTotalAmount(
                            _cartBloc.cartItems,
                          ).toStringAsFixed(2),
                          style: TextStyle().text400Weight(
                            fontSize: 15.sp,
                            textColor: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
    ;
  }
}
