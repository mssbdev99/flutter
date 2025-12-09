// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:rotary/presentation/login_screen/models/login_item_model.dart';

/// This class defines the variables used in the [profile_screen],
/// and is typically used to hold data that is passed between different parts of the application.


class ProfileModel extends Equatable {
  ProfileModel({
    this.profileItemList = const [],
  }) {}

  List<ProfileItemModel> profileItemList;

  ProfileModel copyWith({
    List<ProfileItemModel>? profileItemList,
  }) {
    return ProfileModel(
      profileItemList: profileItemList ?? this.profileItemList,
    );
  }

  @override
  List<Object?> get props => [
        profileItemList,
      ];
}
