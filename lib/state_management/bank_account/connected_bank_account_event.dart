import 'package:flutter/material.dart';

@immutable
sealed class BankAccountEvent {
  const BankAccountEvent();
}

final class OnFetchConnectedAccount extends BankAccountEvent {}

final class OnUpdateConnectAccount extends BankAccountEvent {
  final void Function(String onboardLink) onSuccess;

  const OnUpdateConnectAccount({
    required this.onSuccess,
  });
}
