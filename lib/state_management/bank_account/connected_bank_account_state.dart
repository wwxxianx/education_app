import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/stripe/connect_account_response.dart';
import 'package:education_app/domain/model/stripe/stripe_account.dart';
import 'package:equatable/equatable.dart';

final class BankAccountState extends Equatable {
  final ApiResult<StripeAccount> stripeAccountResult;
  final ApiResult<ConnectAccountResponse> updateStripeConnectAccountResult;
  final bool isAccountNull;

  const BankAccountState._({
    this.stripeAccountResult = const ApiResultInitial(),
    this.updateStripeConnectAccountResult = const ApiResultInitial(),
    this.isAccountNull = false,
  });

  const BankAccountState.initial() : this._();

  BankAccountState copyWith({
    ApiResult<StripeAccount>? stripeAccountResult,
    ApiResult<ConnectAccountResponse>? updateStripeConnectAccountResult,
    bool? isAccountNull,
  }) {
    return BankAccountState._(
      stripeAccountResult: stripeAccountResult ?? this.stripeAccountResult,
      updateStripeConnectAccountResult: updateStripeConnectAccountResult ??
          this.updateStripeConnectAccountResult,
      isAccountNull: isAccountNull ?? this.isAccountNull,
    );
  }

  @override
  List<Object?> get props =>
      [stripeAccountResult, updateStripeConnectAccountResult, isAccountNull];
}
