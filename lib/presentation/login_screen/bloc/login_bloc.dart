import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rotary/data/database_sqlite/database_helper.dart';
import 'package:rotary/presentation/login_screen/models/login_item_model.dart';
import 'package:rotary/presentation/member_list_page/models/member_item_model.dart';
import 'package:rotary/presentation/schedule_page/models/schedule_item_model.dart';
import '/core/app_export.dart';
import 'package:rotary/presentation/login_screen/models/login_model.dart';
part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState) {
    on<LoginInitialEvent>(_onInitialize);
    on<LoginGetEmailEvent>(_onGetEmail);
    on<LoginGetPasswordEvent>(_onGetPassword);
    on<LoginGetTableEvent>(_onGetTable);
    on<AddUserProfileEvent>(_onAddUserProfile);
  }

  _onInitialize(
    LoginInitialEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
        emailController: TextEditingController(),
        passwordController: TextEditingController()));
  }

  void _onGetEmail(LoginGetEmailEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(emailController: event.emailAddress));
  }

  void _onGetPassword(LoginGetPasswordEvent event, Emitter<LoginState> emit) {}

  void _onGetTable(LoginGetTableEvent event, Emitter<LoginState> emit) async {
    await DatabaseService.instance.deleteTable('schedule');
    await DatabaseService.instance.deleteTable('member');

    if (await DatabaseService.instance.checkOneTable('schedule')) {
      print("table exist");
    } else {
      String table =
          'CREATE TABLE schedule(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, location TEXT NOT NULL, club TEXT NOT NULL, start TEXT NOT NULL, end TEXT NOT NULL)';
      await DatabaseService.instance.createTable(table);

      List<ScheduleItemModel> users = await getEventsItemList();

      for (var user in users) {
        print(user.toJson());
        await DatabaseService.instance
            .updateOrCreate('schedule', user.toJson(), 'name');
      }
    }

    if (await DatabaseService.instance.checkOneTable('member')) {
      print("table exist");
    } else {
      String table =
          'CREATE TABLE member(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, address TEXT NOT NULL, ic TEXT NOT NULL, email TEXT NOT NULL, phone TEXT NOT NULL)';
      await DatabaseService.instance.createTable(table);

      List<MemberItemModel> users = await getMembersItemList();

      for (var user in users) {
        print(user.toJson());
        await DatabaseService.instance
            .updateOrCreate('member', user.toJson(), 'name');
      }
    }
  }

  _onAddUserProfile(AddUserProfileEvent event, Emitter<LoginState> emit) async {
    await DatabaseService.instance.deleteTable('profile');

    if (await DatabaseService.instance.checkOneTable('profile')) {
      print("table exist");
    } else {
      String table =
          'CREATE TABLE profile(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, email TEXT NOT NULL, dob TEXT NOT NULL, country TEXT NOT NULL, phone TEXT NOT NULL)';
      await DatabaseService.instance.createTable(table);
      await DatabaseService.instance.create(
        profileTable,
        ProfileItemModel(
          name: event.profileName,
          email: event.profileEmail,
          dob: DateTime.now(),
          country: event.profileCountry ?? "",
          phone: event.profilePhone ?? "",
        ).toJson(),
      );
    }
  }

  List<ScheduleItemModel> getEventsItemList() {
    return [
      ScheduleItemModel(
        eventName: "District Training Assembly",
        eventLocation:
            "Jalan Abdul Rahman, Taman Bunga Mawar, 84000 Muar, Johor",
        eventClub: "Rotary",
        eventStart: DateTime.now().subtract(Duration(days: 7)),
        eventEnd: DateTime.now().subtract(Duration(days: 7, hours: 2)),
      ),
      ScheduleItemModel(
        eventName: "Regional Team Learning Seminar",
        eventLocation:
            "Kelana Centre Point, No. 121, Block A, 19, SS7, 47301 Petaling Jaya, Selangor",
        eventClub: "Rotary",
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
}
