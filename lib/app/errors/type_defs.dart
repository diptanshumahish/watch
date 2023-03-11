import 'package:dartz/dartz.dart';

import 'failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;

typedef FutureEitherUnit = FutureEither<Unit>;

typedef FutureEitherVoid = FutureEither<void>;
