// ignore_for_file: must_be_immutable

part of 'profile_bloc.dart';

/// Represents the state of Profile in the application.
class ProfileState extends Equatable {
  ProfileState({this.profileModelObj, this.profileModelItemObj});

  ProfileItemModel? profileModelItemObj;

  ProfileModel? profileModelObj;

  @override
  List<Object?> get props => [
    profileModelItemObj,
        profileModelObj,
      ];
  ProfileState copyWith({ProfileModel? profileModelObj, ProfileItemModel? profileModelItemObj}) {
    return ProfileState(
      profileModelItemObj: profileModelItemObj ?? this.profileModelItemObj,
      profileModelObj: profileModelObj ?? this.profileModelObj,
    );
  }
}
