import 'package:equatable/equatable.dart';
import 'package:watch/app/errors/errors.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignUpState {
  const SignupInitial();
}

class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

class SignupSuccess extends SignUpState {
  final String message;

  const SignupSuccess({this.message = 'Account created successfully'});

  @override
  List<Object> get props => [message];
}

class SignUpFailure extends SignUpState {
  final Failure error;

  const SignUpFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SignupFailure { error: $error }';
}
