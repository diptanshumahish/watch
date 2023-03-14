import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

class ProviderLogger implements ProviderObserver {
  late Logger logger;
  ProviderLogger() {
    logger = Logger(printer: PrettyPrinter());
  }
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    logger.v('Provider Updated: ${provider.name}');
  }

  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {
    logger.d('Provider Added: ${provider.name}, $value');
  }

  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {
    logger.i('Provider Disposed: ${provider.name}');
  }

  @override
  void providerDidFail(ProviderBase<Object?> provider, Object error,
      StackTrace stackTrace, ProviderContainer container) {
    logger.e('Provider Failed: ${provider.name}, $error, $stackTrace');
  }
}
