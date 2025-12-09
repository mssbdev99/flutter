const String memberTable = 'member';

class MemberFields {
  static final List<String> values = [
    id,
    memberName,
    memberAddress,
    memberIC,
    memberEmail,
    memberPhone
  ];

  static const String id = 'id';
  static const String memberName = 'name';
  static const String memberAddress = 'address';
  static const String memberIC = 'ic';
  static const String memberEmail = 'email';
  static const String memberPhone = 'phone';
}

class MemberItemModel {
  MemberItemModel({
    this.memberName,
    this.memberAddress,
    this.memberIC,
    this.memberEmail,
    this.memberPhone,
    this.id,
  });

  MemberItemModel copy({
    String? memberName,
    String? memberAddress,
    String? memberIC,
    String? memberEmail,
    String? memberPhone,
    int? id,
  }) =>
      MemberItemModel(
        memberName: memberName ?? this.memberName,
        memberAddress: memberAddress ?? this.memberName,
        memberIC: memberIC ?? this.memberIC,
        memberEmail: memberEmail ?? this.memberEmail,
        memberPhone: memberPhone ?? this.memberPhone,
        id: id ?? this.id,
      );

  String? memberName;

  String? memberAddress;

  String? memberIC;

  String? memberEmail;

  String? memberPhone;

  int? id;

  static MemberItemModel fromJson(Map<String, Object?> json) =>
      MemberItemModel(
        id: json[MemberFields.id] as int?,
        memberName: json[MemberFields.memberName] as String,
        memberAddress: json[MemberFields.memberAddress] as String,
        memberIC: json[MemberFields.memberIC] as String,
        memberEmail: json[MemberFields.memberEmail] as String,
        memberPhone: json[MemberFields.memberPhone] as String,
      );

  Map<String, Object?> toJson() => {
        MemberFields.id: id,
        MemberFields.memberName: memberName,
        MemberFields.memberAddress: memberAddress,
        MemberFields.memberIC: memberIC,
        MemberFields.memberEmail: memberEmail,
        MemberFields.memberPhone: memberPhone,
      };
}
