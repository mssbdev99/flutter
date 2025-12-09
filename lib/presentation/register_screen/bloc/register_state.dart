// ignore_for_file: must_be_immutable

part of 'register_bloc.dart';

class RegisterState extends Equatable {
  RegisterState({
    this.fullNameController,
    this.emailController,
    this.passwordController,
    this.passwordController1,
    this.registerModelObj,
  });

  TextEditingController? fullNameController;

  TextEditingController? emailController;

  TextEditingController? passwordController;

  TextEditingController? passwordController1;

  RegisterModel? registerModelObj;

  @override
  List<Object?> get props => [
        fullNameController,
        emailController,
        passwordController,
        passwordController1,
        registerModelObj,
      ];
  RegisterState copyWith({
    TextEditingController? fullNameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? passwordController1,
    RegisterModel? registerModelObj,
  }) {
    return RegisterState(
      fullNameController: fullNameController ?? this.fullNameController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      passwordController1: passwordController1 ?? this.passwordController1,
      registerModelObj: registerModelObj ?? this.registerModelObj,
    );
  }
}
