import 'package:flutter/material.dart';
import 'package:rotary/core/app_export.dart';
import 'package:rotary/widgets/custom_icon_button_one.dart';

// ignore: must_be_immutable
class AppbarLeadingIconbuttonOne extends StatelessWidget {
  AppbarLeadingIconbuttonOne({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomIconButtonOne(
          height: 50.adaptSize,
          width: 50.adaptSize,
          decoration: IconButtonStyleHelperOne.fillWhiteA,
          child: CustomImageView(
            margin: margin,
            fit: BoxFit.cover,
            imagePath: imagePath,
          ),
        ),
      ),
    );
  }
}
