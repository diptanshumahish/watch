import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

import '../../app/errors/errors.dart';

///Provider that will be used to provide the http client
final Provider<HttpBaseClient> httpClientProvider = Provider<HttpBaseClient>(
  name: 'httpClientProvider',
  (ProviderRef<HttpBaseClient> ref) => HttpBaseClient(Client()),
);

///BaseApi class that will be used to make CRUD operations
class HttpBaseClient {
  late final Client _client;

  HttpBaseClient(this._client);

  void close() => _client.close();

  FutureEither<String> get(String url, {Map<String, String>? headers}) async {
    try {
      Response response = await _client.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return right(response.body);
      }
      return left(Failure(
          code: response.statusCode.toString(),
          message: 'Something went wrong'));
    } on HttpException catch (e, stackTrace) {
      return left(e.toFailure(stackTrace));
    } on IOException catch (e) {
      return left(e.toFailure());
    } on FormatException catch (e) {
      return left(e.toFailure());
    } catch (e) {
      return left(const Failure(message: 'Something went wrong'));
    }
  }
}
