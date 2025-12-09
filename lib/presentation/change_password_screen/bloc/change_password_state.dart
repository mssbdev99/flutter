// ignore_for_file: must_be_immutable

part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  ChangePasswordState({
    this.oldPasswordController,
    this.newPasswordController,
    this.newPasswordAgainController,
    this.changePasswordModelObj,
  });

  TextEditingController? oldPasswordController;

  TextEditingController? newPasswordController;

  TextEditingController? newPasswordAgainController;

  ChangePasswordModel? changePasswordModelObj;

  @override
  List<Object?> get props => [
        oldPasswordController,
        newPasswordController,
        newPasswordAgainController,
        changePasswordModelObj,
      ];
  ChangePasswordState copyWith({
    TextEditingController? oldPasswordController,
    TextEditingController? newPasswordController,
    TextEditingController? newPasswordAgainController,
    ChangePasswordModel? changePasswordModelObj,
  }) {
    return ChangePasswordState(
      oldPasswordController:
          oldPasswordController ?? this.oldPasswordController,
      newPasswordController:
          newPasswordController ?? this.newPasswordController,
      newPasswordAgainController:
          newPasswordAgainController ?? this.newPasswordAgainController,
      changePasswordModelObj:
          changePasswordModelObj ?? this.changePasswordModelObj,
    );
  }
}
