import 'package:education_app/domain/model/constant/language.dart';
import 'package:education_app/domain/model/course/course_instructor.dart';
import 'package:education_app/domain/model/course/user_review.dart';
import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:education_app/domain/model/image/image_model.dart';
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
class CoursePart {
  final String id;
  final int order;
  final String title;
  final bool isVideoIncluded;
  final String resourceUrl;

  const CoursePart({
    required this.id,
    required this.order,
    required this.title,
    required this.isVideoIncluded,
    required this.resourceUrl,
  });

  factory CoursePart.fromJson(Map<String, dynamic> json) =>
      _$CoursePartFromJson(json);

  Map<String, dynamic> toJson() => _$CoursePartToJson(this);

  static const samples = [
    CoursePart(
      id: '1',
      order: 1,
      title: 'What is this course for?',
      isVideoIncluded: false,
      resourceUrl: "resourceUrl",
    ),
    CoursePart(
      id: '2',
      order: 2,
      title: 'Introduction to Python',
      isVideoIncluded: false,
      resourceUrl: "resourceUrl",
    ),
  ];
}

@JsonSerializable()
class CourseSection {
  final String id;
  final int order;
  final String title;
  @JsonKey(name: 'course_parts')
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

  static const samples = [
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
  @JsonKey(name: 'levels')
  final CourseLevel level;
  final String? status;
  final String? thumbnailUrl;
  @JsonKey(name: 'course_instructors')
  final CourseInstructor instructor;
  @JsonKey(name: 'categories')
  final CourseCategory category;
  final double price;
  final double? reviewRating;
  final String createdAt;
  final String updatedAt;
  final Language language;
  final List<String> topics;
  final List<String> requirements;
  @JsonKey(name: 'course_images')
  final List<ImageModel> images;
  final String? videoUrl;
  final List<CourseUpdate> updates;
  @JsonKey(name: 'course_sections')
  final List<CourseSection> sections;
  final List<UserReview> reviews;

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    this.status,
    this.thumbnailUrl,
    this.reviewRating,
    required this.instructor,
    required this.category,
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
      instructor: CourseInstructor.samples.first,
      category: CourseCategory.samples.first,
      price: 29.90,
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
    ),
    Course(
      id: '2',
      title: '100 Days of Code: The Complete Python Pro Bootcamp',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
      level: CourseLevel.samples.first,
      thumbnailUrl: '',
      instructor: CourseInstructor.samples.first,
      category: CourseCategory.samples.first,
      price: 29.90,
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
    Course(
      id: '3',
      title: '100 Days of Code: The Complete Python Pro Bootcamp',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
      level: CourseLevel.samples.first,
      thumbnailUrl: '',
      instructor: CourseInstructor.samples.first,
      category: CourseCategory.samples.first,
      price: 29.90,
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
    instructor: $instructor,
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
