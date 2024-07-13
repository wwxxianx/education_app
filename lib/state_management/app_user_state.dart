import 'package:education_app/domain/model/user.dart';
import 'package:equatable/equatable.dart';


final class AppUserState extends Equatable {
  final UserModel? currentUser;
  final int numOfReceivedUnusedGiftCards;

  const AppUserState._({
    this.currentUser,
    this.numOfReceivedUnusedGiftCards = 0,
  });

  const AppUserState.initial() : this._();

  AppUserState copyWith({
    UserModel? currentUser,
    int? numOfReceivedUnusedGiftCards,
  }) {
    return AppUserState._(
      currentUser: currentUser ?? this.currentUser,
      numOfReceivedUnusedGiftCards:
          numOfReceivedUnusedGiftCards ?? this.numOfReceivedUnusedGiftCards,
    );
  }

  @override
  List<Object?> get props => [
        currentUser,
        numOfReceivedUnusedGiftCards,
      ];
}
