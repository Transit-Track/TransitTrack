import 'package:transittrack/features/authentication/domain/entities/userCredential.dart';

class UserCredentialModel extends UserCredential {
  const UserCredentialModel({
    required super.id,
    required super.fullName,
    required super.phoneNumber,
   super.password,
    super.email,
    super.profileAvatar,
    super.otp,
    super.token,
    super.role,
  });

  factory UserCredentialModel.fromJson(Map<String, dynamic> json) {
    return UserCredentialModel(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      password: json['hashed_password'] ?? '',
      profileAvatar: json['image_url'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'phone_number': phoneNumber,
      'email': email,
      'password': password,
      'token': token,
      'image_url': profileAvatar,
    };
  }
}
