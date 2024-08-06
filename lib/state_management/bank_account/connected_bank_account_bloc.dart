import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/usecases/payment/fetch_connected_account.dart';
import 'package:education_app/domain/usecases/payment/update_connect_account.dart';
import 'package:education_app/state_management/bank_account/connected_bank_account_event.dart';
import 'package:education_app/state_management/bank_account/connected_bank_account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class BankAccountBloc extends Bloc<BankAccountEvent, BankAccountState> {
  final FetchConnectedAccount _fetchConnectedAccount;
  final UpdateConnectAccount _updateConnectAccount;
  BankAccountBloc({
    required FetchConnectedAccount fetchConnectedAccount,
    required UpdateConnectAccount updateConnectAccount,
  })  : _fetchConnectedAccount = fetchConnectedAccount,
        _updateConnectAccount = updateConnectAccount,
        super(const BankAccountState.initial()) {
    on<BankAccountEvent>(_onEvent);
  }

  Future<void> _onEvent(
      BankAccountEvent event, Emitter<BankAccountState> emit) async {
    return switch (event) {
      final OnFetchConnectedAccount e => _onFetchConnectedAccount(e, emit),
      final OnUpdateConnectAccount e => _onUpdateConnectAccount(e, emit),
    };
  }

  Future<void> _onUpdateConnectAccount(
    OnUpdateConnectAccount event,
    Emitter<BankAccountState> emit,
  ) async {
    emit(state.copyWith(
        updateStripeConnectAccountResult: const ApiResultLoading()));
    final res = await _updateConnectAccount.call(NoPayload());
    res.fold(
      (failure) {
        emit(state.copyWith(
            updateStripeConnectAccountResult:
                ApiResultFailure(failure.errorMessage)));
      },
      (onboardLinkRes) {
        emit(state.copyWith(
            updateStripeConnectAccountResult:
                ApiResultSuccess(onboardLinkRes)));
        event.onSuccess(onboardLinkRes.onboardLink);
      },
    );
  }

  Future<void> _onFetchConnectedAccount(
    OnFetchConnectedAccount event,
    Emitter<BankAccountState> emit,
  ) async {
    var logger = Logger();
    final res = await _fetchConnectedAccount.call(NoPayload());
    res.fold(
      (l) {
        logger.w('Failed with ${l.errorMessage}');
      },
      (account) {
        logger.w(account);
        if (account == null) {
          return emit(state.copyWith(
              isAccountNull: true,
              stripeAccountResult: const ApiResultInitial()));
        }
        emit(state.copyWith(stripeAccountResult: ApiResultSuccess(account)));
      },
    );
  }
}
