import 'package:education_app/domain/model/user/instructor_profile.dart';
import 'package:education_app/domain/model/user/user_preference.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserBankAccount {
  final bool detailsSubmitted;
  final String id;
  final UserModel? user;
  final String userId;
  final bool payoutsEnabled;
  final bool chargesEnabled;
  final String? email;
  final String? error;

  const UserBankAccount({
    required this.detailsSubmitted,
    required this.id,
    this.user,
    required this.userId,
    required this.payoutsEnabled,
    required this.chargesEnabled,
    this.email,
    this.error,
  });

  factory UserBankAccount.fromJson(Map<String, dynamic> json) =>
      _$UserBankAccountFromJson(json);

  Map<String, dynamic> toJson() => _$UserBankAccountToJson(this);
}

@JsonSerializable()
class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String? profileImageUrl;
  final String? phoneNumber;
  final bool isOnboardingCompleted;
  final String refreshToken;
  final InstructorProfile? instructorProfile;
  final UserBankAccount? bankAccount;
  final UserPreference? preference;
  // UserPreference? preference;
  // List<CampaignDonation> campaignDonations;
  // List<Campaign> campaigns;
  // List<CampaignComment> campaignComments;
  // List<UserFavouriteCampaign> favouriteCampaigns;
  // List<Notification> notifications;
  // List<CampaignUpdate> campaignUpdates;
  // Organization? organization;
  // String? organizationId;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.profileImageUrl = "",
    this.phoneNumber = "",
    this.isOnboardingCompleted = false,
    this.refreshToken = "",
    this.instructorProfile,
    this.bankAccount,
    this.preference,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static const sample = UserModel(
    id: 'sample-id',
    fullName: 'John Doe',
    email: 'john@gmail.com',
  );

  @override
  String toString() => """
  id: $id,
  fullName: $fullName,
  email: $email,
  profileImageUrl: $profileImageUrl,
  phoneNumber: $phoneNumber,
  isOnboardingCompleted: $isOnboardingCompleted,
  """;
}

@JsonSerializable()
class UserModelWithAccessToken extends UserModel {
  final String accessToken;

  const UserModelWithAccessToken({
    required String id,
    required String fullName,
    required String email,
    String? profileImageUrl,
    String? phoneNumber,
    String refreshToken = "",
    bool isOnboardingCompleted = false,
    required this.accessToken,
    InstructorProfile? instructorProfile,
    UserBankAccount? bankAccount,
    UserPreference? preference,
  }) : super(
          id: id,
          fullName: fullName,
          email: email,
          isOnboardingCompleted: isOnboardingCompleted,
          profileImageUrl: profileImageUrl,
          phoneNumber: phoneNumber,
          refreshToken: refreshToken,
          instructorProfile: instructorProfile,
          bankAccount: bankAccount,
          preference: preference,
        );

  UserModel toUserModel() {
    return UserModel(
      id: id,
      fullName: fullName,
      email: email,
      profileImageUrl: profileImageUrl,
      phoneNumber: phoneNumber ?? "",
      isOnboardingCompleted: isOnboardingCompleted,
      refreshToken: refreshToken,
      instructorProfile: instructorProfile,
      bankAccount: bankAccount,
      preference: preference,
    );
  }

  @override
  String toString() => """
  id: $id,
  fullName: $fullName,
  email: $email,
  profileImageUrl: $profileImageUrl,
  phoneNumber: $phoneNumber,
  isOnboardingCompleted: $isOnboardingCompleted,
  """;

  factory UserModelWithAccessToken.fromJson(Map<String, dynamic> json) =>
      _$UserModelWithAccessTokenFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelWithAccessTokenToJson(this);
}
