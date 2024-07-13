import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/constant/language.dart';
import 'package:education_app/domain/repository/constant/constant_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchLanguages implements UseCase<List<Language>, NoPayload> {
  final ConstantRepository constantRepository;

  const FetchLanguages({required this.constantRepository});

  @override
  Future<Either<Failure, List<Language>>> call(NoPayload payload) async {
    return await constantRepository.getLanguages();
  }
}
