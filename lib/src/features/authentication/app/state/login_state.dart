import 'package:equatable/equatable.dart';

import '../../../../../app/errors/failure.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => <Object>[];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final String message;
  const LoginSuccess({this.message = 'Logged In Successfully'});

  @override
  List<String> get props => <String>[message];
}

class LoginFailure extends LoginState {
  final Failure error;
  const LoginFailure(this.error);
  @override
  List<Object> get props => <Object>[error];
  @override
  String toString() => 'SignupFailure { error: $error }';
}
