import 'package:equatable/equatable.dart';

import '../../../../../app/errors/failure.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
  @override
  List<Object> get props => [];
}

class ForgotInitial extends ForgotPasswordState {
  const ForgotInitial();
}

class ForgotLoading extends ForgotPasswordState {
  const ForgotLoading();
}

class ForgotSuccess extends ForgotPasswordState {
  final String message;
  const ForgotSuccess({this.message = 'Password Reset Email Sent'});

  @override
  List<String> get props => [message];
}

class ForgotFailure extends ForgotPasswordState {
  final Failure error;
  const ForgotFailure(this.error);
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'SignupFailure { error: $error }';
}
