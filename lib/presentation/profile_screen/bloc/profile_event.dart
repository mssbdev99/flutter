// ignore_for_file: must_be_immutable

part of 'profile_bloc.dart';


@immutable
abstract class ProfileEvent extends Equatable {}

/// Event that is dispatched when the Profile widget is first created.
class ProfileInitialEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class ProfileRefreshDataEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}
