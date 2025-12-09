import '../models/programs_model.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/app_export.dart';

// ignore: must_be_immutable
class ProgramsItemWidget extends StatelessWidget {
  ProgramsItemWidget(
    this.programsItemModel, {
    Key? key,
    this.onTapProgramItem,
  }) : super(
          key: key,
        );

  ProgramsItemModel programsItemModel;

  VoidCallback? onTapProgramItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 141.h,
      child: GestureDetector(
        onTap: () {
          onTapProgramItem!.call();
        },
        child: Container(
          padding: EdgeInsets.all(15.h),
          decoration: AppDecoration.outlineBlue.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder5,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: programsItemModel.image,
                height: 109.adaptSize,
                width: 141.adaptSize,
                radius: BorderRadius.circular(
                  5.h,
                ),
              ),
              SizedBox(height: 10.v),
              SizedBox(
                width: 105.h,
                child: Text(
                  programsItemModel.programRef!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  //style: theme.textTheme.labelSmall!.copyWith(height: 1.50),
                  style: theme.textTheme.labelSmall!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
