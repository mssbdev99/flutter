import '../../../core/app_export.dart';

/// This class is used in the [megasale_item_widget] screen.
class ProgramsItemModel {
  ProgramsItemModel({
    this.image,
    this.programRef,
    this.url,
    this.id,
  }) {
    image = image ?? ImageConstant.imgProgram01;
    programRef = programRef ?? "Rotary Peace Fellowships";
    url = url ?? "https://rotarymalaysia3300.org.my/";
    id = id ?? "";
  }

  String? image;

  String? programRef;

  String? url;

  String? id;
}
