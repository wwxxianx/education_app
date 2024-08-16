import 'dart:io';

class CreateCoursePartPayload {
  final String sectionId;
  final String title;
  final File resourceFile;

  const CreateCoursePartPayload(
      {required this.sectionId,
      required this.title,
      required this.resourceFile,});
}
