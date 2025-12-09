import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rotary/data/database_sqlite/database_helper.dart';
import 'package:rotary/presentation/member_list_page/models/member_list_model.dart';
import '/core/app_export.dart';
import '../models/member_item_model.dart';
part 'member_list_event.dart';
part 'member_list_state.dart';

class MemberListBloc extends Bloc<MemberListEvent, MemberListState> {
  MemberListBloc(MemberListState initialState) : super(initialState) {
    on<MemberListInitialEvent>(_onInitialize);
    on<DeleteMemberEvent>(_onDeleteMember);
    on<SearchKeywordMemberEvent>(_onSearchMemberItem);
  }

  _onInitialize(
    MemberListInitialEvent event,
    Emitter<MemberListState> emit,
  ) async {
    List<MemberItemModel> members = await _getAllMembers();
    emit(state.copyWith(searchController: TextEditingController()));
    emit(state.copyWith(
        memberListModelObj: state.memberListModelObj?.copyWith(
      memberlistItemList: members,
    )));
  }

  _onDeleteMember(
    DeleteMemberEvent event, Emitter<MemberListState> emit) async {
    await DatabaseService.instance.delete(memberTable, event.id);
    add(MemberListInitialEvent());
  }

  _onSearchMemberItem(
      SearchKeywordMemberEvent event, Emitter<MemberListState> emit) async {
    List<MemberItemModel> scheduleSearch =
        await _getSearchItems(event.keywordInput);

    emit(state.copyWith(
        memberListModelObj: state.memberListModelObj
            ?.copyWith(memberlistItemList: scheduleSearch)));
  }

  Future<List<MemberItemModel>> _getAllMembers() async {
    final result = await DatabaseService.instance.readAllItem(memberTable);
    print(result);
    return result.map((item) => MemberItemModel.fromJson(item)).toList();
  }

  Future<List<MemberItemModel>> _getSearchItems(String toSearch) async {
    final result = await DatabaseService.instance.searchMember(toSearch);
    return result.map((item) => MemberItemModel.fromJson(item)).toList();
  }
}
