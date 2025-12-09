import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rotary/widgets/custom_search_view.dart';

// ignore: must_be_immutable
class AppbarTitleSearchview extends StatelessWidget {
  AppbarTitleSearchview({
    Key? key,
    this.hintText,
    this.suffix,
    this.controller,
    this.margin,
    this.onTapSearchButton,
  }) : super(
          key: key,
        );

  String? hintText;

  Widget? suffix;

  TextEditingController? controller;

  EdgeInsetsGeometry? margin;

  Function(String)? onTapSearchButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CustomSearchView(
        controller: controller,
        suffix: suffix,
        hintText: "Search",
        onChanged: (value) {
          onTapSearchButton!(value);
        },
      ),
    );
  }
}
