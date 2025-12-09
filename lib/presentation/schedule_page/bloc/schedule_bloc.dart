import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/app_export.dart';
import 'package:rotary/data/database_sqlite/database_helper.dart';
import 'package:rotary/presentation/schedule_page/models/schedule_item_model.dart';
import 'package:rotary/presentation/schedule_page/models/schedule_model.dart';
part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(ScheduleState initialState) : super(initialState) {
    on<ScheduleInitialEvent>(_onInitialize);
    on<ScheduleGetIdEvent>(_onGetItemId);
    on<FilterByDate>(_onFilterByDate);
    on<SearchKeywordScheduleEvent>(_onSearchScheduleItem);
    on<DeleteScheduleItemEvent>(_onDeleteSchedule);
  }

  _onInitialize(
    ScheduleInitialEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    print("Calling to refresh");
    List<ScheduleItemModel> schedule = await _getAllItems();
    
    emit(state.copyWith(searchController: TextEditingController()));
    emit(state.copyWith(
        scheduleModelObj:
            state.scheduleModelObj?.copyWith(scheduleItemList: schedule)));
    
  }

  _onGetItemId(ScheduleGetIdEvent event, Emitter<ScheduleState> emit) async {
    PrefUtils().setLocation('locationData', event.id);
  }

  _onFilterByDate(FilterByDate event, Emitter<ScheduleState> emit) async {
    List<ScheduleItemModel> scheduleFilter =
        await _getFilterItems(event.toFilter);

    emit(state.copyWith(
        scheduleModelObj: state.scheduleModelObj
            ?.copyWith(scheduleItemList: scheduleFilter)));
  }

  _onSearchScheduleItem(
      SearchKeywordScheduleEvent event, Emitter<ScheduleState> emit) async {
    List<ScheduleItemModel> scheduleSearch =
        await _getSearchItems(event.keywordInput);

    emit(state.copyWith(
        scheduleModelObj: state.scheduleModelObj
            ?.copyWith(scheduleItemList: scheduleSearch)));
  }

  _onDeleteSchedule(
      DeleteScheduleItemEvent event, Emitter<ScheduleState> emit) async {
    await DatabaseService.instance.delete(eventTable, event.id);
    add(ScheduleInitialEvent());
  }

  Future<List<ScheduleItemModel>> _getAllItems() async {
    print("Calling from database");
    final result = await DatabaseService.instance.readAllItem(eventTable);
    print(result);
    return result.map((item) => ScheduleItemModel.fromJson(item)).toList();
  }

  Future<List<ScheduleItemModel>> _getFilterItems(String toFilter) async {
    final result =
        await DatabaseService.instance.filterDate(eventTable, toFilter);
    return result.map((item) => ScheduleItemModel.fromJson(item)).toList();
  }

  Future<List<ScheduleItemModel>> _getSearchItems(String toSearch) async {
    final result = await DatabaseService.instance.searchSchedule(toSearch);
    return result.map((item) => ScheduleItemModel.fromJson(item)).toList();
  }
}
