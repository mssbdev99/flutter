// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';
import 'member_item_model.dart';

class MemberListModel extends Equatable {
  MemberListModel({
    this.memberlistItemList = const [],
  }) {}

  List<MemberItemModel> memberlistItemList;

  MemberListModel copyWith({
    List<MemberItemModel>? memberlistItemList,
  }) {
    return MemberListModel(
      memberlistItemList:
          memberlistItemList ?? this.memberlistItemList,
    );
  }

  @override
  List<Object?> get props => [memberlistItemList];
}
