// ignore_for_file: must_be_immutable
part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleEvent extends Equatable {}

/// Event that is dispatched when the Schedule Page widget is first created.
class ScheduleInitialEvent extends ScheduleEvent {
  @override
  List<Object?> get props => [];
}

class ScheduleGetIdEvent extends ScheduleEvent {

  final int id;

  ScheduleGetIdEvent(this.id);
  
  @override
  List<Object?> get props => [id];
  
}

class FilterByDate extends ScheduleEvent{
  final String toFilter;

  FilterByDate(this.toFilter);
  @override
  List<Object?> get props => [toFilter];
}

class SearchKeywordScheduleEvent extends ScheduleEvent {

  final String keywordInput;

  SearchKeywordScheduleEvent(this.keywordInput);

  @override
  List<Object?> get props => [keywordInput];
  
}

class DeleteScheduleItemEvent extends ScheduleEvent{
  
  final int id;

  DeleteScheduleItemEvent(this.id);
  
  @override
  List<Object?> get props => [id];

}