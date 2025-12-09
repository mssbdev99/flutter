import 'dart:math';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/newsletter_widget.dart';
import 'widgets/programs_widget.dart';
import 'widgets/home_banner_widget.dart';
import 'bloc/dashboard_bloc.dart';
import 'models/dashboard_model.dart';
import 'models/newsletter_model.dart';
import 'models/programs_model.dart';
import 'models/home_banner_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/app_export.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<DashboardBloc>(
        create: (context) =>
            DashboardBloc(DashboardState(dashboardModelObj: DashboardModel()))
              ..add(DashboardInitialEvent()),
        child: DashboardPage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                child: SingleChildScrollView(
                    child: Column(children: [
                  _buildHomeBanner(context),
                  SizedBox(
                    height: 16.v,
                  ),
                  BlocBuilder<DashboardBloc, DashboardState>(
                      builder: (context, state) {
                    return SizedBox(
                        height: 8.v,
                        child: AnimatedSmoothIndicator(
                            activeIndex: state.sliderIndex,
                            count: state.dashboardModelObj?.homeBannerItemList
                                    .length ??
                                0,
                            axisDirection: Axis.horizontal,
                            effect: ScrollingDotsEffect(
                                spacing: 8,
                                activeDotColor:
                                    theme.colorScheme.primary.withOpacity(1),
                                dotColor: appTheme.blue50,
                                dotHeight: 8.v,
                                dotWidth: 8.h)));
                  }),
                  SizedBox(height: 25.v),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: _buildNewsletterProgramsHeader(context,
                          headerText: "Newsletter",
                          //seeMoreText: "See More",
                          onTapSeeMoreText: () {
                        //onTapNewsletter(context);
                      })),
                  SizedBox(height: 12.v),
                  _buildNewsletter(context),
                  SizedBox(height: 23.v),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: _buildNewsletterProgramsHeader(context,
                          headerText: "Programs",
                          //seeMoreText: "See More",
                          onTapSeeMoreText: () {
                        //onTapProgramsletter(context);
                      })),
                  SizedBox(height: 10.v),
                  _buildPrograms(context),
                  SizedBox(height: 50.v),
                ])))));
  }

  ///Section Widget
  Widget _buildHomeBanner(BuildContext context) {
    return SizedBox(
      height: 297.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
            return CarouselSlider.builder(
                options: CarouselOptions(
                    height: 297.v,
                    initialPage: 0,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      context
                          .read<DashboardBloc>()
                          .add(DashboardInitialDotEvent(index));
                    }),
                itemCount:
                    state.dashboardModelObj?.homeBannerItemList.length ?? 0,
                itemBuilder: (context, index, realIndex) {
                  HomeBannerItemModel model =
                      state.dashboardModelObj?.homeBannerItemList[index] ??
                          HomeBannerItemModel();
                  return HomeBannerItemWidget(model);
                });
          }),
        ],
      ),
    );
  }

  Widget _buildNewsletter(BuildContext context) {
    return SizedBox(
      height: 195.v,
      child: BlocSelector<DashboardBloc, DashboardState, DashboardModel?>(
          selector: (state) => state.dashboardModelObj,
          builder: (context, dashboardModelObj) {
            return ListView.separated(
              padding: EdgeInsets.only(left: 16.h),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(width: 16.h);
              },
              itemCount:
                  min(5, dashboardModelObj?.newsletterItemList.length ?? 0) + 2,
              itemBuilder: (context, index) {
                if (index <
                    min(5, dashboardModelObj?.newsletterItemList.length ?? 0)) {
                  NewsletterItemModel model =
                      dashboardModelObj?.newsletterItemList[index] ??
                          NewsletterItemModel();
                  return NewsletterItemWidget(model, onTapNewsItem: () {
                    onTaphURL(context, model.url);
                  });
                } else {
                  return null;
                }
              },
            );
          }),
    );
  }

  Widget _buildPrograms(BuildContext context) {
    return SizedBox(
      height: 195.v,
      child: BlocSelector<DashboardBloc, DashboardState, DashboardModel?>(
          selector: (state) => state.dashboardModelObj,
          builder: (context, dashboardModelObj) {
            return ListView.separated(
              padding: EdgeInsets.only(left: 16.h),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(width: 16.h);
              },
              itemCount:
                  min(5, (dashboardModelObj?.programsItemList.length ?? 0)) + 2,
              itemBuilder: (context, index) {
                if (index <
                    min(5, (dashboardModelObj?.programsItemList.length ?? 0))) {
                  ProgramsItemModel model =
                      dashboardModelObj?.programsItemList[index] ??
                          ProgramsItemModel();
                  return ProgramsItemWidget(
                    model,
                    onTapProgramItem: () {
                      onTaphURL(context, model.url);
                    },
                  );
                } else {
                  return null;
                }
              },
            );
          }),
    );
  }

  Widget _buildNewsletterProgramsHeader(
    BuildContext context, {
    required String headerText,
    //required String seeMoreText,
    Function? onTapHeader,
    Function? onTapSeeMoreText,
  }) {
    return GestureDetector(
        onTap: () {
          onTapHeader!.call();
        },
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(headerText,
              style: theme.textTheme.titleSmall!
                  .copyWith(color: theme.colorScheme.onPrimary.withOpacity(1))),
          /*GestureDetector(
              onTap: () {
                onTapSeeMoreText!.call();
              },
              child: Text(seeMoreText,
                  style: CustomTextStyles.titleSmallPrimary.copyWith(
                      color: theme.colorScheme.primary.withOpacity(1))))*/
        ]));
  }

  /// Navigates.
  onTapSearchItems(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.searchScreen);
  }

  onTapNewsletter(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.searchScreen);
  }

  onTapProgramsletter(BuildContext context) {}

  Future<void> onTaphURL(BuildContext context, String? newsUrl) async {
    print(newsUrl);
    if (newsUrl != null) {
      final Uri _url = Uri.parse(newsUrl);
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }
  }
}
