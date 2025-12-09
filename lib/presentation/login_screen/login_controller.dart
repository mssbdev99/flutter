import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rotary/core/app_export.dart';
import 'package:rotary/core/constants/shared_pref.dart';
import 'package:rotary/domain/facebookauth/facebook_auth_helper.dart';
import 'package:rotary/domain/facebookauth/facebook_user.dart';
import 'package:rotary/domain/googleauth/google_auth_helper.dart';
import 'package:rotary/domain/microsoftauth/microsoft_auth_helper.dart';
import 'package:rotary/domain/microsoftauth/microsoft_user.dart';
import 'package:rotary/presentation/login_screen/bloc/login_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginController {
  final BuildContext context;

  LoginController({required this.context});

  Future<void> handleLogin(String type) async {
    try {
      if (type == 'email') {
        final state = context.read<LoginBloc>().state;

        String emailAddress = state.emailController!.text;
        String emailPassword = state.passwordController!.text;

        if (emailAddress.isEmpty) {
          Fluttertoast.showToast(
            msg: "email empty",
          );
        }

        if (emailPassword.isEmpty) {
          Fluttertoast.showToast(
            msg: "password empty",
          );
        }

        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAddress, password: emailPassword);
          if (credential.user == null) {
            Fluttertoast.showToast(
              msg: "User not exist",
            );
          }
          if (!credential.user!.emailVerified) {
            Fluttertoast.showToast(
              msg: "email not verified",
            );
          }

          var user = credential.user;
          if (user != null) {
            print("user exist: ${user.email}");
            print("user exist: ${user.displayName}");
            PrefUtils().setString(AppConstant.STORAGE_USER_TOKEN_KEY, "123456");
            NavigatorService.pushNamed(AppRoutes.dashboardContainerScreen);

            context.read<LoginBloc>().add(AddUserProfileEvent(
                profileName: user.displayName, profileEmail: user.email));
          } else {
            Fluttertoast.showToast(msg: "User not exist");
          }
        } on FirebaseAuthException catch (e) {
          print(e.code);
          if (e.code == 'user-not-found') {
            Fluttertoast.showToast(
              msg: "No user found for that email",
            );
          } else if (e.code == 'wrong-password') {
            Fluttertoast.showToast(
              msg: "Wrong password provided for that user",
            );
            print("Wrong password provided for that user");
          } else if (e.code == 'invalid-email') {
            Fluttertoast.showToast(
              msg: "Wrong email address provided for that user",
            );
            print("Wrong email address provided for that user");
          } else if (e.code == 'user-disabled') {
            Fluttertoast.showToast(
              msg: "User has been disabled",
            );
          }
        }
      }

      if (type == 'google') {
        await GoogleAuthHelper().googleSignInProcess().then((googleUser) {
          if (googleUser != null) {
            EasyLoading.show(
                indicator: CircularProgressIndicator(),
                maskType: EasyLoadingMaskType.clear,
                dismissOnTap: true);
            onSuccessGoogleAuthResponse(googleUser, context);
          } else {
            onErrorGoogleAuthResponse(context);
          }
        }).catchError((onError) {
          onErrorGoogleAuthResponse(context);
        });
      }

      if (type == 'facebook') {
        await FacebookAuthHelper().facebookSignInProcess().then((facebookUser) {
          if (facebookUser.email!.trim().isNotEmpty) {
            onSuccessFacebookAuthResponse(facebookUser, context);
          } else {
            onErrorFacebookAuthResponse(context);
          }
        }).catchError((onError) {
          onErrorFacebookAuthResponse(context);
        });
      }

      if (type == 'microsoft') {
        await MicrosoftAuthHelper().microsoftSignInProcess().then((microsoftUser) {
          if (microsoftUser!.userPrincipalName!.trim().isNotEmpty) {
            EasyLoading.show(
                indicator: CircularProgressIndicator(),
                maskType: EasyLoadingMaskType.clear,
                dismissOnTap: true);
            onSuccessMicrosoftAuthResponse(microsoftUser, context);
          } else {
            onErrorMicrosoftAuthResponse(context);
          }
        }).catchError((onError) {
          onErrorMicrosoftAuthResponse(context);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  ///Google
  void onSuccessGoogleAuthResponse(GoogleSignInAccount googleUser, BuildContext context) {
    context.read<LoginBloc>().add(AddUserProfileEvent(profileName: googleUser.displayName, profileEmail: googleUser.email));
    PrefUtils().setString(AppConstant.STORAGE_USER_TOKEN_KEY, "123456");
    NavigatorService.pushNamed(AppRoutes.dashboardContainerScreen);
    EasyLoading.dismiss();
  }

  void onErrorGoogleAuthResponse(BuildContext context) {
    Fluttertoast.showToast(msg: "Google Login Failed");
  }

  ///Facebook
  void onSuccessFacebookAuthResponse(
    FacebookUser facebookUser,
    BuildContext context,
  ) {
    context.read<LoginBloc>().add(AddUserProfileEvent(
        profileName: facebookUser.name, profileEmail: facebookUser.email));
    PrefUtils().setString(AppConstant.STORAGE_USER_TOKEN_KEY, "123456");
    NavigatorService.pushNamed(AppRoutes.dashboardContainerScreen);
  }

  void onErrorFacebookAuthResponse(BuildContext context) {
    Fluttertoast.showToast(msg: "Facebook login failed");
  }

  ///Microsoft
  void onSuccessMicrosoftAuthResponse(
      MicrosoftUser? microsoftUser, BuildContext context) {
    context.read<LoginBloc>().add(AddUserProfileEvent(
        profileName: microsoftUser!.displayName,
        profileEmail: microsoftUser.mail));
    PrefUtils().setString(AppConstant.STORAGE_USER_TOKEN_KEY, "123456");
    NavigatorService.pushNamed(AppRoutes.dashboardContainerScreen);
    EasyLoading.dismiss();
  }

  void onErrorMicrosoftAuthResponse(BuildContext context) {
    Fluttertoast.showToast(msg: "Microsoft login failed");
  }
}
