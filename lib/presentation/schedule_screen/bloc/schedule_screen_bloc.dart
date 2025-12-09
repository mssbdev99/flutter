import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rotary/data/database_sqlite/database_helper.dart';
import 'package:rotary/presentation/schedule_page/models/schedule_item_model.dart';
import '/core/app_export.dart';
part 'schedule_screen_event.dart';
part 'schedule_screen_state.dart';

/// A bloc that manages the state of a ViewOnMap according to the event that is dispatched to it.
class ScheduleScreenBloc
    extends Bloc<ScheduleScreenEvent, ScheduleScreenState> {
  ScheduleScreenBloc(ScheduleScreenState initialState) : super(initialState) {
    on<ScheduleScreenGetEvent>(_onInitialize);
    on<GetLocationLat>(_onConvertLat);
  }

  _onInitialize(
      ScheduleScreenGetEvent event, Emitter<ScheduleScreenState> emit) async {
    ScheduleItemModel schedule = await _getOneItems(event.id);

    emit(state.copyWith(scheduleScreenModelObj: schedule));
  }

  Future<ScheduleItemModel> _getOneItems(int id) async {
    final result = await DatabaseService.instance.readItem(eventTable, id);
    return ScheduleItemModel.fromJson(result);
  }

  _onConvertLat(GetLocationLat event, Emitter<ScheduleScreenState> emit) {
    emit(state.copyWith(latitude: event.latitude, longitude: event.longitude));
  }
}
