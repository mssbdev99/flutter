import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rotary/presentation/notification_activity_screen/models/notification_activity_model.dart';
part 'notification_activity_event.dart';
part 'notification_activity_state.dart';


class NotificationActivityBloc
    extends Bloc<NotificationActivityEvent, NotificationActivityState> {
  NotificationActivityBloc(NotificationActivityState initialState)
      : super(initialState) {
    on<NotificationActivityInitialEvent>(_onInitialize);
  }

  _onInitialize(
    NotificationActivityInitialEvent event,
    Emitter<NotificationActivityState> emit,
  ) async {}
}
