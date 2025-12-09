import '../../../core/app_export.dart';

/// This class is used in the [flashsale_item_widget] screen.
class NewsletterItemModel {
  NewsletterItemModel({
    this.image,
    this.newsRef,
    this.url,
    this.id,
  }) {
    image = image ?? ImageConstant.imgNews01;
    newsRef = newsRef ?? "July 2023 - Governor's Newsletter";
    url = url ?? "https://rotarymalaysia3300.org.my/";;
    id = id ?? "";
  }

  String? image;

  String? newsRef;

  String? url;

  String? id;
}
