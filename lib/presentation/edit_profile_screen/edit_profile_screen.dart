import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rotary/presentation/login_screen/models/login_item_model.dart';
import 'package:rotary/widgets/app_bar/appbar_title_image.dart';
import 'bloc/edit_profile_bloc.dart';
import 'models/edit_profile_model.dart';
import 'package:rotary/core/app_export.dart';
import 'package:rotary/core/utils/validation_functions.dart';
import 'package:rotary/widgets/app_bar/appbar_title.dart';
import 'package:rotary/widgets/app_bar/custom_app_bar.dart';
import 'package:rotary/widgets/custom_drop_down.dart';
import 'package:rotary/widgets/custom_elevated_button.dart';
import 'package:rotary/widgets/custom_phone_number.dart';
import 'package:rotary/widgets/custom_text_form_field.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<EditProfileBloc>(
        create: (context) => EditProfileBloc(
            EditProfileState(editProfileModelObj: EditProfileModel()))
          ..add(EditProfileInitialEvent()),
        child: EditProfileScreen());
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
                                horizontal: 24.h, vertical: 10.v),
                            child: Column(children: [
                              _buildLabel1(context),
                              SizedBox(height: 24.v),
                              _buildDate(context),
                              SizedBox(height: 24.v),
                              _buildEmail(context),
                              SizedBox(height: 24.v),
                              _buidCountry(context),
                              SizedBox(height: 24.v),
                              _buildPhoneNumber(context),
                              SizedBox(height: 5.v)
                            ]))))),
            bottomNavigationBar: _buildUpdate(context)));
  }

  /// Section Widget
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
                    text: "Edit Profile", margin: EdgeInsets.only(left: 16.h))
              ])),
        ]));
  }

  /// Section Widget
  Widget _buildLabel1(BuildContext context) {
    return BlocSelector<EditProfileBloc, EditProfileState,
            TextEditingController?>(
        selector: (state) => state.nameController,
        builder: (context, label1Controller) {
          return CustomTextFormField(
              controller: label1Controller, hintText: "Siti Sumaiyah Syahirah");
        });
  }

  /// Section Widget
  Widget _buildDate(BuildContext context) {
    return BlocSelector<EditProfileBloc, EditProfileState,
            DateTime?>(
        selector: (state) => state.dateController,
        builder: (context, dateController) {
          String getDate = DateFormat('dd/MM/yyyy').format(dateController ?? DateTime.now());
          TextEditingController formattedDate = TextEditingController(text: getDate);
          return CustomTextFormField(
              controller: formattedDate,
              hintText: "01/01/2001",
              suffix: Container(
                  margin: EdgeInsets.fromLTRB(30.h, 16.v, 20.h, 16.v),
                  child: CustomImageView(
                    onTap: () {
                      _selectDateFrom(context);
                    },
                      imagePath: ImageConstant.imgNavEvent,
                      height: 15.adaptSize,
                      width: 15.adaptSize)),
              suffixConstraints: BoxConstraints(maxHeight: 56.v),
              contentPadding: EdgeInsets.only(left: 20.h));
        });
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return BlocSelector<EditProfileBloc, EditProfileState,
            TextEditingController?>(
        selector: (state) => state.emailController,
        builder: (context, emailController) {
          return CustomTextFormField(
              controller: emailController,
              hintText: "siti@gmail.com",
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || (!isValidEmail(value, isRequired: true))) {
                  return "Please enter valid email address";
                }
                return null;
              },
             );
        });
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
      return CustomPhoneNumber(
          country: state.selectedCountry ??
              CountryPickerUtils.getCountryByPhoneCode('60'),
          controller: state.phoneNumberController,
          onTap: (Country value) {
            context.read<EditProfileBloc>().add(ChangeCountryEvent(value: value));
          });
    });
  }

  Widget _buidCountry(BuildContext context) {
    return BlocSelector<EditProfileBloc, EditProfileState, EditProfileModel?>(
        selector: (state) => state.editProfileModelObj,
        builder: (context, editProfileModelObj) {
          final state = context.read<EditProfileBloc>().state;
          return CustomDropDown(
              icon: Container(
                  child: CustomImageView(
                      imagePath: ImageConstant.imgDownArrow,
                      height: 20.adaptSize,
                      width: 20.adaptSize)),
              hintText: state.countryController,
              items: editProfileModelObj?.dropdownItemList ?? [],
              onChanged: (value) {
                context
                    .read<EditProfileBloc>()
                    .add(ChangeDropDownEvent(value: value));
                state.countryController = value.title;
              });
        });
  }

  /// Section Widget
  Widget _buildUpdate(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        final state = context.read<EditProfileBloc>().state;
        context.read<EditProfileBloc>().add(ToUpdateProfileEvent(
        itemToUpdate: ProfileItemModel(
          id: state.id,
          name: state.nameController!.text,
          email: state.emailController!.text,
          dob: state.dateController,
          country: state.countryController,
          phone: state.phoneNumberController!.text,
        )
      ));
      Fluttertoast.showToast(msg: "Your Profile has been updated");
      NavigatorService.goBack();
      },
        text: "Update".tr,
        margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 49.v));
  }

  Future<void> _selectDateFrom(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(), 
    firstDate: DateTime(2000), 
    lastDate: DateTime(2025), 
  );
  if (pickedDate != null) {
    context.read<EditProfileBloc>().add(DobEvent(pickedDate));
  }
}
  /// Navigates to the previous screen.
  _onTapBack(BuildContext context) {
    NavigatorService.goBack();
  }
}
