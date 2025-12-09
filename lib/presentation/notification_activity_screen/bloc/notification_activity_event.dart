// ignore_for_file: must_be_immutable

part of 'notification_activity_bloc.dart';


@immutable
abstract class NotificationActivityEvent extends Equatable {}

/// Event that is dispatched when the NotificationActivity widget is first created.
class NotificationActivityInitialEvent extends NotificationActivityEvent {
  @override
  List<Object?> get props => [];
}
