import 'package:rotary/presentation/schedule_edit_screen/bloc/schedule_edit_bloc.dart';
import 'package:rotary/presentation/schedule_edit_screen/bloc/schedule_edit_event.dart';
import 'package:rotary/presentation/schedule_edit_screen/bloc/schedule_edit_state.dart';
import 'package:rotary/presentation/schedule_edit_screen/models/schedule_edit_model.dart';
import 'package:rotary/core/app_export.dart';
import 'package:rotary/presentation/schedule_page/bloc/schedule_bloc.dart';
import 'package:rotary/presentation/schedule_page/models/schedule_item_model.dart';
import 'package:rotary/widgets/app_bar/appbar_title.dart';
import 'package:rotary/widgets/app_bar/appbar_title_image.dart';
import 'package:rotary/widgets/app_bar/custom_app_bar.dart';
import 'package:rotary/widgets/custom_elevated_button.dart';
import 'package:rotary/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ScheduleEditScreen extends StatelessWidget {
  ScheduleEditScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<ScheduleEditBloc>(
        create: (context) => ScheduleEditBloc(
            ScheduleEditState(scheduleEditModelObj: ScheduleEditModel()))
          ..add(GetItemScheduleDetail(PrefUtils().getLocation())),
        child: ScheduleEditScreen());
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
                    text: "Edit Schedule",
                    margin: EdgeInsets.only(left: 16.h))
              ])),
        ]));
  }

  /// Section Widget
  Widget _buildScheduleName(BuildContext context) {
    return BlocSelector<ScheduleEditBloc, ScheduleEditState,
            TextEditingController?>(
        selector: (state) => state.label1Controller,
        builder: (context, scheduleNameController) {
          return CustomTextFormField(
              controller: scheduleNameController,
              hintText: "Event Name");
        });
  }

  /// Section Widget
  Widget _buildScheduleLocation(BuildContext context) {
    return BlocSelector<ScheduleEditBloc, ScheduleEditState,
            TextEditingController?>(
        selector: (state) => state.label2Controller,
        builder: (context, schedulLocationController) {
          return CustomTextFormField(
              maxLines: 3,
              controller: schedulLocationController,
              hintText: "Event Location");
        });
  }

  /// Section Widget
  Widget _buildScheduleClub(BuildContext context) {
    return BlocSelector<ScheduleEditBloc, ScheduleEditState,
            TextEditingController?>(
        selector: (state) => state.clubController,
        builder: (context, scheduleClubController) {
          return CustomTextFormField(
              readOnly: true,
              controller: scheduleClubController,
              hintText: "Event Club");
        });
  }

  /// Section Widget
  Widget _builScheduleStart(BuildContext context) {
    return BlocSelector<ScheduleEditBloc, ScheduleEditState,
            TextEditingController?>(
        selector: (state) => state.startController,
        builder: (context, scheduleStartController) {
          return CustomTextFormField(
              readOnly: true,
              controller: scheduleStartController,
              hintText: "Event Start");
        });
  }

  /// Section Widget
  Widget _builScheduleEnd(BuildContext context) {
    return BlocSelector<ScheduleEditBloc, ScheduleEditState,
            TextEditingController?>(
        selector: (state) => state.endController,
        builder: (context, schedulEndController) {
          return CustomTextFormField(
              readOnly: true,
              controller: schedulEndController,
              hintText: "Event End");
        });
  }

  /// Section Widget
  Widget _buildUpdateButton(BuildContext context) {
  return CustomElevatedButton(
    text: "Update",
    margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 49.v),
    onPressed: () {
      var state = context.read<ScheduleEditBloc>().state;
      context.read<ScheduleEditBloc>().add(ToUpdateScheduleEvent(
        itemToUpdate: ScheduleItemModel(
          id: state.scheduleItemModelObj!.id,
          eventName: state.label1Controller!.text,
          eventLocation: state.label2Controller!.text,
          eventClub: state.clubController!.text,
          eventStart: state.scheduleItemModelObj!.eventStart,
          eventEnd: state.scheduleItemModelObj!.eventEnd,
        )
      ));
      BlocProvider.of<ScheduleBloc>(context).add(ScheduleInitialEvent());
      //NavigatorService.goBack();
      NavigatorService.popAndPushNamed(
        AppRoutes.dashboardContainerScreen);
    }
  );
}

  _onTapBack(BuildContext context) {
    NavigatorService.goBack();
  }
}
