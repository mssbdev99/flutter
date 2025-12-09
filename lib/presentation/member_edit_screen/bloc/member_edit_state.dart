import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rotary/data/models/selectionPopupModel/selection_popup_model.dart';
import 'package:rotary/presentation/member_edit_screen/models/member_edit_model.dart';
import 'package:rotary/presentation/member_list_page/models/member_item_model.dart';

// ignore: must_be_immutable
class MemberEditState extends Equatable{

  MemberEditState({
    this.nameController,
    this.addressController,
    this.icController,
    this.emailController,
    this.phoneController,
    this.selectedDropDownValue,
    this.memberEditModelObj,
    this.memberItemModelObj
  });

  TextEditingController? nameController;

  TextEditingController? addressController;

  TextEditingController? icController;

  TextEditingController? emailController;

  TextEditingController? phoneController;

  SelectionPopupModel? selectedDropDownValue;

  MemberEditModel? memberEditModelObj;

  MemberItemModel? memberItemModelObj;

  @override
  List<Object?> get props => [
        nameController,
        addressController,
        icController,
        emailController,
        phoneController,     
        selectedDropDownValue,
        memberEditModelObj,
        memberItemModelObj

      ];
  MemberEditState copyWith({
    TextEditingController? nameController,
    TextEditingController? addressController,
    TextEditingController? icController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
    SelectionPopupModel? selectedDropDownValue,
    MemberEditModel? memberEditModelObj,
    MemberItemModel? memberItemModelObj
    
  }) {
    return MemberEditState(
      nameController: nameController ?? this.nameController,
      addressController: addressController ?? this.addressController,
      icController: icController ?? this.icController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      selectedDropDownValue: selectedDropDownValue ?? this.selectedDropDownValue,
      memberEditModelObj: memberEditModelObj ?? this.memberEditModelObj,
      memberItemModelObj: memberItemModelObj ?? this.memberItemModelObj,
    );
  }

}