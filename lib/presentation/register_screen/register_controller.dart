import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/app_export.dart';
import 'package:rotary/presentation/register_screen/bloc/register_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterController {
  final BuildContext context;

  RegisterController({required this.context});

  Future<void> handleRegister() async {
    final state = context.read<RegisterBloc>().state;

    String userName = state.fullNameController!.text;
    String userEmail = state.emailController!.text;
    String userPassword = state.passwordController!.text;
    String userRepassword = state.passwordController1!.text;

    if (userName.isEmpty) {
      Fluttertoast.showToast(msg: "username empty");
    }
    if (userEmail.isEmpty) {
      Fluttertoast.showToast(msg: "email empty");
    }
    if (userPassword.isEmpty) {
      Fluttertoast.showToast(msg: "password empty");
    }
    if (userRepassword.isEmpty) {
      Fluttertoast.showToast(msg: "confirm password empty");
    }

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);

      if (credential.user != null) {
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(userName);

        Fluttertoast.showToast(
          msg:
              "An Email has been send to your registered email. Please verified",
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'email-already-in-use')
        Fluttertoast.showToast(
          msg: "Email already exist",
        );
    }
  }
}
