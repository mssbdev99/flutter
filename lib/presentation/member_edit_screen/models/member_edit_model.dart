// ignore: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:rotary/data/models/selectionPopupModel/selection_popup_model.dart';

// ignore: must_be_immutable
class MemberEditModel extends Equatable {
  MemberEditModel({
    this.dropdownItemClubList = const []
  }) {}

  List<SelectionPopupModel> dropdownItemClubList;

  MemberEditModel copyWith({
    List<SelectionPopupModel>? dropdownItemClubList
  }) {
    return MemberEditModel(
      dropdownItemClubList: dropdownItemClubList ?? this.dropdownItemClubList      
    );
  }

  @override
  List<Object?> get props => [dropdownItemClubList];
}