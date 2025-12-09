// ignore_for_file: must_be_immutable

part of 'schedule_bloc.dart';

/// Represents the state of Schedule in the application.
class ScheduleState extends Equatable {
  ScheduleState({this.searchController, this.scheduleModelObj});

  TextEditingController? searchController;

  ScheduleModel? scheduleModelObj;

  @override
  List<Object?> get props => [
        searchController,
        scheduleModelObj,
      ];
  ScheduleState copyWith({TextEditingController? searchController, ScheduleModel? scheduleModelObj}) {
    return ScheduleState(
      searchController: searchController ?? this.searchController,
      scheduleModelObj: scheduleModelObj ?? this.scheduleModelObj,
    );
  }
}
