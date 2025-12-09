import 'package:rotary/presentation/dashboard_page/dashboard_page.dart';
import 'package:rotary/presentation/member_list_page/member_list_page.dart';
import 'package:rotary/presentation/notification_activity_screen/notification_activity_screen.dart';
import 'package:rotary/presentation/profile_screen/profile_screen.dart';
import 'package:rotary/presentation/schedule_page/schedule_page.dart';
import 'bloc/dashboard_container_bloc.dart';
import 'models/dashboard_container_model.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/app_export.dart';
import 'package:rotary/widgets/custom_bottom_bar.dart';

// ignore_for_file: must_be_immutable
class DashboardContainerScreen extends StatelessWidget {
  DashboardContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    return BlocProvider<DashboardContainerBloc>(
        create: (context) => DashboardContainerBloc(DashboardContainerState(
            dashboardContainerModelObj: DashboardContainerModel()))
          ..add(DashboardContainerInitialEvent()),
        child: DashboardContainerScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardContainerBloc, DashboardContainerState>(
        builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              body: Navigator(
                  key: navigatorKey,
                  initialRoute: AppRoutes.dashboardPage,
                  onGenerateRoute: (routeSetting) => PageRouteBuilder(
                      pageBuilder: (ctx, ani, ani1) =>
                          getCurrentPage(context, routeSetting.name!),
                      transitionDuration: Duration(seconds: 0))),
              bottomNavigationBar: _buildBottomBar(context)));
    });
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    print(type);
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.dashboardPage;
      
      case BottomBarEnum.Event:
        return AppRoutes.eventsPage;
      
      case BottomBarEnum.Members:
        return AppRoutes.memberPage;
      
      case BottomBarEnum.Acivity:
        return AppRoutes.notificationActivityScreen;
      
      case BottomBarEnum.Profile:
        return AppRoutes.profileScreen;
      
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.dashboardPage:
        return DashboardPage.builder(context);
      
      case AppRoutes.profileScreen:
        return ProfilePage.builder(context);
      
      case AppRoutes.notificationActivityScreen:
        return NotificationActivityPage.builder(context);

      case AppRoutes.memberPage:
        return MemberPage.builder(context);

      case AppRoutes.eventsPage:
        return SchedulePage.builder(context);
      
      default:
        return DefaultWidget();
    }
  }
}
