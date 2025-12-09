const String profileTable = 'profile';

class ProfileFields {
  static final List<String> values = [
    id,
    name,
    email,
    dob,
    country,
    phone
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';
  static const String dob = 'dob';
  static const String country = 'country';
  static const String phone = 'phone';
}

class ProfileItemModel {
  ProfileItemModel({
    this.name,
    this.email,
    this.dob,
    this.country,
    this.phone,
    this.id,
  });

  ProfileItemModel copy({
    String? name,
    String? email,
    DateTime? dob,
    String? country,
    String? phone,
    int? id,
  }) =>
      ProfileItemModel(
        name: name ?? this.name,
        email: email ?? this.email,
        dob: dob ?? this.dob,
        country: country ?? this.country,
        phone: phone ?? this.phone,
        id: id ?? this.id,
      );

  String? name;

  String? email;

  DateTime? dob;

  String? country;

  String? phone;

  int? id;

  static ProfileItemModel fromJson(Map<String, Object?> json) =>
      ProfileItemModel(
        id: json[ProfileFields.id] as int?,
        name: json[ProfileFields.name] as String,
        email: json[ProfileFields.email] as String,
        dob: DateTime.parse(json[ProfileFields.dob] as String),
        country: json[ProfileFields.country] as String,
        phone: json[ProfileFields.phone] as String,
      );

  Map<String, Object?> toJson() => {
        ProfileFields.id: id,
        ProfileFields.name: name,
        ProfileFields.email: email,
        ProfileFields.dob: dob?.toIso8601String(),
        ProfileFields.country: country,
        ProfileFields.phone: phone,
      };
}
