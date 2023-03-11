import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String? code;
  final StackTrace? stackTrace;
  final String message;
  const Failure({required this.message, this.code, this.stackTrace});

  @override
  List<Object?> get props => [message, code, stackTrace];
}


