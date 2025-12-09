// ignore_for_file: must_be_immutable

part of 'change_password_bloc.dart';


@immutable
abstract class ChangePasswordEvent extends Equatable {}


class ChangePasswordInitialEvent extends ChangePasswordEvent {
  @override
  List<Object?> get props => [];
}
