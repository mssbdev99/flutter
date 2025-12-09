import 'package:geocoding/geocoding.dart';
import 'package:rotary/core/app_export.dart';
import 'package:rotary/widgets/app_bar/appbar_title_searchview.dart';
import 'package:rotary/widgets/app_bar/custom_app_bar.dart';
import '../schedule_page/widgets/schedule_item_widget.dart';
import 'bloc/schedule_bloc.dart';
import 'models/schedule_item_model.dart';
import 'models/schedule_model.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  SchedulePageState createState() => SchedulePageState();

  static Widget builder(BuildContext context) {
    return BlocProvider<ScheduleBloc>(
        create: (context) =>
            ScheduleBloc(ScheduleState(scheduleModelObj: ScheduleModel()))
              ..add(ScheduleInitialEvent()),
        child: SchedulePage());
  }
}

class SchedulePageState extends State<SchedulePage>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 5, vsync: this);
    tabviewController.addListener(_handlerTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTabview(context),
                      SizedBox(height: 8.v),
                      Container(
                        height: 5.v,
                        color: appTheme.gray400.withOpacity(0.2),
                      ),
                      Expanded(
                          child: SizedBox(
                              child: TabBarView(
                                  controller: tabviewController,
                                  children: [
                            _buildSchedule(context),
                            _buildSchedule(context),
                            _buildSchedule(context),
                            _buildSchedule(context),
                            _buildSchedule(context)
                          ])))
                    ]))));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 70.h,
      title: BlocSelector<ScheduleBloc, ScheduleState, TextEditingController?>(
          selector: (state) => state.searchController,
          builder: (context, searchController) {
            return AppbarTitleSearchview(
              margin: EdgeInsets.all(15.h),
              controller: searchController,
              suffix: Padding(
                padding: EdgeInsets.only(
                  right: 2.h,
                ),
                child: IconButton(
                  onPressed: () {
                    searchController!.clear();
                    context.read<ScheduleBloc>().add(ScheduleInitialEvent());
                  },
                  icon: Icon(
                    Icons.clear,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              onTapSearchButton: (value) {
                print(value);
                context
                    .read<ScheduleBloc>()
                    .add(SearchKeywordScheduleEvent(value));
              },
            );
          }),
    );
  }

  /// Section Widget
  Widget _buildSchedule(BuildContext context) {
    
    return Padding(
        padding: EdgeInsets.all(15),
        child: BlocSelector<ScheduleBloc, ScheduleState, ScheduleModel?>(
            selector: (state) => state.scheduleModelObj,
            builder: (context, scheduleModelObj) {
              return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10.v);
                  },
                  itemCount: scheduleModelObj?.scheduleItemList.length ?? 0,
                  itemBuilder: (context, index) {
                    ScheduleItemModel model =
                        scheduleModelObj?.scheduleItemList[index] ??
                            ScheduleItemModel();
                    return ScheduleItemWidget(model,
                        onTapScheduleDetailButton: () {
                      context
                          .read<ScheduleBloc>()
                          .add(ScheduleGetIdEvent(model.id!));
                      onTapScheduleDetailButton(context);
                    });
                  });
            }));
  }

  Widget _buildTabview(BuildContext context) {
    return Container(
        height: 26.v,
        width: 400.h,
        child: TabBar(
            controller: tabviewController,
            onTap: ((value) {
              print(value);
            }),
            //isScrollable: true,
            labelColor: theme.colorScheme.primary,
            labelStyle:
                TextStyle(fontSize: 12.fSize, fontWeight: FontWeight.w700),
            unselectedLabelColor: appTheme.gray400,
            unselectedLabelStyle:
                TextStyle(fontSize: 12.fSize, fontWeight: FontWeight.w700),
            indicatorColor: theme.colorScheme.primary,
            tabs: [
              Tab(child: Text("Anytime".tr)),
              Tab(child: Text("Today".tr)),
              Tab(child: Text("Tomorrow".tr)),
              Tab(child: Text("Week".tr)),
              Tab(child: Text("Month".tr))
            ],
            labelPadding: EdgeInsets.only(left: 10.h, right: 10)));
  }

  /// Navigation
  onTapScheduleDetailButton(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.eventDetailsScreen,
    );
  }

  onTapGetLat(BuildContext context, String locationName) async {
    List<Location> locations = await locationFromAddress(locationName);
    print(locations[0].latitude);
  }

  void _handlerTabSelection() {
    if (tabviewController.indexIsChanging) {
      switch (tabviewController.index) {
        case 0:
          context.read<ScheduleBloc>().add(FilterByDate("Anytime"));
          break;

        case 1:
          context.read<ScheduleBloc>().add(FilterByDate("Today"));
          break;

        case 2:
          context.read<ScheduleBloc>().add(FilterByDate("Tomorrow"));
          break;

        case 3:
          context.read<ScheduleBloc>().add(FilterByDate("This Week"));
          break;

        case 4:
          context.read<ScheduleBloc>().add(FilterByDate("This Month"));
          break;
      }
    }
  }
}
