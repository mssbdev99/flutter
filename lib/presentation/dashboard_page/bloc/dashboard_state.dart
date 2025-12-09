// ignore_for_file: must_be_immutable

part of 'dashboard_bloc.dart';

/// Represents the state of Dashboard in the application.
class DashboardState extends Equatable {
  DashboardState({
    this.sliderIndex = 0,
    this.dashboardModelObj,
  });

  DashboardModel? dashboardModelObj;

  int sliderIndex;

  @override
  List<Object?> get props => [
        sliderIndex,
        dashboardModelObj,
      ];
  DashboardState copyWith({
    int? sliderIndex,
    DashboardModel? dashboardModelObj,
  }) {
    return DashboardState(
      sliderIndex: sliderIndex ?? this.sliderIndex,
      dashboardModelObj: dashboardModelObj ?? this.dashboardModelObj,
    );
  }
}
