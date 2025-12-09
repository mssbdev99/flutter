import 'package:rotary/presentation/schedule_page/models/schedule_item_model.dart';
import 'package:rotary/widgets/app_bar/appbar_leading_iconbutton_one.dart';
import 'package:rotary/widgets/app_bar/custom_app_bar.dart';
import 'package:rotary/widgets/custom_icon_button_one.dart';
import 'bloc/schedule_screen_bloc.dart';
import 'dart:async';
import 'package:rotary/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

// ignore_for_file: must_be_immutable
class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({Key? key}) : super(key: key);

  Completer<GoogleMapController> googleMapController = Completer();
  //LatLng targetLocation = LatLng(0, 0);

  static Widget builder(BuildContext context) {
    return BlocProvider<ScheduleScreenBloc>(
        create: (context) => ScheduleScreenBloc(
            ScheduleScreenState(scheduleScreenModelObj: ScheduleItemModel()))
          ..add(ScheduleScreenGetEvent(PrefUtils().getLocation())),
        child: ScheduleScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _buildViewOnMap(context)));
  }

  /// Section Widget
  Widget _buildViewOnMap(BuildContext context) {
    return BlocBuilder<ScheduleScreenBloc, ScheduleScreenState>(
        builder: (context, state) {
      if (state.latitude != null) {
        
        LatLng targetLocation = LatLng(state.latitude!, state.longitude!);

        Set<Marker> markers = Set.from([
          Marker(
            markerId: MarkerId('targetLocation'),
            position: targetLocation,
          ),
        ]);
        return SizedBox(
            height: SizeUtils.height,
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: targetLocation,
                    zoom: 12,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    googleMapController.complete(controller);
                  },
                  markers: markers,
                  myLocationEnabled: true,
                ),
                Positioned(
                    top: 10, left: 5, right: 10, child: _buildAppBar(context)),
                Positioned(child: _buildLocationDetail(context)),
              ],
            ));
      } else {
        return _getLatLog(
                context, state.scheduleScreenModelObj!.eventLocation);
      }
    });
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 65.v,
      centerTitle: true,
      title: Column(children: [
        Padding(
            padding: EdgeInsets.only(left: 5.h, right: 5.h),
            child: Row(children: [
              AppbarLeadingIconbuttonOne(
                margin: EdgeInsets.all(10.h),
                imagePath: ImageConstant.imgArrowLeft,
                onTap: () {
                  onTapArrowLeft(context);
                },
              ),
            ])),
      ]),
    );
  }

  Widget _buildLocationDetail(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Container(
          height: 150.v,
          width: 350.h,
          padding: EdgeInsets.all(10.h),
          decoration: IconButtonStyleHelperOne.fillWhiteB.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder8,
          ),
          child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 8.h,
                vertical: 7.v,
              ),
              child: BlocBuilder<ScheduleScreenBloc, ScheduleScreenState>(
                builder: ((context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Locations Details",
                        style: CustomTextStyles.titleMedium_1,
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomIconButtonOne(
                            height: 50.adaptSize,
                            width: 50.adaptSize,
                            decoration:
                                IconButtonStyleHelperOne.fillBlueGrayTL17,
                            child: CustomImageView(
                              margin: EdgeInsets.all(10.h),
                              fit: BoxFit.cover,
                              imagePath: ImageConstant.imgLocation,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20.v),
                            width: 250.h,
                            child: Text(
                                "${state.scheduleScreenModelObj?.eventLocation}",
                                maxLines: 4,
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall!.copyWith(
                                    color: appTheme.blueGray300, height: 1.80)),
                          )
                        ],
                      ),
                    ],
                  );
                }),
              )),
        ),
      ),
    );
  }

  ///Navigation
  onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }

  Widget _getLatLog(BuildContext context, String? locationName) {
    return FutureBuilder<List<Location>>(
      future: locationFromAddress(locationName ?? ''),
      builder: (BuildContext context, AsyncSnapshot<List<Location>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Align(child: CircularProgressIndicator(),);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          context.read<ScheduleScreenBloc>().add(GetLocationLat(
              snapshot.data![0].latitude, snapshot.data![0].longitude));
          return Text('Latitude: ${snapshot.data![0].latitude}');
        }
      },
    );
  }
}
