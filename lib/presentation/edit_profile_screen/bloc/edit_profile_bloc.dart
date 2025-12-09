import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rotary/data/database_sqlite/database_helper.dart';
import 'package:rotary/presentation/login_screen/models/login_item_model.dart';
import '/core/app_export.dart';
import 'package:country_pickers/country.dart';
import 'package:rotary/presentation/edit_profile_screen/models/edit_profile_model.dart';
import 'package:rotary/data/models/me/get_me_resp.dart';
part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(EditProfileState initialState) : super(initialState) {
    on<EditProfileInitialEvent>(_onInitialize);
    on<ChangeDropDownEvent>(_changeDropDown);
    on<ChangeCountryEvent>(_changeCountry);
    on<ToUpdateProfileEvent>(_onToUpdateProfile);
    on<DobEvent>(_onDobDate);
  }

  //final _repository = Repository();
  var getMeResp = GetMeResp();

  _onInitialize(
    EditProfileInitialEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    
    final result = await DatabaseService.instance.ReadOneRow('profile');
    ProfileItemModel profile = ProfileItemModel.fromJson(result);

    print(profile.id);
    print(profile.country);
    print(profile.dob);
    print(result);
    emit(state.copyWith(
        id: profile.id,
        nameController: TextEditingController(text: profile.name),
        dateController: profile.dob,
        emailController: TextEditingController(text: profile.email),
        phoneNumberController: TextEditingController(text: profile.phone),
        countryController: profile.country 
        ));
    
    emit(state.copyWith(
        editProfileModelObj: state.editProfileModelObj?.copyWith(
            dropdownItemList: fillDropdownItemList())));
    
  }

  _onDobDate(DobEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(dateController: event.dobDate));
  }

  _changeDropDown(
    ChangeDropDownEvent event,
    Emitter<EditProfileState> emit,
  ) {
    emit(state.copyWith(selectedDropDownValue: event.value));
  }

  _changeCountry(
    ChangeCountryEvent event,
    Emitter<EditProfileState> emit,
  ) {
    print(event.value.name);
    emit(state.copyWith(selectedCountry: event.value));
  }

  _onToUpdateProfile(ToUpdateProfileEvent event, Emitter<EditProfileState> emit) async {
    await DatabaseService.instance.update(profileTable, event.itemToUpdate!.toJson());
  }

  List<SelectionPopupModel> fillDropdownItemList() {
    return [
      SelectionPopupModel(id: 1, title: "Malaysia", isSelected: true),
      SelectionPopupModel(id: 2, title: "Singapore"),
      SelectionPopupModel(id: 3, title: "Brunei")
    ];
  }

}
