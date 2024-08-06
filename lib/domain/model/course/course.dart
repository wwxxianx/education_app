import 'package:education_app/domain/model/constant/language.dart';
import 'package:education_app/domain/model/course/enum/course_enum.dart';
import 'package:education_app/domain/model/course/user_review.dart';
import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:education_app/domain/model/image/image_model.dart';
import 'package:education_app/domain/model/user/user.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class CourseLevel {
  final String id;
  final String level;

  const CourseLevel({
    required this.id,
    required this.level,
  });

  factory CourseLevel.fromJson(Map<String, dynamic> json) =>
      _$CourseLevelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseLevelToJson(this);

  static const samples = [
    CourseLevel(id: '1', level: 'beginner'),
    CourseLevel(id: '2', level: 'intermediate'),
    CourseLevel(id: '3', level: 'expert'),
  ];
}

@JsonSerializable()
class CourseResource {
  final String id;
  final String url;
  final String mimeType;

  const CourseResource({
    required this.id,
    required this.url,
    required this.mimeType,
  });

  CourseResourceMimeType get mimeTypeEnum {
    if (mimeType == "DOCUMENT") {
      return CourseResourceMimeType.DOCUMENT;
    }
    if (mimeType == "TEXT") {
      return CourseResourceMimeType.TEXT;
    }
    if (mimeType == "VIDEO") {
      return CourseResourceMimeType.VIDEO;
    }
    return CourseResourceMimeType.DOCUMENT;
  }

  factory CourseResource.fromJson(Map<String, dynamic> json) =>
      _$CourseResourceFromJson(json);

  Map<String, dynamic> toJson() => _$CourseResourceToJson(this);

  static final samples = [
    CourseResource(
        id: '1',
        url:
            'https://vooexvblyikqqqacbwnx.supabase.co/storage/v1/object/public/course/resource/testing/5505-Article%20Text-10230-1-10-20210507.pdf',
        mimeType: 'DOCUMENT'),
    CourseResource(
        id: '1',
        url:
            'https://vooexvblyikqqqacbwnx.supabase.co/storage/v1/object/public/course/resource/testing/5505-Article%20Text-10230-1-10-20210507.pdf',
        mimeType: 'DOCUMENT'),
  ];
}

@JsonSerializable()
class CoursePart extends Equatable {
  final String id;
  final int order;
  final String title;
  final CourseResource resource;

  const CoursePart({
    required this.id,
    required this.order,
    required this.title,
    required this.resource,
  });

  factory CoursePart.fromJson(Map<String, dynamic> json) =>
      _$CoursePartFromJson(json);

  Map<String, dynamic> toJson() => _$CoursePartToJson(this);

  static final samples = [
    CoursePart(
      id: '1',
      order: 1,
      title: 'What is this course for?',
      resource: CourseResource.samples.first,
    ),
    CoursePart(
      id: '2',
      order: 2,
      title: 'Introduction to Python',
      resource: CourseResource.samples.first,
    ),
  ];
  
  @override
  List<Object?> get props => [
    id,
    order,
    title,
    resource,
  ];
}

@JsonSerializable()
class CourseSection {
  final String id;
  final int order;
  final String title;
  final List<CoursePart> parts;

  const CourseSection({
    required this.id,
    required this.order,
    required this.title,
    required this.parts,
  });

  factory CourseSection.fromJson(Map<String, dynamic> json) =>
      _$CourseSectionFromJson(json);

  Map<String, dynamic> toJson() => _$CourseSectionToJson(this);

  static final samples = [
    CourseSection(
      id: '1',
      order: 1,
      title: "Introduction to Python",
      parts: CoursePart.samples,
    ),
    CourseSection(
      id: '1',
      order: 1,
      title: "Function in Python",
      parts: CoursePart.samples,
    ),
    CourseSection(
      id: '1',
      order: 1,
      title: "OOP in Python",
      parts: CoursePart.samples,
    ),
    CourseSection(
      id: '1',
      order: 1,
      title: "Introduction to Python",
      parts: CoursePart.samples,
    ),
  ];
}

@JsonSerializable()
class Course {
  final String id;
  final String title;
  final String description;
  final CourseLevel level;
  final String status;
  final String? thumbnailUrl;
  final CourseCategory category;
  final List<CourseCategory> subcategories;
  final UserModel instructor;
  final int price;
  final double? reviewRating;
  final String createdAt;
  final String updatedAt;
  final Language language;
  final List<String> topics;
  final List<String> requirements;
  final List<ImageModel> images;
  final String? videoUrl;
  final List<CourseUpdate> updates;
  final List<CourseSection> sections;
  final List<UserReview> reviews;

  String get instructorDisplayName {
    return instructor.instructorProfile?.fullName ?? instructor.fullName;
  }

  CoursePublishStatus get statusEnum {
    try {
      final statusEnum = CoursePublishStatus.values.byName(status);
      return statusEnum;
    } catch (e) {
      return CoursePublishStatus.DRAFT;
    }
  }

  String get displayPrice {
    // Convert smallest unit to normal format
    return "RM ${price / 100}";
  }

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.instructor,
    required this.status,
    this.thumbnailUrl,
    this.reviewRating,
    required this.category,
    this.subcategories = const [],
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.language,
    required this.topics,
    required this.requirements,
    this.updates = const [],
    this.sections = const [],
    this.images = const [],
    this.videoUrl,
    this.reviews = const [],
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);

  static final samples = [
    Course(
      id: '1',
      title: 'Python Ultimate Crash Course',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
      level: CourseLevel.samples.first,
      thumbnailUrl: '',
      category: CourseCategory.samples.first,
      price: 29900,
      createdAt: '2024-05-16T08:21:57.324Z',
      updatedAt: '2024-05-16T08:21:57.324Z',
      language: Language.samples.first,
      topics: [
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
      ],
      requirements: [
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
      ],
      updates: CourseUpdate.samples,
      sections: CourseSection.samples,
      reviews: UserReview.samples,
      status: "DRAFT",
      instructor: UserModel.sample,
    ),
    Course(
      id: '2',
      title: '100 Days of Code: The Complete Python Pro Bootcamp',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
      level: CourseLevel.samples.first,
      thumbnailUrl: '',
      category: CourseCategory.samples.first,
      price: 29900,
      createdAt: '2024-05-16T08:21:57.324Z',
      updatedAt: '2024-05-16T08:21:57.324Z',
      language: Language.samples.first,
      topics: [
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
      ],
      requirements: [
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
      ],
      updates: CourseUpdate.samples,
      sections: CourseSection.samples,
      reviews: UserReview.samples,
      status: "PUBLISHED",
      instructor: UserModel.sample,
    ),
    Course(
      id: '3',
      title: '100 Days of Code: The Complete Python Pro Bootcamp',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
      level: CourseLevel.samples.first,
      thumbnailUrl: '',
      instructor: UserModel.sample,
      category: CourseCategory.samples.first,
      price: 29900,
      createdAt: '2024-05-16T08:21:57.324Z',
      updatedAt: '2024-05-16T08:21:57.324Z',
      language: Language.samples.first,
      topics: [
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
      ],
      requirements: [
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
      ],
      updates: CourseUpdate.samples,
      sections: CourseSection.samples,
      reviews: UserReview.samples,
      status: "PUBLISHED",
    ),
  ];

  @override
  String toString() {
    return """
    id: $id,
    title: $title,
    description: $description,
    level: $level,
    thumbnailUrl: $thumbnailUrl,
    category: $category,
    price: $price,
    reviewRating: $reviewRating,
    createdAt: $createdAt,
    updatedAt: $updatedAt,
    language: $language,
    topics: $topics,
    requirements: $requirements,
    images: $images,
    videoUrl: $videoUrl,
    updates: $updates,
    sections: $sections,
    reviews: $reviews,
    """;
  }
}

@JsonSerializable()
class CourseUpdate {
  final String id;
  final String updateOverview;
  final String createdAt;

  const CourseUpdate({
    required this.id,
    required this.updateOverview,
    required this.createdAt,
  });

  factory CourseUpdate.fromJson(Map<String, dynamic> json) =>
      _$CourseUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$CourseUpdateToJson(this);

  static const samples = [
    CourseUpdate(
      id: '1',
      updateOverview:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
      createdAt: '2024-05-16T08:21:57.324Z',
    ),
    CourseUpdate(
      id: '2',
      updateOverview:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
      createdAt: '2024-05-16T08:21:57.324Z',
    ),
  ];
}
