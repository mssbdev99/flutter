import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rotary/data/models/selectionPopupModel/selection_popup_model.dart';
import 'package:rotary/presentation/schedule_edit_screen/models/schedule_edit_model.dart';
import 'package:rotary/presentation/schedule_page/models/schedule_item_model.dart';

// ignore: must_be_immutable
class ScheduleEditState extends Equatable{

  ScheduleEditState({
    this.label1Controller,
    this.label2Controller,
    this.clubController,
    this.startController,
    this.endController,
    this.selectedDropDownValue,
    this.scheduleEditModelObj,
    this.scheduleItemModelObj
  });

  TextEditingController? label1Controller;

  TextEditingController? label2Controller;

  TextEditingController? clubController;

  TextEditingController? startController;

  TextEditingController? endController;

  SelectionPopupModel? selectedDropDownValue;

  ScheduleEditModel? scheduleEditModelObj;

  ScheduleItemModel? scheduleItemModelObj;

  @override
  List<Object?> get props => [
        label1Controller,
        label2Controller,
        clubController,
        startController,
        endController,     
        selectedDropDownValue,
        scheduleEditModelObj,
        scheduleItemModelObj

      ];
  ScheduleEditState copyWith({
    TextEditingController? label1Controller,
    TextEditingController? label2Controller,
    TextEditingController? clubController,
    TextEditingController? startController,
    TextEditingController? endController,
    SelectionPopupModel? selectedDropDownValue,
    ScheduleEditModel? scheduleEditModelObj,
    ScheduleItemModel? scheduleItemModelObj
    
  }) {
    return ScheduleEditState(
      label1Controller: label1Controller ?? this.label1Controller,
      label2Controller: label2Controller ?? this.label2Controller,
      clubController: clubController ?? this.clubController,
      startController: startController ?? this.startController,
      endController: endController ?? this.endController,
      selectedDropDownValue: selectedDropDownValue ?? this.selectedDropDownValue,
      scheduleItemModelObj: scheduleItemModelObj ?? this.scheduleItemModelObj,
    );
  }

}