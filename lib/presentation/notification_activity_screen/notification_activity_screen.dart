import 'package:url_launcher/url_launcher.dart';

import 'bloc/notification_activity_bloc.dart';
import 'models/notification_activity_model.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/app_export.dart';
import 'package:rotary/widgets/app_bar/custom_app_bar.dart';

class NotificationActivityPage extends StatelessWidget {
  const NotificationActivityPage({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<NotificationActivityBloc>(
        create: (context) => NotificationActivityBloc(NotificationActivityState(
            notificationActivityModelObj: NotificationActivityModel()))
          ..add(NotificationActivityInitialEvent()),
        child: NotificationActivityPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationActivityBloc, NotificationActivityState>(
        builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              appBar: _buildAppBar(context),
              body: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 11.v),
                  child: Column(children: [
                    _buildActivityDetails(context,
                        transactionTitle: "New center will train regional peacebuilders through a one-year Rotary Peace Fellowship".tr,
                        transactionDescription:
                            "ISTANBUL, Turkey (8 February 2024) – Rotary International and Bahçeşehir University (BAU) announce a partnership agreement to establish the Otto and Fran Walter Rotary Peace Center, offering a professional development certificate program for peace and development professionals in the Middle East and North Africa (MENA) region.  The center is located at the university’s Future Campus outside of Istanbul, Turkey".tr,
                        transactionTime: "msg_april_30_2014_1_01".tr,
                        onTapTransactionIcon: () {
                      onTapNotification(context, "https://www.rotary.org/en/rotary-partners-bahcesehir-university-establish-peace-center-turkey");
                    }),
                    _buildActivityDetails(context,
                        transactionTitle: "Minneapolis-St. Paul set to host Rotary’s 120th international convention in 2029".tr,
                        transactionDescription:
                            "EVANSTON, Ill. (Feb. 5, 2024) — Rotary International today announced Minneapolis-St. Paul as the winner of the provisional bid to hold its annual international convention at the Minneapolis Convention Center, May 26-30, 2029".tr,
                        transactionTime: "msg_april_30_2014_1_01".tr,
                        onTapTransactionIcon:(){
                          onTapNotification(context, "https://www.rotary.org/en/minneapolis-st-paul-set-to-host-rotarys-120th-international-convention-in-2029");
                        }),
                    SizedBox(height: 5.v),
                    _buildActivityDetails(context,
                        transactionTitle: "At convention, inspiration around every corner".tr,
                        transactionDescription:
                            "It’s a tale as old as the Rotary International Convention: Two members from different clubs bump into each other, start chatting, and get the spark of an idea for a project. So don’t be shy about starting a conversation with the stranger standing next to you or someone you meet over a meal at the convention 25-29 May in Singapore. After all, two people who talked at a bus stop at the 2016 convention in Seoul went on to plan a project fair in Africa.".tr,
                        transactionTime: "msg_april_30_2014_1_01".tr,
                        onTapTransactionIcon: (){
                          onTapNotification(context, "https://www.rotary.org/en/convention-inspiration-around-every-corner");
                        })
                  ]))));
    });
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        //leadingWidth: 40.h,
        height: 70.v,
        title: Container(
          padding: EdgeInsets.all(20.h),
          child: Text(
            "Notifications",
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.onPrimary.withOpacity(1),
            ),
          )),
    );
  }

  /// Common widget
  Widget _buildActivityDetails(
    BuildContext context, {
    required String transactionTitle,
    required String transactionDescription,
    required String transactionTime,
    Function? onTapTransactionIcon,
  }) {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(16.h),
        decoration: AppDecoration.fillOnPrimaryContainer,
        child: GestureDetector(
          onTap: () {
                    onTapTransactionIcon!.call();
                  },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                color: theme.colorScheme.primary,
                  imagePath: ImageConstant.imgEmailIcon,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  margin: EdgeInsets.only(bottom: 94.v),
                  ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 12.h),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(transactionTitle,
                                style: theme.textTheme.titleSmall!.copyWith(
                                    color: theme.colorScheme.onPrimary
                                        .withOpacity(1))),
                            SizedBox(height: 11.v),
                            SizedBox(
                                width: 305.h,
                                child: Text(transactionDescription,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        color: appTheme.blueGray300,
                                        height: 1.80))),
                            SizedBox(height: 5.v),
                            Text(transactionTime,
                                style: CustomTextStyles.bodySmallOnPrimary10
                                    .copyWith(
                                        color: theme.colorScheme.onPrimary
                                            .withOpacity(1)))
                          ])))
            ]),
        )
            );
  }

  /// Navigates to the previous screen.
  onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }

  Future<void> onTapNotification(BuildContext context, String? newsUrl) async {
    print(newsUrl);
    if (newsUrl != null) {
      final Uri _url = Uri.parse(newsUrl);
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }
  }
}
