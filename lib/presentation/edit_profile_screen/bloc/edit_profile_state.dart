// ignore_for_file: must_be_immutable

part of 'edit_profile_bloc.dart';


class EditProfileState extends Equatable {
  EditProfileState({
    this.id,
    this.nameController,
    this.dateController,
    this.emailController,
    this.phoneNumberController,
    this.countryController,
    this.selectedDropDownValue,
    this.selectedCountry,
    this.editProfileModelObj,
  });

  int? id;

  TextEditingController? nameController;

  DateTime? dateController;

  TextEditingController? emailController;

  TextEditingController? phoneNumberController;

  String? countryController;

  SelectionPopupModel? selectedDropDownValue;

  EditProfileModel? editProfileModelObj;

  Country? selectedCountry;

  @override
  List<Object?> get props => [
        id,
        nameController,
        dateController,
        emailController,
        phoneNumberController,
        countryController,
        selectedDropDownValue,
        selectedCountry,
        editProfileModelObj,
      ];
  EditProfileState copyWith({
    int? id,
    TextEditingController? nameController,
    DateTime? dateController,
    TextEditingController? emailController,
    TextEditingController? phoneNumberController,
    String? countryController,
    SelectionPopupModel? selectedDropDownValue,
    Country? selectedCountry,
    EditProfileModel? editProfileModelObj,
  }) {
    return EditProfileState(
      id: id ?? this.id,
      nameController: nameController ?? this.nameController,
      dateController: dateController ?? this.dateController,
      emailController: emailController ?? this.emailController,
      phoneNumberController: phoneNumberController ?? this.phoneNumberController,
      countryController: countryController ?? this.countryController,
      selectedDropDownValue:
          selectedDropDownValue ?? this.selectedDropDownValue,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      editProfileModelObj: editProfileModelObj ?? this.editProfileModelObj,
    );
  }
}
