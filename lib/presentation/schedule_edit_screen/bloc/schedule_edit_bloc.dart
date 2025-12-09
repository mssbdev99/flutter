import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rotary/data/database_sqlite/database_helper.dart';
import 'package:rotary/presentation/schedule_edit_screen/bloc/schedule_edit_event.dart';
import 'package:rotary/presentation/schedule_edit_screen/bloc/schedule_edit_state.dart';
import 'package:rotary/presentation/schedule_page/models/schedule_item_model.dart';

class ScheduleEditBloc extends Bloc<ScheduleEditEvent, ScheduleEditState> {
  ScheduleEditBloc(ScheduleEditState initialState) : super(initialState) {
    on<GetItemScheduleDetail>(_onInitialize);
    on<ToUpdateScheduleEvent>(_onToUpdateSchedule);
  }

  _onInitialize(
    GetItemScheduleDetail event,
    Emitter<ScheduleEditState> emit,
  ) async {
    
    Map<String, dynamic> schedule = await DatabaseService.instance.readItem(eventTable, event.id);
    ScheduleItemModel scheduleEvent = ScheduleItemModel.fromJson(schedule);

    String formattedStartDate = DateFormat('dd/MM/yyyy hh:mm a').format(scheduleEvent.eventStart ?? DateTime.now());
    String formattedEndDate = DateFormat('dd/MM/yyyy hh:mm a').format(scheduleEvent.eventEnd ?? DateTime.now());
    print(scheduleEvent.eventStart);
    print(scheduleEvent.eventEnd);

    emit(state.copyWith(scheduleItemModelObj: scheduleEvent));
    emit(state.copyWith(
        label1Controller: TextEditingController(text: scheduleEvent.eventName),
        label2Controller: TextEditingController(text: scheduleEvent.eventLocation),
        clubController: TextEditingController(text: scheduleEvent.eventClub),
        startController: TextEditingController(text: formattedStartDate),
        endController: TextEditingController(text: formattedEndDate),
        ));
  }
    
  _onToUpdateSchedule(ToUpdateScheduleEvent event, Emitter<ScheduleEditState> emit) async {
    await DatabaseService.instance.update(eventTable, event.itemToUpdate!.toJson());
  }
}