import 'package:education_app/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_review.g.dart';

@JsonSerializable()
class UserReview {
  final String id;
  final UserModel user;
  final String reviewContent;
  final int reviewRating;
  final String createdAt;

  const UserReview({
    required this.id,
    required this.user,
    required this.reviewContent,
    required this.reviewRating,
    required this.createdAt,
  });

  factory UserReview.fromJson(Map<String, dynamic> json) =>
      _$UserReviewFromJson(json);

  Map<String, dynamic> toJson() => _$UserReviewToJson(this);

  static const samples = [
    UserReview(
      id: '1',
      user: UserModel(
        id: '1',
        fullName: 'John Doe',
        email: 'X9k6f@example.com',
      ),
      reviewContent:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      reviewRating: 5,
      createdAt: '2022-01-01T00:00:00.000Z',
    ),
    UserReview(
      id: '1',
      user: UserModel(
        id: '1',
        fullName: 'John Doe',
        email: 'X9k6f@example.com',
      ),
      reviewContent: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      reviewRating: 5,
      createdAt: '2022-01-01T00:00:00.000Z',
    ),
    UserReview(
      id: '1',
      user: UserModel(
        id: '1',
        fullName: 'John Doe',
        email: 'X9k6f@example.com',
      ),
      reviewContent: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      reviewRating: 5,
      createdAt: '2022-01-01T00:00:00.000Z',
    ),
    UserReview(
      id: '1',
      user: UserModel(
        id: '1',
        fullName: 'John Doe',
        email: 'X9k6f@example.com',
      ),
      reviewContent: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      reviewRating: 5,
      createdAt: '2022-01-01T00:00:00.000Z',
    ),
  ];
}
