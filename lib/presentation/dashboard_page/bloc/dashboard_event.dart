// ignore_for_file: must_be_immutable

part of 'dashboard_bloc.dart';


@immutable
abstract class DashboardEvent extends Equatable {}


class DashboardInitialEvent extends DashboardEvent {
  @override
  List<Object?> get props => [];
}

class DashboardInitialDotEvent extends DashboardEvent{
  
  final index;
  
  DashboardInitialDotEvent(this.index);
  
  @override
  List<Object?> get props => [index];
  
}
