
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ImageAsset extends StatelessWidget {
  final double? height, width;
  final String image;
  final BoxFit? fit;
  final Color? color;

  const ImageAsset({
    super.key,
    required this.image,
    this.fit,
    this.height,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      height: height,
      width: width,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}
