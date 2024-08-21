import 'package:transittrack/features/authentication/domain/entities/userCredential.dart';

class UserCredentialModel extends UserCredential {
  const UserCredentialModel({
    required super.id,
    required super.fullName,
    required super.phoneNumber,
    required super.password,
    super.email,
    super.profileAvatar,
    super.otp,
    super.token,
  });

  factory UserCredentialModel.fromJson(Map<String, dynamic> json) {
    return UserCredentialModel(
      id: json['id'],
      fullName: json['full_name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      password: json['hashed_password'],
      // profileAvatar: json['profileAvatar'],
      // otp: json['otp'],
      token: json['auth_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'phone_number': phoneNumber,
      'email': email,
      'password': password,
      'token': token
    };
  }
}
