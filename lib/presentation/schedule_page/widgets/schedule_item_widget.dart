import 'package:rotary/core/app_export.dart';
import 'package:rotary/presentation/schedule_page/bloc/schedule_bloc.dart';
import 'package:rotary/widgets/custom_elevated_button.dart';
import '../models/schedule_item_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ScheduleItemWidget extends StatelessWidget {
  ScheduleItemWidget(
    this.scheduleItemModelObj, {
    Key? key,
    this.onTapScheduleDetailButton,
  }) : super(
          key: key,
        );

  ScheduleItemModel scheduleItemModelObj;

  VoidCallback? onTapScheduleDetailButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.h, top: 15.v, bottom: 15.v),
      decoration: AppDecoration.outlineBlue50.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImagePath(context, scheduleItemModelObj.eventClub),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.v),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200.v, 
                        height: 25.h,
                        child: Text(
                        scheduleItemModelObj.eventName!,
                        style: CustomTextStyles.titleMedium_1,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      ),
                      SizedBox(
                        width: 200.v,
                        height: 35.h,
                        child: Text(
                          scheduleItemModelObj.eventLocation!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30.adaptSize,
                  child: PopupMenuButton<int>(
                    surfaceTintColor: appTheme.whiteA700,
                    padding: EdgeInsets.all(1),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Text("Edit"),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text("Delete"),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 1) {
                        PrefUtils().setLocation('locationData', scheduleItemModelObj.id!);
                        onTapEditForm(context);
                      } else if (value == 2) {
                        context.read<ScheduleBloc>().add(DeleteScheduleItemEvent(scheduleItemModelObj.id!));
                      }
                    },
                    icon: Icon(Icons.more_vert), // replace with your icon
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15.v),
          Padding(
            padding: EdgeInsets.only(right: 45.h),
            child: Row(
              children: [
                CustomImageView(
                  color: theme.colorScheme.primary,
                  imagePath: ImageConstant.imgNavEvent,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.h),
                  child: Text(
                    DateFormat('dd/MM/yyyy')
                        .format(scheduleItemModelObj.eventStart!),
                    style: CustomTextStyles.labelLargeOnPrimary,
                  ),
                ),
                CustomImageView(
                  color: theme.colorScheme.primary,
                  imagePath: ImageConstant.imgClock,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(left: 15.h),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.h),
                  child: Text(
                    DateFormat('hh:mm a')
                        .format(scheduleItemModelObj.eventEnd!.toLocal()),
                    style: CustomTextStyles.labelLargeOnPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.v),
          CustomElevatedButton(
            margin: EdgeInsets.only(right: 15.v),
            height: 35.v,
            text: "Location",
            onPressed: () {
              onTapScheduleDetailButton!.call();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImagePath(BuildContext context, String? eventImage) {
    if (eventImage == "Rotary") {
      return CustomImageView(
        imagePath: 'assets/images/rotary.png',
        height: 46.adaptSize,
        width: 46.adaptSize,
        radius: BorderRadius.circular(
          23.h,
        ),
      );
    } else {
      return CustomImageView(
        imagePath: 'assets/images/rotaract.png',
        height: 46.adaptSize,
        width: 46.adaptSize,
        radius: BorderRadius.circular(
          23.h,
        ),
      );
    }
  }
  
  void onTapEditForm(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.appScheduleEditForm);
  }
}
