import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rotary/presentation/member_list_page/bloc/member_list_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/member_item_model.dart';
import 'package:rotary/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MemberListPageStateListItemWidget extends StatelessWidget {
  MemberListPageStateListItemWidget(
    this.memberItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  MemberItemModel memberItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.green,
          icon: Icons.edit,
          onTap: () {
            print(memberItemModelObj.id);
            PrefUtils().setLocation('locationData', memberItemModelObj.id!);
                        onTapEditForm(context);
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            context
                .read<MemberListBloc>()
                .add(DeleteMemberEvent(memberItemModelObj.id!));
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text("deleted member"),
            ));
          },
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14.h,
          vertical: 11.v,
        ),
        decoration: AppDecoration.outlineBlue.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50.adaptSize,
              width: 50.adaptSize,
              child: Align(
                child: Text(
                  getInitials(memberItemModelObj.memberName!),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: appTheme.whiteA700,
                      fontSize: 15),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.h,
                  ),
                  color: theme.colorScheme.primaryContainer),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.h, top: 3.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    memberItemModelObj.memberName!,
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: 6.v),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final Uri url = Uri(
                            scheme: 'mailto',
                            path: memberItemModelObj.memberEmail,
                            query:
                                'subject=App Feedback&body=App Version 3.23', //add subject and body here
                          );

                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Row(
                          children: [
                            CustomImageView(
                              color: theme.colorScheme.primary,
                              imagePath: ImageConstant.imgEmailIcon,
                              height: 10.adaptSize,
                              width: 10.adaptSize,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.h, right: 5.h),
                              child: Text(
                                memberItemModelObj.memberEmail!,
                                style: CustomTextStyles.bodySmall10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 15, // Adjust the height as needed
                        child: VerticalDivider(
                            color: theme.colorScheme.onPrimary, thickness: 1),
                      ),
                      SizedBox(width: 5.h),
                      GestureDetector(
                        onTap: () async {
                          final Uri url = Uri(
                              scheme: 'tel',
                              path: memberItemModelObj.memberPhone);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            print("cannot call");
                          }
                        },
                        child: Row(
                          children: [
                            CustomImageView(
                              color: theme.colorScheme.primary,
                              imagePath: ImageConstant.imgPhoneNo,
                              height: 10.adaptSize,
                              width: 10.adaptSize,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.h),
                              child: Text(
                                memberItemModelObj.memberPhone!,
                                style: CustomTextStyles.bodySmall10,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getInitials(String name) {
    print(name);
    List<String> names = name.split(" ");
    String initials = "";
    int counter = 0;

    for (var item in names) {
      if (item.trim().length > 0) {
        initials += '${item.trim()[0]}';
        counter++;
      }
      if (counter == 2) {
        break;
      }
    }
    return initials;
  }
  
  void onTapEditForm(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.appMemberEditForm);
  
  }
}
