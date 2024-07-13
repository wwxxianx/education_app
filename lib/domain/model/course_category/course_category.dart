import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_category.g.dart';

@JsonSerializable()
class CourseCategory {
  final String id;
  final String title;
  final List<CourseCategory> subcategories;

  const CourseCategory({
    required this.id,
    required this.title,
    this.subcategories = const [],
  });

  factory CourseCategory.fromJson(Map<String, dynamic> json) =>
      _$CourseCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CourseCategoryToJson(this);

  static const samples = [
    CourseCategory(
      id: '1',
      title: 'IT & Software',
      subcategories: [
        CourseCategory(id: '1', title: 'System Design'),
        CourseCategory(id: '2', title: 'Python'),
        CourseCategory(id: '3', title: 'Web Development'),
        CourseCategory(id: '4', title: 'A.I'),
        CourseCategory(id: '5', title: 'Data Analytics'),
      ],
    ),
    CourseCategory(
      id: '2',
      title: 'Design',
      subcategories: [
        CourseCategory(id: '1', title: 'UIUX Design'),
        CourseCategory(id: '2', title: 'Graphic Design'),
      ],
    ),
    CourseCategory(
      id: '3',
      title: 'Personal Development',
    ),
    CourseCategory(
      id: '4',
      title: 'Photography',
    ),
    CourseCategory(
      id: '5',
      title: 'Music',
    ),
    CourseCategory(
      id: '6',
      title: 'Film',
    ),
    CourseCategory(
      id: '7',
      title: 'Financing & Accounting',
    ),
  ];
}

extension CourseCategoryExtension on CourseCategory {
  Widget getIcon({isSmall = false}) {
    final size = isSmall ? 16.0 : 24.0;

    switch (title) {
      case 'IT & Software':
        return SvgPicture.asset(
          'assets/icons/code.svg',
          width: size,
          height: size,
        );
      case 'Design':
        return SvgPicture.asset(
          'assets/icons/graphic-design.svg',
          width: size,
          height: size,
        );
      case 'Photography':
        return SvgPicture.asset(
          'assets/icons/camera.svg',
          width: size,
          height: size,
        );
      case 'Music':
        return SvgPicture.asset(
          'assets/icons/music.svg',
          width: size,
          height: size,
        );
      case 'Film':
        return SvgPicture.asset(
          'assets/icons/video.svg',
          width: size,
          height: size,
        );
      case 'Finance & Accounting':
        return SvgPicture.asset(
          'assets/icons/financing.svg',
          width: size,
          height: size,
        );
      default:
        return SvgPicture.asset(
          'assets/icons/code.svg',
          width: size,
          height: size,
        );
    }
  }
}
