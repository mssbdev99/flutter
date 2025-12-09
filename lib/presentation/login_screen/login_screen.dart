import 'package:rotary/presentation/login_screen/login_controller.dart';
import 'bloc/login_bloc.dart';
import 'models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/app_export.dart';
import 'package:rotary/core/utils/validation_functions.dart';
import 'package:rotary/widgets/custom_elevated_button.dart';
import 'package:rotary/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(LoginState(loginModelObj: LoginModel()))
          ..add(LoginInitialEvent()),
        child: LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: _formKey,
                        child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.only(
                                left: 16.h, top: 68.v, right: 16.h),
                            child: Column(children: [
                              SizedBox(height: 25.v),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                      width: 350.adaptSize,
                                      child: Text("Login To Your\nAccount",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.displaySmall!
                                              .copyWith(
                                                  height: 1.50,
                                                  fontSize: 50.v)))),
                              SizedBox(height: 50.v),
                              BlocSelector<LoginBloc, LoginState,
                                      TextEditingController?>(
                                  selector: (state) => state.emailController,
                                  builder: (context, emailController) {
                                    print(emailController);
                                    return CustomTextFormField(
                                        controller: emailController,
                                        hintText: "Enter email",
                                        textInputType:
                                            TextInputType.emailAddress,
                                        prefix: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                16.h, 12.v, 10.h, 12.v),
                                            child: CustomImageView(
                                                imagePath:
                                                    ImageConstant.imgEmailIcon,
                                                height: 15.adaptSize,
                                                width: 15.adaptSize)),
                                        prefixConstraints:
                                            BoxConstraints(maxHeight: 48.v),
                                        validator: (value) {
                                          print("validator value: ${value}");
                                          if (value == null ||
                                              (!isValidEmail(value,
                                                  isRequired: true))) {
                                            print('email is invalid');
                                            return "err_msg_please_enter_valid_email"
                                                .tr;
                                          }
                                          return null;
                                        },
                                        contentPadding: EdgeInsets.only(
                                            top: 15.v,
                                            right: 30.h,
                                            bottom: 15.v));
                                  }),
                              SizedBox(height: 10.v),
                              BlocSelector<LoginBloc, LoginState,
                                      TextEditingController?>(
                                  selector: (state) => state.passwordController,
                                  builder: (context, passwordController) {
                                    return CustomTextFormField(
                                        controller: passwordController,
                                        hintText: "Enter password",
                                        textInputAction: TextInputAction.done,
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        prefix: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                16.h, 12.v, 10.h, 12.v),
                                            child: CustomImageView(
                                                imagePath:
                                                    ImageConstant.imgLock,
                                                height: 15.adaptSize,
                                                width: 15.adaptSize)),
                                        prefixConstraints:
                                            BoxConstraints(maxHeight: 48.v),
                                        validator: (value) {
                                          if (value == null ||
                                              (!isValidPassword(value,
                                                  isRequired: true))) {
                                            return "err_msg_please_enter_valid_password"
                                                .tr;
                                          }
                                          return null;
                                        },
                                        obscureText: true,
                                        contentPadding: EdgeInsets.only(
                                            top: 15.v,
                                            right: 30.h,
                                            bottom: 15.v));
                                  }),
                              SizedBox(height: 16.v),
                              CustomElevatedButton(
                                buttonStyle: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35.0),
                                      
                                    ),
                                  ),
                                ),
                                text: "Sign In",
                                onPressed: () {
                                  onTapSignIn(context);
                                },
                              ),
                              SizedBox(height: 35.v),
                              _buildOrLine(context),
                              SizedBox(height: 16.v),
                              _buildSocialAuthentication(context),
                              SizedBox(height: 30.v),
                              /*GestureDetector(
                                onTap: () {
                                  onTapForgotPassword(context);
                                },
                                child: Text("msg_forgot_password".tr, style: CustomTextStyles.labelLargePrimary),
                              ),*/
                              SizedBox(height: 7.v),
                              GestureDetector(
                                  onTap: () {
                                    onTapTxtDonthaveanaccount(context);
                                  },
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text:
                                                "msg_don_t_have_an_account2".tr,
                                            style: CustomTextStyles
                                                .bodySmallff9098b1),
                                        TextSpan(text: " "),
                                        TextSpan(
                                            text: "lbl_register".tr,
                                            style: CustomTextStyles
                                                .labelLargeff40bfff)
                                      ]),
                                      textAlign: TextAlign.left)),
                              SizedBox(height: 5.v)
                            ])))))));
  }

  /// Section Widget
  Widget _buildOrLine(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(top: 10.v, bottom: 9.v),
          child: SizedBox(width: 134.h, child: Divider())),
      Text("lbl_or".tr, style: CustomTextStyles.titleSmallBluegray300_1),
      Padding(
          padding: EdgeInsets.only(top: 10.v, bottom: 9.v),
          child: SizedBox(width: 137.h, child: Divider()))
    ]);
  }

  /// Section Widget
  Widget _buildSocialAuthentication(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          /*GestureDetector(
            onTap: () {
              onTapLoginWithFacebook(context);
            },
            child: Container(
                height: 60.v,
                width: 88.h,
                padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 17.v),
                decoration: AppDecoration.outlinePrimary
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
                child: CustomImageView(
                    imagePath: ImageConstant.imgFacebookIcon,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                    alignment: Alignment.center)),
          ),*/
          GestureDetector(
            onTap: () {
              onTapLoginWithGoogle(context);
            },
            child: Container(
                height: 60.v,
                width: 87.h,
                margin: EdgeInsets.only(left: 20.h),
                padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 17.v),
                decoration: AppDecoration.outlinePrimary
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
                child: CustomImageView(
                    imagePath: ImageConstant.imgGoogleIcon,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                    alignment: Alignment.center)),
          ),
          GestureDetector(
            onTap: () {
              onTapLoginWithMicrosoft(context);
            },
            child: Container(
                height: 60.v,
                width: 87.h,
                margin: EdgeInsets.only(left: 20.h),
                padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 17.v),
                decoration: AppDecoration.outlinePrimary
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
                child: CustomImageView(
                    imagePath: ImageConstant.imgMicrosoftIcon,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                    alignment: Alignment.center)),
          )
        ]));
  }

  /// Navigates to the dashboardContainerScreen when the action is triggered.
  onTapSignIn(BuildContext context) {
    LoginController(context: context).handleLogin('email');
    context.read<LoginBloc>().add(LoginGetTableEvent());
  }

  onTapLoginWithGoogle(BuildContext context) async {
    LoginController(context: context).handleLogin('google');
    context.read<LoginBloc>().add(LoginGetTableEvent());
  }

  onTapLoginWithFacebook(BuildContext context) async {
    LoginController(context: context).handleLogin('facebook');
    context.read<LoginBloc>().add(LoginGetTableEvent());
  }

  onTapLoginWithMicrosoft(BuildContext context) async {
    LoginController(context: context).handleLogin('microsoft');
    context.read<LoginBloc>().add(LoginGetTableEvent());
  }

  onTapTxtDonthaveanaccount(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.registerScreen);
  }
  
  void onTapForgotPassword(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.changePasswordScreen);
  }
}
