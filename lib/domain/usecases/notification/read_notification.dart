import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/notification/notification.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class ToggleReadNotification implements UseCase<NotificationModel, String> {
  final UserRepository userRepository;

  const ToggleReadNotification({required this.userRepository});

  @override
  Future<Either<Failure, NotificationModel>> call(String payload) async {
    return await userRepository.updateNotificationToRead(
        notificationId: payload);
  }
}
