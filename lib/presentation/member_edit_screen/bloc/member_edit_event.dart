// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rotary/presentation/member_list_page/models/member_item_model.dart';

@immutable
abstract class MemberEditEvent extends Equatable {}

/// Event that is dispatched when the BookingName widget is first created.
class MemberEditInitialEvent extends MemberEditEvent {
  @override
  List<Object?> get props => [];
}

class ToUpdateMemberEvent extends MemberEditEvent {
  final MemberItemModel? itemToUpdate;

  ToUpdateMemberEvent({this.itemToUpdate});

  @override
  List<Object?> get props => [itemToUpdate];
}


class GetItemMemberDetail extends MemberEditEvent {
  final int id;

  GetItemMemberDetail(this.id);

  @override
  List<Object?> get props => [id];
}
