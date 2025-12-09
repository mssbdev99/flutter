import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rotary/core/constants/shared_pref.dart';
import 'package:rotary/domain/facebookauth/facebook_auth_helper.dart';
import 'package:rotary/domain/googleauth/google_auth_helper.dart';
import 'package:rotary/widgets/custom_elevated_button.dart';
import 'bloc/profile_bloc.dart';
import 'models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/app_export.dart';
import 'package:rotary/widgets/app_bar/custom_app_bar.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  late String? myProfileName = "My Profile Name";
  late String? myProfileEmail = "profile@rotary.com";

  static Widget builder(BuildContext context) {
    return BlocProvider<ProfileBloc>(
        create: (context) =>
            ProfileBloc(ProfileState(profileModelObj: ProfileModel()))
              ..add(ProfileInitialEvent()),
        child: ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              body: Container(
                  width: double.maxFinite,
                  child: Column(children: [
                    _buildProfileAppBar(context),
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.h, vertical: 23.v),
                        child: Column(children: [
                          _buildSettingRow(context,
                              settingIcon: ImageConstant.imgEditing,
                              settingText: "Edit Profile", onTapRowSetting: () {
                            _onTapEditProfile(context);
                          }),
                          SizedBox(height: 15.v),
                          _buildSettingRow(context,
                              settingIcon: ImageConstant.imgRefresh,
                              settingText: "Refresh Data", onTapRowSetting: () {
                            _onTapRefreshDevice(context);
                          }),
                          SizedBox(height: 80.v),
                          CustomElevatedButton(
                            height: 50.v,
                            text: "Log Out",
                            onPressed: () {
                              _loggedOff(context);
                            },
                          ),
                          SizedBox(height: 5.v)
                        ]))
                  ]))));
    });
  }

  Widget _buildProfileAppBar(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state.profileModelItemObj != null) {
        print(state.profileModelItemObj!.name);

        myProfileName = state.profileModelItemObj!.name;
        myProfileEmail = state.profileModelItemObj!.email;
      }
      return Container(
          height: 240.v,
          width: double.maxFinite,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            CustomAppBar(
                height: 113.v,
                centerTitle: true,
                title: Container(
                  margin: EdgeInsets.only(top: 30.v, bottom: 54.v),
                  child: Text(
                    "My Profile",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                styleType: Style.bgFill_2),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 113.h),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(
                          height: 110.v,
                          width: 100.h,
                          child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                CustomImageView(
                                    imagePath: ImageConstant.imgProfilePicture,
                                    height: 100.adaptSize,
                                    width: 100.adaptSize,
                                    radius: BorderRadius.circular(50.h),
                                    alignment: Alignment.topCenter),
                                /*CustomIconButton(
                                    height: 30.adaptSize,
                                    width: 30.adaptSize,
                                    padding: EdgeInsets.all(7.h),
                                    decoration:
                                        IconButtonStyleHelper.fillPrimary,
                                    alignment: Alignment.bottomCenter,
                                    child: CustomImageView(
                                        color: Colors.white,
                                        imagePath: ImageConstant.imgCamera))*/
                              ])),
                      SizedBox(height: 5.v),
                      FittedBox(
                        child: Text("${myProfileName}",
                            style: theme.textTheme.titleSmall),
                      ),
                      SizedBox(height: 1.v),
                      FittedBox(
                        child: Text("${myProfileEmail}",
                            style: CustomTextStyles.bodySmall10),
                      ),
                    ])))
          ]));
    });
  }

  /// Common widget
  Widget _buildSettingRow(
    BuildContext context, {
    required String settingIcon,
    required String settingText,
    String? settingValue,
    Function? onTapRowSetting,
  }) {
    return GestureDetector(
        onTap: () {
          onTapRowSetting!.call();
        },
        child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 15.v),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Row(children: [
              CustomImageView(
                  color: theme.colorScheme.primary,
                  imagePath: settingIcon,
                  height: 24.adaptSize,
                  width: 24.adaptSize),
              Padding(
                  padding: EdgeInsets.only(left: 16.h, top: 3.v, bottom: 2.v),
                  child: Text(settingText,
                      style: theme.textTheme.labelLarge!.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(1)))),
              Spacer(),
              Padding(
                  padding: EdgeInsets.only(top: 2.v, bottom: 3.v),
                  child: Text(settingValue ?? "",
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: appTheme.blueGray300))),
              CustomImageView(
                  color: theme.colorScheme.onPrimary,
                  imagePath: ImageConstant.imgNext,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  margin: EdgeInsets.only(left: 16.h))
            ])));
  }

  /// Navigates to the previous screen.
  onTapArrowLeft(BuildContext context, String val) {
    NavigatorService.goBack();
  }

  _loggedOff(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await GoogleAuthHelper().googleSignOutProcess();
    await FacebookAuthHelper().facebookSignOutProcess();
    PrefUtils().remove(AppConstant.STORAGE_USER_TOKEN_KEY);
    NavigatorService.pushNamed(AppRoutes.loginScreen);
  }

  _onTapEditProfile(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.editProfileScreen);
  }

  _onTapRefreshDevice(BuildContext context) {
    Fluttertoast.showToast(msg: "Data has been updated");
    context.read<ProfileBloc>().add(ProfileRefreshDataEvent());
  }
}
