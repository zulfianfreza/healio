class UserModel {
  final String id;
  final String email;
  final String name;
  final String gender;
  final String dateOfBirth;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
  });

  factory UserModel.fromJson(String id, Map<String, dynamic> json) => UserModel(
        id: id,
        email: json['email'],
        name: json['name'],
        gender: json['gender'],
        dateOfBirth: json['date_of_birth'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'gender': gender,
        'date_of_birth': dateOfBirth,
      };
}
