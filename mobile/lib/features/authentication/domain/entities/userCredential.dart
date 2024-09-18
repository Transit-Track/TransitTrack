import 'package:equatable/equatable.dart';

class UserCredential extends Equatable {
  final String id;
  final String? email;
  final String fullName;
  final String? password;
  final String phoneNumber;
  final String? otp;
  final String? token;
  final String? profileAvatar;
  final String? role;

  const UserCredential({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    this.email,
    this.password,
    this.otp,
    this.token,
    this.profileAvatar,
    this.role,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        phoneNumber,
        fullName,
        role
      ];

  UserCredential copyWith({
    String? id,
    String? email,
    String? phoneNumber,
    String? fullName,
    String? password,
    String? otp,
    String? token,
  }) {

    return UserCredential(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      otp: otp ?? this.otp,
      token: token ?? this.token,
    );
  }
}
