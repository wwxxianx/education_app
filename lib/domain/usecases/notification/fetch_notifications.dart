import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/notification/notification.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchNotifications
    implements UseCase<List<NotificationModel>, NoPayload> {
  final UserRepository userRepository;

  const FetchNotifications({required this.userRepository});
  
  @override
  Future<Either<Failure, List<NotificationModel>>> call(
      NoPayload payload) async {
    return await userRepository.getNotifications();
  }
}
