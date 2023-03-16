import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/constants/enums.dart';

///This provider is used in the [NetworkChecker] widget
///to detect the network status of the device
final StreamNotifierProvider<NetworkNotifier, ConnectionStatus>
    connectivityNotifierProvider =
    StreamNotifierProvider<NetworkNotifier, ConnectionStatus>(
  NetworkNotifier.new,
);

class NetworkNotifier extends StreamNotifier<ConnectionStatus> {
  /// Creates a [NetworkNotifier] that emits a [ConnectionStatus] when the network
  NetworkNotifier() {
    _statusController.onListen = _maybeEmitStatusUpdate;
    _statusController.onCancel = () {
      _timerHandle?.cancel();
      _lastStatus = null;
    };
  }
  @override
  Stream<ConnectionStatus> build() => _statusController.stream;

  static const int port = 53;
  static const Duration timeout = Duration(seconds: 10);
  static const Duration interval = Duration(seconds: 2);

  static List<AddressCheckOptions> get _defaultAddresses =>
      List<AddressCheckOptions>.unmodifiable(
        <AddressCheckOptions>[
          AddressCheckOptions(
            InternetAddress('1.1.1.1'),
            port: port,
            timeout: timeout,
          ),
          AddressCheckOptions(
            InternetAddress('8.8.4.4'),
            port: port,
            timeout: timeout,
          ),
          AddressCheckOptions(
            InternetAddress('208.67.222.222'),
            port: port,
            timeout: timeout,
          ),
        ],
      );

  List<AddressCheckOptions> addresses = _defaultAddresses;

  Future<AddressCheckResult> isHostReachable(
    AddressCheckOptions options,
  ) async {
    Socket? sock;
    try {
      sock = await Socket.connect(
        options.address,
        options.port,
        timeout: options.timeout,
      );
      sock.destroy();
      return AddressCheckResult(options, true);
    } catch (e) {
      sock?.destroy();
      return AddressCheckResult(options, false);
    }
  }

  List<AddressCheckResult> get lastTryResults => _lastTryResults;
  List<AddressCheckResult> _lastTryResults = <AddressCheckResult>[];

  Future<bool> get isConnected async {
    List<Future<AddressCheckResult>> requests = <Future<AddressCheckResult>>[];

    for (AddressCheckOptions addressOptions in addresses) {
      requests.add(isHostReachable(addressOptions));
    }
    _lastTryResults =
        List<AddressCheckResult>.unmodifiable(await Future.wait(requests));

    return _lastTryResults
        .map((AddressCheckResult result) => result.isSuccess)
        .contains(true);
  }

  Future<ConnectionStatus> get connectionStatus async {
    return await isConnected
        ? ConnectionStatus.online
        : ConnectionStatus.offline;
  }

  Duration checkInterval = interval;

  Future<void> _maybeEmitStatusUpdate() async {
    _timerHandle?.cancel();
    ConnectionStatus currentStatus = await connectionStatus;
    if (_lastStatus != currentStatus && _statusController.hasListener) {
      _statusController.add(currentStatus);
    }
    if (!_statusController.hasListener) return;
    _timerHandle = Timer(checkInterval, _maybeEmitStatusUpdate);
    _lastStatus = currentStatus;
  }

  ConnectionStatus? _lastStatus;
  Timer? _timerHandle;

  final StreamController<ConnectionStatus> _statusController =
      StreamController<ConnectionStatus>.broadcast();

  Stream<ConnectionStatus> get onStatusChange => _statusController.stream;

  ConnectionStatus? get lastStatus => _lastStatus;
}

class AddressCheckOptions extends Equatable {
  final InternetAddress address;
  final int port;
  final Duration timeout;

  const AddressCheckOptions(
    this.address, {
    required this.port,
    required this.timeout,
  });

  @override
  List<Object?> get props => <Object?>[address, port, timeout];
}

class AddressCheckResult extends Equatable {
  final AddressCheckOptions options;
  final bool isSuccess;

  const AddressCheckResult(this.options, this.isSuccess);

  @override
  List<Object?> get props => <Object?>[options, isSuccess];
}
