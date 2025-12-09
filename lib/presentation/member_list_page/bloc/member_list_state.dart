// ignore_for_file: must_be_immutable

part of 'member_list_bloc.dart';

/// Represents the state of NotificationList in the application.
class MemberListState extends Equatable {
  MemberListState({this.searchController, this.memberListModelObj});

  TextEditingController? searchController;

  MemberListModel? memberListModelObj;

  @override
  List<Object?> get props => [
        searchController,
        memberListModelObj,
      ];
  MemberListState copyWith(
      {TextEditingController? searchController, MemberListModel? memberListModelObj}) {
    return MemberListState(
      searchController: searchController ?? this.searchController,
      memberListModelObj: memberListModelObj ?? this.memberListModelObj,
    );
  }
}
