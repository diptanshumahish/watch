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

class NewEmailVerified extends ForgotPasswordState {
  final String message;
  const NewEmailVerified({this.message = 'Password Reset Successfully'});

  @override
  List<String> get props => [message];
}

class ForgotEmailSent extends ForgotPasswordState {
  final String message;
  const ForgotEmailSent({this.message = 'Password Reset Email Sent'});

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
