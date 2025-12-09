import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomIconButtonOne extends StatelessWidget {
  CustomIconButtonOne({
    Key? key,
    this.alignment,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  color: appTheme.gray100,
                  borderRadius: BorderRadius.circular(25.h),
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}

/// Extension on [CustomIconButton] to facilitate inclusion of all types of border style etc
extension IconButtonStyleHelperOne on CustomIconButtonOne {
  static BoxDecoration get fillOrange => BoxDecoration(
        color: appTheme.orange300.withOpacity(0.5),
        borderRadius: BorderRadius.circular(17.h),
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.8),
        borderRadius: BorderRadius.circular(25.h),
      );

  static BoxDecoration get fillWhiteB => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.9),
        borderRadius: BorderRadius.circular(25.h),
      );
  static BoxDecoration get fillRedA => BoxDecoration(
        color: appTheme.redA200,
        borderRadius: BorderRadius.circular(12.h),
      );
  static BoxDecoration get fillBlueGrayAf => BoxDecoration(
        color: appTheme.blueGray700Af,
        borderRadius: BorderRadius.circular(8.h),
      );
  static BoxDecoration get fillWhiteATL12 => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12.h),
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(25.h),
      );
  static BoxDecoration get fillWhiteATL121 => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.78),
        borderRadius: BorderRadius.circular(12.h),
      );
  static BoxDecoration get fillWhiteATL122 => BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(12.h),
      );
  static BoxDecoration get fillGreenA => BoxDecoration(
        color: appTheme.greenA400,
        borderRadius: BorderRadius.circular(17.h),
      );
  static BoxDecoration get fillGreenATL12 => BoxDecoration(
        color: appTheme.greenA400,
        borderRadius: BorderRadius.circular(12.h),
      );
  static BoxDecoration get fillGreenATL35 => BoxDecoration(
        color: appTheme.greenA400,
        borderRadius: BorderRadius.circular(35.h),
      );
  static BoxDecoration get fillRedATL15 => BoxDecoration(
        color: appTheme.redA200,
        borderRadius: BorderRadius.circular(15.h),
      );
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray80001,
        borderRadius: BorderRadius.circular(25.h),
      );
  static BoxDecoration get fillWhiteATL25 => BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(25.h),
      );
  static BoxDecoration get fillBlueGrayTL15 => BoxDecoration(
        color: appTheme.blueGray80001,
        borderRadius: BorderRadius.circular(15.h),
      );
  static BoxDecoration get fillPrimaryTL20 => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(20.h),
      );
  static BoxDecoration get fillBlueGrayTL12 => BoxDecoration(
        color: appTheme.blueGray80001,
        borderRadius: BorderRadius.circular(12.h),
      );
  static BoxDecoration get fillPrimaryTL35 => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(35.h),
      );
  static BoxDecoration get fillRedATL25 => BoxDecoration(
        color: appTheme.redA200,
        borderRadius: BorderRadius.circular(25.h),
      );
  static BoxDecoration get fillBlueGrayTL17 => BoxDecoration(
        color: appTheme.blueGray50,
        borderRadius: BorderRadius.circular(17.h),
      );
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        color: appTheme.blueGray50,
        borderRadius: BorderRadius.circular(25.h),
        border: Border.all(
          color: appTheme.blueGray50,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGray => BoxDecoration(
        color: appTheme.gray100,
        borderRadius: BorderRadius.circular(25.h),
        border: Border.all(
          color: appTheme.gray100,
          width: 1.h,
        ),
      );
  static BoxDecoration get fillWhiteATL251 => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.5),
        borderRadius: BorderRadius.circular(25.h),
      );
}
