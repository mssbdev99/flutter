// ignore_for_file: must_be_immutable

part of 'dashboard_container_bloc.dart';


@immutable
abstract class DashboardContainerEvent extends Equatable {}


class DashboardContainerInitialEvent extends DashboardContainerEvent {
  @override
  List<Object?> get props => [];
}
