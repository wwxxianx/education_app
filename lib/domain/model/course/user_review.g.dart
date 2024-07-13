// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserReview _$UserReviewFromJson(Map<String, dynamic> json) => UserReview(
      id: json['id'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      reviewContent: json['reviewContent'] as String,
      reviewRating: (json['reviewRating'] as num).toInt(),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$UserReviewToJson(UserReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'reviewContent': instance.reviewContent,
      'reviewRating': instance.reviewRating,
      'createdAt': instance.createdAt,
    };
