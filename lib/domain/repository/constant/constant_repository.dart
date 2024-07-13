import 'package:education_app/common/error/failure.dart';
import 'package:education_app/domain/model/constant/language.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ConstantRepository {
  Future<Either<Failure, List<Language>>> getLanguages();
}
