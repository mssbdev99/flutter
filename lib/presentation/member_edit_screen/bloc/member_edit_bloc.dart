import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/data/database_sqlite/database_helper.dart';
import 'package:rotary/presentation/member_edit_screen/bloc/member_edit_event.dart';
import 'package:rotary/presentation/member_edit_screen/bloc/member_edit_state.dart';
import 'package:rotary/presentation/member_list_page/models/member_item_model.dart';

class MemberEditBloc extends Bloc<MemberEditEvent, MemberEditState> {
  MemberEditBloc(MemberEditState initialState) : super(initialState) {
    on<GetItemMemberDetail>(_onInitialize);
    on<ToUpdateMemberEvent>(_onToUpdateMember);
  }

  _onInitialize(
    GetItemMemberDetail event,
    Emitter<MemberEditState> emit,
  ) async {
    
    Map<String, dynamic> members = await DatabaseService.instance.readItem(memberTable, event.id);
    MemberItemModel memberEvent = MemberItemModel.fromJson(members);

    emit(state.copyWith(memberItemModelObj: memberEvent));
    emit(state.copyWith(
        nameController: TextEditingController(text: memberEvent.memberName),
        addressController: TextEditingController(text: memberEvent.memberAddress),
        icController: TextEditingController(text: memberEvent.memberIC),
        emailController: TextEditingController(text: memberEvent.memberEmail),
        phoneController: TextEditingController(text: memberEvent.memberPhone),
        ));
  }
    
  _onToUpdateMember(ToUpdateMemberEvent event, Emitter<MemberEditState> emit) async {
    await DatabaseService.instance.update(memberTable, event.itemToUpdate!.toJson());
  }
}