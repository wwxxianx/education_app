// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBankAccount _$UserBankAccountFromJson(Map<String, dynamic> json) =>
    UserBankAccount(
      detailsSubmitted: json['detailsSubmitted'] as bool,
      id: json['id'] as String,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      userId: json['userId'] as String,
      payoutsEnabled: json['payoutsEnabled'] as bool,
      chargesEnabled: json['chargesEnabled'] as bool,
      email: json['email'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$UserBankAccountToJson(UserBankAccount instance) =>
    <String, dynamic>{
      'detailsSubmitted': instance.detailsSubmitted,
      'id': instance.id,
      'user': instance.user,
      'userId': instance.userId,
      'payoutsEnabled': instance.payoutsEnabled,
      'chargesEnabled': instance.chargesEnabled,
      'email': instance.email,
      'error': instance.error,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      profileImageUrl: json['profileImageUrl'] as String? ?? "",
      phoneNumber: json['phoneNumber'] as String? ?? "",
      isOnboardingCompleted: json['isOnboardingCompleted'] as bool? ?? false,
      refreshToken: json['refreshToken'] as String? ?? "",
      instructorProfile: json['instructorProfile'] == null
          ? null
          : InstructorProfile.fromJson(
              json['instructorProfile'] as Map<String, dynamic>),
      bankAccount: json['bankAccount'] == null
          ? null
          : UserBankAccount.fromJson(
              json['bankAccount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'profileImageUrl': instance.profileImageUrl,
      'phoneNumber': instance.phoneNumber,
      'isOnboardingCompleted': instance.isOnboardingCompleted,
      'refreshToken': instance.refreshToken,
      'instructorProfile': instance.instructorProfile,
      'bankAccount': instance.bankAccount,
    };

UserModelWithAccessToken _$UserModelWithAccessTokenFromJson(
        Map<String, dynamic> json) =>
    UserModelWithAccessToken(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      refreshToken: json['refreshToken'] as String? ?? "",
      isOnboardingCompleted: json['isOnboardingCompleted'] as bool? ?? false,
      accessToken: json['accessToken'] as String,
      instructorProfile: json['instructorProfile'] == null
          ? null
          : InstructorProfile.fromJson(
              json['instructorProfile'] as Map<String, dynamic>),
      bankAccount: json['bankAccount'] == null
          ? null
          : UserBankAccount.fromJson(
              json['bankAccount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelWithAccessTokenToJson(
        UserModelWithAccessToken instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'profileImageUrl': instance.profileImageUrl,
      'phoneNumber': instance.phoneNumber,
      'isOnboardingCompleted': instance.isOnboardingCompleted,
      'refreshToken': instance.refreshToken,
      'instructorProfile': instance.instructorProfile,
      'bankAccount': instance.bankAccount,
      'accessToken': instance.accessToken,
    };
