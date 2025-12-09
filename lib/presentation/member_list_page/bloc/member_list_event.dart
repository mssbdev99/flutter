// ignore_for_file: must_be_immutable

part of 'member_list_bloc.dart';

@immutable
abstract class MemberListEvent extends Equatable {}

class MemberListInitialEvent extends MemberListEvent {
  @override
  List<Object?> get props => [];
}


class DeleteMemberEvent extends MemberListEvent{
  final int id;

  DeleteMemberEvent(this.id);
  
  @override
  List<Object?> get props => [id];
  
}

class SearchKeywordMemberEvent extends MemberListEvent {

  final String keywordInput;

  SearchKeywordMemberEvent(this.keywordInput);

  @override
  List<Object?> get props => [keywordInput];
  
}