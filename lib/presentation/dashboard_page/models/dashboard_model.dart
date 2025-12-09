// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'home_banner_model.dart';
import 'newsletter_model.dart';
import 'programs_model.dart';


/// This class defines the variables used in the [dashboard_page],
/// and is typically used to hold data that is passed between different parts of the application.
class DashboardModel extends Equatable {
  DashboardModel({
    this.homeBannerItemList = const [],
    this.newsletterItemList = const [],
    this.programsItemList = const [],
  });

  List<HomeBannerItemModel> homeBannerItemList;
  List<NewsletterItemModel> newsletterItemList;
  List<ProgramsItemModel> programsItemList;

  DashboardModel copyWith({
    List<HomeBannerItemModel>? homeBannerItemList,
    List<NewsletterItemModel>? newsletterItemList,
    List<ProgramsItemModel>? programsItemList,    
  }) {
    return DashboardModel(
      homeBannerItemList: homeBannerItemList ?? this.homeBannerItemList,      
      newsletterItemList: newsletterItemList ?? this.newsletterItemList,
      programsItemList: programsItemList ?? this.programsItemList,      
    );
  }

  @override
  List<Object?> get props => [
        homeBannerItemList,        
        newsletterItemList,
        programsItemList,       
      ];
}
