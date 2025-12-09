import 'package:flutter/material.dart';
import 'package:rotary/core/app_export.dart';
import 'package:rotary/widgets/custom_search_view_one.dart';

// ignore: must_be_immutable
class AppbarTitleSearchviewOne extends StatelessWidget {
  AppbarTitleSearchviewOne({
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
      child: CustomSearchViewOne(
        hintText: "Search",
        onTap: () {
          onTapSearchItems(context);
        },
      ),
    );
  }
  
  onTapSearchItems(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.searchScreen);
  }
}
