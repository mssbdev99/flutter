part of 'login_bloc.dart';


@immutable
abstract class LoginEvent extends Equatable {}

class LoginInitialEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginGetTableEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginGetEmailEvent extends LoginEvent {
  final TextEditingController emailAddress;

  LoginGetEmailEvent(this.emailAddress);

  @override
  List<Object?> get props => [emailAddress];
}

class LoginGetPasswordEvent extends LoginEvent {
  final TextEditingController emailPassword;

  LoginGetPasswordEvent(this.emailPassword);

  @override
  List<Object?> get props => [emailPassword];
}

class AddUserProfileEvent extends LoginEvent {
  
  final String? profileName;
  final String? profileEmail;
  final DateTime? profileDOB;
  final String? profileCountry;
  final String? profilePhone;

  AddUserProfileEvent(
      {this.profileName,
      this.profileEmail,
      this.profileDOB,
      this.profileCountry,
      this.profilePhone});
  
  @override
  List<Object?> get props => [profileName,profileEmail, profileDOB, profileCountry, profilePhone];
}
