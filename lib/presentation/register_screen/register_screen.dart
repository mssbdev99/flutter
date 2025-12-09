import 'package:rotary/presentation/register_screen/register_controller.dart';
import 'package:rotary/widgets/app_bar/appbar_leading_image.dart';
import 'package:rotary/widgets/app_bar/appbar_subtitle.dart';
import 'package:rotary/widgets/app_bar/custom_app_bar.dart';
import 'bloc/register_bloc.dart';
import 'models/register_model.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/app_export.dart';
import 'package:rotary/core/utils/validation_functions.dart';
import 'package:rotary/widgets/custom_elevated_button.dart';
import 'package:rotary/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<RegisterBloc>(
        create: (context) =>
            RegisterBloc(RegisterState(registerModelObj: RegisterModel()))
              ..add(RegisterInitialEvent()),
        child: RegisterScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(context),
            resizeToAvoidBottomInset: false,
            body: Center(
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: _formKey,
                        child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(horizontal: 16.h),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildPageHeader(context),
                                  SizedBox(height: 30.v),
                                  _buildFullName(context),
                                  SizedBox(height: 8.v),
                                  _buildEmail(context),
                                  SizedBox(height: 8.v),
                                  _buildPassword(context),
                                  SizedBox(height: 8.v),
                                  _buildPassword1(context),
                                  SizedBox(height: 20.v),
                                  _buildSignUp(context),
                                  SizedBox(height: 20.v),
                                  
                                ])))))));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 16.h, top: 16.v, bottom: 15.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarSubtitle(
            text: "Register Account", margin: EdgeInsets.only(left: 12.h)));
  }

  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Column(children: [
      Container(
        height: 72.adaptSize,
        width: 72.adaptSize,
        padding: EdgeInsets.all(5.h),
        //decoration: BoxDecoration(),
        child: CustomImageView(imagePath: ImageConstant.imgLogo),

      ),
      SizedBox(height: 16.v),
      Text("msg_let_s_get_started".tr, style: theme.textTheme.titleMedium),
      SizedBox(height: 9.v),
      Text("msg_create_an_new_account".tr, style: theme.textTheme.bodySmall)
    ]);
  }

  /// Section Widget
  Widget _buildFullName(BuildContext context) {
    return BlocSelector<RegisterBloc, RegisterState, TextEditingController?>(
        selector: (state) => state.fullNameController,
        builder: (context, fullNameController) {
          return CustomTextFormField(
              controller: fullNameController,
              hintText: "lbl_full_name".tr,
              prefix: Container(
                  margin: EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgNavProfile,
                      height: 18.adaptSize,
                      width: 18.adaptSize)),
              prefixConstraints: BoxConstraints(maxHeight: 48.v),
              validator: (value) {
                if (!isText(value)) {
                  return "err_msg_please_enter_valid_text".tr;
                }
                return null;
              },
              contentPadding:
                  EdgeInsets.only(top: 15.v, right: 30.h, bottom: 15.v));
        });
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return BlocSelector<RegisterBloc, RegisterState, TextEditingController?>(
        selector: (state) => state.emailController,
        builder: (context, emailController) {
          return CustomTextFormField(
              controller: emailController,
              hintText: "lbl_your_email".tr,
              textInputType: TextInputType.emailAddress,
              prefix: Container(
                  margin: EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgEmailIcon,
                      height: 18.adaptSize,
                      width: 18.adaptSize)),
              prefixConstraints: BoxConstraints(maxHeight: 48.v),
              validator: (value) {
                if (value == null || (!isValidEmail(value, isRequired: true))) {
                  return "err_msg_please_enter_valid_email".tr;
                }
                return null;
              },
              contentPadding:
                  EdgeInsets.only(top: 15.v, right: 30.h, bottom: 15.v));
        });
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return BlocSelector<RegisterBloc, RegisterState, TextEditingController?>(
        selector: (state) => state.passwordController,
        builder: (context, passwordController) {
          return CustomTextFormField(
              controller: passwordController,
              hintText: "lbl_password".tr,
              textInputType: TextInputType.visiblePassword,
              prefix: Container(
                  margin: EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgPadlock,
                      height: 18.adaptSize,
                      width: 18.adaptSize)),
              prefixConstraints: BoxConstraints(maxHeight: 48.v),
              validator: (value) {
                if (value == null ||
                    (!isValidPassword(value, isRequired: true))) {
                  return "err_msg_please_enter_valid_password".tr;
                }
                return null;
              },
              obscureText: true,
              contentPadding:
                  EdgeInsets.only(top: 15.v, right: 30.h, bottom: 15.v));
        });
  }

  /// Section Widget
  Widget _buildPassword1(BuildContext context) {
    return BlocSelector<RegisterBloc, RegisterState, TextEditingController?>(
        selector: (state) => state.passwordController1,
        builder: (context, passwordController1) {
          return CustomTextFormField(
              controller: passwordController1,
              hintText: "Confirm Password",
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
              prefix: Container(
                  margin: EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgPadlock,
                      height: 18.adaptSize,
                      width: 18.adaptSize)),
              prefixConstraints: BoxConstraints(maxHeight: 48.v),
              validator: (value) {
                if (value == null ||
                    (!isValidPassword(value, isRequired: true))) {
                  return "err_msg_please_enter_valid_password".tr;
                }
                return null;
              },
              obscureText: true,
              contentPadding:
                  EdgeInsets.only(top: 15.v, right: 30.h, bottom: 15.v));
        });
  }

  /// Section Widget
  Widget _buildSignUp(BuildContext context) {
    return CustomElevatedButton(
        text: "lbl_sign_up".tr,
        onPressed: () {
          onTapSignUp(context);
        });
  }

  /// Navigates to the dashboardContainerScreen when the action is triggered.
  onTapSignUp(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.loginScreen);
    RegisterController(context: context).handleRegister();
  }

  onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }
}
