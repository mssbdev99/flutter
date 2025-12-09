// ignore: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:rotary/data/models/selectionPopupModel/selection_popup_model.dart';

// ignore: must_be_immutable
class ScheduleEditModel extends Equatable {
  ScheduleEditModel({
    this.dropdownItemClubList = const []
  }) {}

  List<SelectionPopupModel> dropdownItemClubList;

  ScheduleEditModel copyWith({
    List<SelectionPopupModel>? dropdownItemClubList
  }) {
    return ScheduleEditModel(
      dropdownItemClubList: dropdownItemClubList ?? this.dropdownItemClubList      
    );
  }

  @override
  List<Object?> get props => [dropdownItemClubList];
}