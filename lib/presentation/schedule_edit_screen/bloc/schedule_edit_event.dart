// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rotary/data/models/selectionPopupModel/selection_popup_model.dart';
import 'package:rotary/presentation/schedule_page/models/schedule_item_model.dart';

@immutable
abstract class ScheduleEditEvent extends Equatable {}

/// Event that is dispatched when the BookingName widget is first created.
class ScheduleEditInitialEvent extends ScheduleEditEvent {
  @override
  List<Object?> get props => [];
}

class ToUpdateScheduleEvent extends ScheduleEditEvent {
  final ScheduleItemModel? itemToUpdate;

  ToUpdateScheduleEvent({this.itemToUpdate});

  @override
  List<Object?> get props => [itemToUpdate];
}

class FromDatetEvent extends ScheduleEditEvent {
  TextEditingController fromDate;

  FromDatetEvent(this.fromDate);

  @override
  List<Object?> get props => [fromDate];
}

class ToDatetEvent extends ScheduleEditEvent {
  TextEditingController toDate;

  ToDatetEvent(this.toDate);

  @override
  List<Object?> get props => [toDate];
}

class ChangeDropDownClubEvent extends ScheduleEditEvent {
  ChangeDropDownClubEvent({required this.value});

  SelectionPopupModel value;

  @override
  List<Object?> get props => [
        value,
      ];
}

class GetItemScheduleDetail extends ScheduleEditEvent {
  final int id;

  GetItemScheduleDetail(this.id);

  @override
  List<Object?> get props => [id];
}
