import 'package:flutter/material.dart';
import 'package:rotary/core/app_export.dart';
import 'package:rotary/widgets/custom_search_view.dart';

// ignore: must_be_immutable
class AppbarTitleSearchviewTwo extends StatelessWidget {
  AppbarTitleSearchviewTwo({
    Key? key,
    this.hintText,
    this.controller,
    this.margin,
  }) : super(
          key: key,
        );

  String? hintText;

  TextEditingController? controller;

  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CustomSearchView(
        width: 263.h,
        controller: controller,
        hintText: "Search".tr,
      ),
    );
  }
}
