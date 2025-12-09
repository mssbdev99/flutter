// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'schedule_item_model.dart';

class ScheduleModel extends Equatable {
  ScheduleModel({
    this.scheduleItemList = const [],
  }) {}

  List<ScheduleItemModel> scheduleItemList;

  ScheduleModel copyWith({
    List<ScheduleItemModel>? scheduleItemList,
  }) {
    return ScheduleModel(
      scheduleItemList: scheduleItemList ?? this.scheduleItemList,
    );
  }

  @override
  List<Object?> get props => [
        scheduleItemList,
      ];
}
