import 'package:rotary/presentation/member_edit_screen/bloc/member_edit_bloc.dart';
import 'package:rotary/presentation/member_edit_screen/bloc/member_edit_event.dart';
import 'package:rotary/presentation/member_edit_screen/bloc/member_edit_state.dart';
import 'package:rotary/presentation/member_edit_screen/models/member_edit_model.dart';
import 'package:rotary/presentation/member_list_page/models/member_item_model.dart';
import 'package:rotary/core/app_export.dart';
import 'package:rotary/widgets/app_bar/appbar_title.dart';
import 'package:rotary/widgets/app_bar/appbar_title_image.dart';
import 'package:rotary/widgets/app_bar/custom_app_bar.dart';
import 'package:rotary/widgets/custom_elevated_button.dart';
import 'package:rotary/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class MemberEditScreen extends StatelessWidget {
  MemberEditScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<MemberEditBloc>(
        create: (context) => MemberEditBloc(
            MemberEditState(memberEditModelObj: MemberEditModel()))
          ..add(GetItemMemberDetail(PrefUtils().getLocation())),
        child: MemberEditScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: _formKey,
                        child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.h, vertical: 27.v),
                            child: Column(children: [
                              _buildScheduleName(context),
                              SizedBox(height: 24.v),
                              _buildScheduleLocation(context),
                              SizedBox(height: 24.v),
                              _buildScheduleClub(context),
                              SizedBox(height: 24.v),
                              _builScheduleStart(context),
                              SizedBox(height: 24.v),
                              _builScheduleEnd(context),
                              SizedBox(height: 5.v)
                            ]))))),
            bottomNavigationBar: _buildUpdateButton(context)));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 70.v,
        centerTitle: true,
        title: Column(children: [
          Padding(
              padding: EdgeInsets.only(left: 20.h, right: 5.h),
              child: Row(children: [
                AppbarTitleImage(
                  imagePath: ImageConstant.imgArrowLeft,
                  margin: EdgeInsets.only(right: 5.h),
                  onTap: () {
                    _onTapBack(context);
                  },
                ),
                AppbarTitle(
                    text: "Edit Member",
                    margin: EdgeInsets.only(left: 16.h))
              ])),
        ]));
  }

  /// Section Widget
  Widget _buildScheduleName(BuildContext context) {
    return BlocSelector<MemberEditBloc, MemberEditState,
            TextEditingController?>(
        selector: (state) => state.nameController,
        builder: (context, memberNameController) {
          return CustomTextFormField(
              controller: memberNameController,
              hintText: "Member Name");
        });
  }

  /// Section Widget
  Widget _buildScheduleLocation(BuildContext context) {
    return BlocSelector<MemberEditBloc, MemberEditState,
            TextEditingController?>(
        selector: (state) => state.addressController,
        builder: (context, memberAddressController) {
          return CustomTextFormField(
              maxLines: 3,
              controller: memberAddressController,
              hintText: "Member Address");
        });
  }

  /// Section Widget
  Widget _buildScheduleClub(BuildContext context) {
    return BlocSelector<MemberEditBloc, MemberEditState,
            TextEditingController?>(
        selector: (state) => state.icController,
        builder: (context, memberIcController) {
          return CustomTextFormField(
              controller: memberIcController,
              hintText: "Member IC");
        });
  }

  /// Section Widget
  Widget _builScheduleStart(BuildContext context) {
    return BlocSelector<MemberEditBloc, MemberEditState,
            TextEditingController?>(
        selector: (state) => state.emailController,
        builder: (context, memberEmailController) {
          return CustomTextFormField(
              controller: memberEmailController,
              hintText: "Email");
        });
  }

  /// Section Widget
  Widget _builScheduleEnd(BuildContext context) {
    return BlocSelector<MemberEditBloc, MemberEditState,
            TextEditingController?>(
        selector: (state) => state.phoneController,
        builder: (context, memberPhoneController) {
          return CustomTextFormField(
              controller: memberPhoneController,
              hintText: "Phone");
        });
  }

  /// Section Widget
  Widget _buildUpdateButton(BuildContext context) {
  return CustomElevatedButton(
    text: "Update",
    margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 49.v),
    onPressed: () {
      var state = context.read<MemberEditBloc>().state;
      context.read<MemberEditBloc>().add(ToUpdateMemberEvent(
        itemToUpdate: MemberItemModel(
          id: state.memberItemModelObj!.id,
          memberName: state.nameController!.text,
          memberAddress: state.addressController!.text,
          memberIC: state.icController!.text,
          memberEmail: state.emailController!.text,
          memberPhone: state.phoneController!.text,
        )
      ));
      NavigatorService.popAndPushNamed(
        AppRoutes.dashboardContainerScreen);
    }
  );
}

  _onTapBack(BuildContext context) {
    NavigatorService.goBack();
  }
}
