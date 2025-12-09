import 'package:flutter/material.dart';
import 'package:rotary/presentation/edit_profile_screen/edit_profile_screen.dart';
import 'package:rotary/presentation/member_edit_screen/member_edit_screen.dart';
import 'package:rotary/presentation/member_list_page/member_list_page.dart';
import 'package:rotary/presentation/schedule_edit_screen/schedule_edit_screen.dart';
import 'package:rotary/presentation/schedule_page/schedule_page.dart';
import 'package:rotary/presentation/splash_screen/splash_screen.dart';
import 'package:rotary/presentation/login_screen/login_screen.dart';
import 'package:rotary/presentation/register_screen/register_screen.dart';
import 'package:rotary/presentation/dashboard_container_screen/dashboard_container_screen.dart';
import 'package:rotary/presentation/change_password_screen/change_password_screen.dart';
import 'package:rotary/presentation/schedule_screen/schedule_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String loginScreen = '/login_screen';

  static const String registerScreen = '/register_screen';

  static const String dashboardPage = '/dashboard_page';

  static const String dashboardContainerScreen = '/dashboard_container_screen';

  static const String notificationActivityScreen = '/notification_activity_screen';

  static const String eventsPage = '/schedule_page';

  static const String memberPage = '/member_list_page';

  static const String eventContainerPage = '/events_tab_container_page';

  static const String eventDetailsScreen = '/schedule_screen';

  static const String searchScreen = '/search_screen';

  static const String searchResultScreen = '/search_result_screen';

  static const String profileScreen = '/profile_screen';

  static const String editProfileScreen = '/edit_profile_screen';

  static const String addFormPage = '/database_container_page';

  static const String appTest = '/test_database';

  static const String appMemberFillForm = '/member_form_screen';

  static const String appMemberEditForm = '/member_edit_screen';

  static const String appScheduleFillForm = '/schedule_form_screen';

  static const String appScheduleEditForm = '/schedule_edit_screen';

  static const String changePasswordScreen = '/change_password_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes => {
        splashScreen: SplashScreen.builder,
        loginScreen: LoginScreen.builder,
        registerScreen: RegisterScreen.builder,
        dashboardContainerScreen: DashboardContainerScreen.builder,
        editProfileScreen: EditProfileScreen.builder,
        memberPage: MemberPage.builder,
        appMemberEditForm: MemberEditScreen.builder,
        eventsPage: SchedulePage.builder,
        appScheduleEditForm: ScheduleEditScreen.builder,
        eventDetailsScreen: ScheduleScreen.builder,
        changePasswordScreen: ChangePasswordScreen.builder,
        initialRoute: SplashScreen.builder
      };
}
