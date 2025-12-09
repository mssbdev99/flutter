import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/constants/shared_pref.dart';
import '/core/app_export.dart';
import 'package:rotary/presentation/splash_screen/models/splash_model.dart';
part 'splash_event.dart';
part 'splash_state.dart';

/// A bloc that manages the state of a Splash according to the event that is dispatched to it.
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(SplashState initialState) : super(initialState) {
    on<SplashInitialEvent>(_onInitialize);
  }

  _onInitialize(
    SplashInitialEvent event,
    Emitter<SplashState> emit,
  ) async {
    Future.delayed(const Duration(milliseconds: 0), () {
      print(AppConstant.STORAGE_USER_TOKEN_KEY);
      print(PrefUtils().getIsLoggedIn());
      bool isLoggedin = PrefUtils().getIsLoggedIn();
      if(isLoggedin){
        NavigatorService.popAndPushNamed(
        AppRoutes.dashboardContainerScreen);
      }else{
        NavigatorService.popAndPushNamed(
        AppRoutes.loginScreen,
      );
      }
      
    });
  }
}
