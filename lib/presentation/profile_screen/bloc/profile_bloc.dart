import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rotary/data/database_sqlite/database_helper.dart';
import 'package:rotary/presentation/login_screen/models/login_item_model.dart';
import 'package:rotary/presentation/member_list_page/models/member_item_model.dart';
import 'package:rotary/presentation/schedule_page/models/schedule_item_model.dart';
import '/core/app_export.dart';
import 'package:rotary/presentation/profile_screen/models/profile_model.dart';
part 'profile_event.dart';
part 'profile_state.dart';

/// A bloc that manages the state of a Profile according to the event that is dispatched to it.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(ProfileState initialState) : super(initialState) {
    on<ProfileInitialEvent>(_onInitialize);
    on<ProfileRefreshDataEvent>(_onRefreshData);
  }

  _onInitialize(
    ProfileInitialEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final result = await DatabaseService.instance.ReadOneRow(profileTable);

    ProfileItemModel profile = ProfileItemModel.fromJson(result);
    emit(state.copyWith(profileModelItemObj: profile));
  }

  _onRefreshData(ProfileRefreshDataEvent event, Emitter<ProfileState> emit) async {
    
    List<ScheduleItemModel> schedule = await getEventsItemList();

      for (var event in schedule) {
        await DatabaseService.instance
            .updateOrCreate('schedule', event.toJson(), 'name');
      }
    

    List<MemberItemModel> members = await getMembersItemList();

      for (var user in members) {
        print(user.toJson());
        await DatabaseService.instance
            .updateOrCreate('member', user.toJson(), 'name');
      }
  }
}

List<ScheduleItemModel> getEventsItemList() {
  return [
    ScheduleItemModel(
      eventName: "District Training Assembly",
      eventLocation: "Jalan Abdul Rahman, Taman Bunga Mawar, 84000 Muar, Johor",
      eventClub: "Rotary",
      eventStart: DateTime.now().subtract(Duration(days: 7)),
      eventEnd: DateTime.now().subtract(Duration(days: 7, hours: 2)),
    ),
    ScheduleItemModel(
      eventName: "Regional Team Learning Seminar",
      eventLocation:
          "Kelana Centre Point, No. 121, Block A, 19, SS7, 47301 Petaling Jaya, Selangor",
      eventClub: "Rotaract",
      eventStart: DateTime.now(),
      eventEnd: DateTime.now().add(Duration(hours: 2)),
    ),
    ScheduleItemModel(
      eventName: "Club Visit Damansara",
      eventLocation:
          "Level 3, Bangunan Sultan Salahuddin Abdul Aziz Shah 16 Jalan Utara Petaling Jaya, 46200 Selangor",
      eventClub: "Rotary",
      eventStart: DateTime.now().add(Duration(days: 1)),
      eventEnd: DateTime.now().add(Duration(days: 1, hours: 2)),
    ),
    ScheduleItemModel(
      eventName: "District Meeting",
      eventLocation: "22, Jalan Besar, 73000 Tampin, Negeri Sembilan",
      eventClub: "Rotaract",
      eventStart: DateTime.now().add(Duration(days: 1, hours: 2)),
      eventEnd: DateTime.now().add(Duration(days: 1, hours: 4)),
    ),
    ScheduleItemModel(
      eventName: "Club Meeting",
      eventLocation:
          "8, PJS 7/20A, Bandar Sunway, 47500 Petaling Jaya, Selangor",
      eventClub: "Rotary",
      eventStart: DateTime.now().add(Duration(days: 7)),
      eventEnd: DateTime.now().add(Duration(days: 7, hours: 2)),
    ),
    ScheduleItemModel(
      eventName: "Orphanage Visit",
      eventLocation:
          "Lot 16106, Jalan 13B, Salak South Baru, Desa Petaling, 57100 Kuala Lumpur",
      eventClub: "Rotaract",
      eventStart: DateTime.now().add(Duration(days: 7)),
      eventEnd: DateTime.now().add(Duration(days: 7, hours: 2)),
    ),
    ScheduleItemModel(
      eventName: "DG Club Visit Rahman Putra",
      eventLocation:
          "Jalan BRP 2/1, Bukit Rahman Putra, 47000 Sungai Buloh, Selangor",
      eventClub: "Rotary",
      eventStart: DateTime(
          DateTime.now().year, DateTime.now().month + 1, DateTime.now().day),
      eventEnd: DateTime(DateTime.now().year, DateTime.now().month + 1,
          DateTime.now().day, DateTime.now().hour + 2),
    ),
  ];
}

List<MemberItemModel> getMembersItemList() {
    return [
      MemberItemModel(
        memberName: "William Richard",
        memberAddress:
            "Jalan Abdul Rahman, Taman Bunga Mawar, 84000 Muar, Johor",
        memberIC: "701111117788",
        memberEmail: "william@gmail.com",
        memberPhone: "0123456789",
      ),
      MemberItemModel(
        memberName: "Charles Daniel",
        memberAddress:
            "Jalan Abdul Rahman, Taman Bunga Mawar, 84000 Muar, Johor",
        memberIC: "701111117799",
        memberEmail: "charles@gmail.com",
        memberPhone: "0123456789",
      ),
      MemberItemModel(
        memberName: "Sandra Ashley",
        memberAddress:
            "Jalan Abdul Rahman, Taman Bunga Mawar, 84000 Muar, Johor",
        memberIC: "701111117744",
        memberEmail: "sandra@gmail.com",
        memberPhone: "0123456789",
      ),
      MemberItemModel(
        memberName: "Kenneth Brian",
        memberAddress:
            "Jalan Abdul Rahman, Taman Bunga Mawar, 84000 Muar, Johor",
        memberIC: "701111117734",
        memberEmail: "kenneth@gmail.com",
        memberPhone: "0123456789",
      ),
      MemberItemModel(
        memberName: "Stephanie Margaret",
        memberAddress:
            "Jalan Abdul Rahman, Taman Bunga Mawar, 84000 Muar, Johor",
        memberIC: "701111117719",
        memberEmail: "stephanie@gmail.com",
        memberPhone: "0123456789",
      ),
    ];
  }