// ignore_for_file: must_be_immutable
part of 'schedule_screen_bloc.dart';

@immutable
abstract class ScheduleScreenEvent extends Equatable {}

class ScheduleScreenGetEvent extends ScheduleScreenEvent {

  final int id;

  ScheduleScreenGetEvent(this.id);
  
  @override
  List<Object?> get props => [id];
  
}

class GetLocationLat extends ScheduleScreenEvent {
  
  final double latitude;
  final double longitude;

  GetLocationLat(this.latitude, this.longitude);
  
  
  @override
  List<Object?> get props => [latitude, longitude];
  
}
