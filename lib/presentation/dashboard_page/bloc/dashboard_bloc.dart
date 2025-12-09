import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '../models/home_banner_model.dart';
import '../models/newsletter_model.dart';
import '../models/programs_model.dart';
import 'package:rotary/presentation/dashboard_page/models/dashboard_model.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(DashboardState initialState) : super(initialState) {
    on<DashboardInitialEvent>(_onInitialize);
    on<DashboardInitialDotEvent>(_updateDot);
  }

  List<HomeBannerItemModel> fillHomebannerItemList(){
    return [
      HomeBannerItemModel(
        imgBanner: ImageConstant.imgEducation, moto: "Basic Education and Literacy"
      ),
      HomeBannerItemModel(
        imgBanner: ImageConstant.imgWater, moto: "Water Sanitation, Hygiene"
      ),
      HomeBannerItemModel(
        imgBanner: ImageConstant.imgHealth, moto: "Maternal and Child Health"
      ),

    ];

  }

  List<NewsletterItemModel> fillNewsletterItemList() {
    return [     
      NewsletterItemModel(
          image: ImageConstant.imgNews01,
          url: "https://rotarymalaysia3300.org.my/index.php/about-3300/newsletters/23-24",
          newsRef: "Agust 2023 - Governor's Newsletter",
          ),
      NewsletterItemModel(
          image: ImageConstant.imgNews02,
          url: "https://rotarymalaysia3300.org.my/index.php/about-3300/newsletters/23-24",
          newsRef: "September 2023 - Rotary Bulletin",
          ),
      NewsletterItemModel(
          image: ImageConstant.imgNews03,
          url: "https://rotarymalaysia3300.org.my/index.php/about-3300/newsletters/23-24",
          newsRef: "October 2023 - District Bulletin",
          ),
    ];
  }

  List<ProgramsItemModel> fillProgramsItemList() {
    return [
      ProgramsItemModel(
          image: ImageConstant.imgProgram01,
          programRef: "Rotary Peace Fellowships",
          url: "https://www.rotary.org/en/our-programs/peace-fellowships",
          ),
      ProgramsItemModel(
          image: ImageConstant.imgProgram04,
          programRef: "Rotary Youth Leadership Awards (RYLA)",
          url: "https://www.rotary.org/en/our-programs/rotary-youth-leadership-awards"
          ),
      ProgramsItemModel(
          image: ImageConstant.imgProgram03,
          programRef: "New Generations Service Exchange",
          url: "https://www.rotary.org/en/our-programs/new-generations-service-exchange"
          ),
      ProgramsItemModel(
          image: ImageConstant.imgProgram02,
          programRef: "Scholarships",
          url: "https://www.rotary.org/en/our-programs/scholarships"
          ),
      ProgramsItemModel(
          image: ImageConstant.imgProgram05,
          programRef: "Rotary Community Corps",
          url: "https://www.rotary.org/en/our-programs/rotary-community-corps"
          ),
      ProgramsItemModel(
          image: ImageConstant.imgProgram04,
          programRef: "Rotary Youth Leadership Awards (RYLA)",
          url: "https://www.rotary.org/en/our-programs/rotary-youth-leadership-awards"
          ),
      ProgramsItemModel(
          image: ImageConstant.imgProgram03,
          programRef: "New Generations Service Exchange",
          url: "https://www.rotary.org/en/our-programs/new-generations-service-exchange"
          ),
      ProgramsItemModel(
          image: ImageConstant.imgProgram02,
          programRef: "Scholarships",
          url: "https://www.rotary.org/en/our-programs/scholarships"
          ),
      ProgramsItemModel(
          image: ImageConstant.imgProgram05,
          programRef: "Rotary Community Corps",
          url: "https://www.rotary.org/en/our-programs/rotary-community-corps"
          ),
    ];
  }

  _onInitialize(
    DashboardInitialEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(sliderIndex: 0));
    emit(state.copyWith(
        dashboardModelObj: state.dashboardModelObj?.copyWith(
            homeBannerItemList: fillHomebannerItemList(),
            newsletterItemList: fillNewsletterItemList(),
            programsItemList: fillProgramsItemList(),
            )));
  }

  _updateDot(DashboardInitialDotEvent event, Emitter<DashboardState> emit) {
    emit(state.copyWith(sliderIndex: event.index));
  }
}
