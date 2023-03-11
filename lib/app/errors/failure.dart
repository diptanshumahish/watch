import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final int? code;
  final StackTrace? stackTrace;
  final String message;
  const Failure(this.code, this.stackTrace, {required this.message});

  @override
  List<Object?> get props => [message, code, stackTrace];
}
