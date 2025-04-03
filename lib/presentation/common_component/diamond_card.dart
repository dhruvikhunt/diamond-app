import 'package:diamond_app/data/models/diamond_model.dart';
import 'package:diamond_app/presentation/common_component/image_assets.dart';
import 'package:diamond_app/presentation/constants/app_assets.dart';
import 'package:diamond_app/presentation/constants/app_box_decoration.dart';
import 'package:diamond_app/presentation/constants/app_font_style.dart';
import 'package:flutter/material.dart';

class DiamondCard extends StatelessWidget {
  final DiamondModel diamond;
  final void Function() onTap;

  const DiamondCard({super.key, required this.diamond, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration().borderDecoration(),
      margin: EdgeInsets.only(bottom: 12, right: 15, left: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lot ID: ${diamond.lotId} - Carat: ${diamond.carat}",
                    style: TextStyle().text500Weight(),
                  ),
                  Text(
                    "Final Price: ${diamond.totalAmount.toStringAsFixed(2)}",
                    style: TextStyle().text500Weight(),
                  ),
                  Text(
                    "Lab: ${diamond.lab}",
                    style: TextStyle().text500Weight(),
                  ),

                Text(
                    "Shape: ${diamond.shape}",
                    style: TextStyle().text500Weight(),
                  ),
                Text(
                    "Color: ${diamond.color}",
                    style: TextStyle().text500Weight(),
                  ),
                Text(
                    "Clarity: ${diamond.clarity}",
                    style: TextStyle().text500Weight(),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: (){
                onTap();
              },
              child: ImageAsset(
                image:
                    diamond.inCart ? AppAssets.addToCart : AppAssets.removeToCart,
              ),
            ),
            /* ListTile(
              title: Text("Lot ID: ${diamond.lotId} - Carat: ${diamond.carat}"),
              subtitle: Text(
                "Final Price: \$${diamond.totalAmount.toStringAsFixed(2)}",
              ),
              trailing: IconButton(
                icon: Icon(
                  diamond.inCart ? Icons.remove_shopping_cart : Icons.add_shopping_cart,
                ),
                onPressed: onTap,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
