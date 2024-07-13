import 'package:dio/dio.dart';
import 'package:education_app/common/error/failure.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/retrofit_api.dart';
import 'package:education_app/domain/model/constant/language.dart';
import 'package:education_app/domain/repository/constant/constant_repository.dart';
import 'package:fpdart/src/either.dart';

class ConstantRepositoryImpl implements ConstantRepository {
  final RestClient api;

  const ConstantRepositoryImpl({required this.api});

  @override
  Future<Either<Failure, List<Language>>> getLanguages() async {
    try {
      final res = await api.getLanguages();
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }
}
