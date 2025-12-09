// ignore_for_file: must_be_immutable

part of 'schedule_screen_bloc.dart';

/// Represents the state of ViewOnMap in the application.
class ScheduleScreenState extends Equatable {
  ScheduleScreenState({this.scheduleScreenModelObj, this.latitude, this.longitude});

  ScheduleItemModel? scheduleScreenModelObj;

  double? latitude;

  double? longitude;


  @override
  List<Object?> get props => [
        scheduleScreenModelObj,
        latitude,
        longitude
      ];
  ScheduleScreenState copyWith({ScheduleItemModel? scheduleScreenModelObj, double? latitude, double? longitude}) {
    return ScheduleScreenState(
      scheduleScreenModelObj: scheduleScreenModelObj ?? this.scheduleScreenModelObj,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
