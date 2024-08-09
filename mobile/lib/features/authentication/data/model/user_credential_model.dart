import 'package:transittrack/features/authentication/domain/entities/userCredential.dart';

class UserCredentialModel extends UserCredential {
  const  UserCredentialModel({
    required super.id,
    required  super.fullName,
    required super.phoneNumber,
    required super.password,
    super.email, 
    super.profileAvatar,
    super.otp,
    super.token,
  });

  factory UserCredentialModel.fromJson(Map<String, dynamic> json) {
    return UserCredentialModel(
      id: json['_id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'], 
      profileAvatar: json['profileAvatar'], 
      otp: json['otp'], 
      token: json['token'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
    };
  }
}
