import 'dart:io';

class CreateInstructorProfilePayload {
  final String fullName;
  final String title;
  final File? profileImageFile;

  const CreateInstructorProfilePayload({
    required this.fullName,
    required this.title,
    this.profileImageFile,
  });
}
