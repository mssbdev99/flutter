// ignore_for_file: must_be_immutable

part of 'edit_profile_bloc.dart';


@immutable
abstract class EditProfileEvent extends Equatable {}


class EditProfileInitialEvent extends EditProfileEvent {
  @override
  List<Object?> get props => [];
}

class FetchMeEvent extends EditProfileEvent {
  FetchMeEvent({this.onFetchMeEventError});

  Function? onFetchMeEventError;

  @override
  List<Object?> get props => [
        onFetchMeEventError,
      ];
}

///event for dropdown selection
class ChangeDropDownEvent extends EditProfileEvent {
  ChangeDropDownEvent({required this.value});

  SelectionPopupModel value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing country code
class ChangeCountryEvent extends EditProfileEvent {
  ChangeCountryEvent({required this.value});

  Country value;

  @override
  List<Object?> get props => [
        value,
      ];
}

class ToUpdateProfileEvent extends EditProfileEvent {
  final ProfileItemModel? itemToUpdate;

  ToUpdateProfileEvent({this.itemToUpdate});

  @override
  List<Object?> get props => [itemToUpdate];
}

class GetItemProfileDetail extends EditProfileEvent {
  final int id;

  GetItemProfileDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class DobEvent extends EditProfileEvent {
  DateTime dobDate;

  DobEvent(this.dobDate);

  @override
  List<Object?> get props => [dobDate];

}