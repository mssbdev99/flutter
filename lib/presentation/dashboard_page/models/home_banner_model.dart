
import 'package:rotary/core/utils/image_constant.dart';

/// This class is used in the [offerbanner_item_widget] screen.
class HomeBannerItemModel {
  HomeBannerItemModel({
    this.imgBanner,
    this.moto,
    this.id
    }) {
      imgBanner = imgBanner ?? ImageConstant.imgEducation;
      moto = moto ?? "Basic Education abd Literacy";
      id = id ?? "";
  }
  String? imgBanner;
  String? moto;
  String? id;
}
