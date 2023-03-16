import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:watch/src/providers/network_checker_provider.dart';

import '../../app/constants/enums.dart';

class NetworkChecker extends StatelessWidget {
  final Widget onlineChild;
  final Widget offlineChild;
  const NetworkChecker({
    Key? key,
    required this.onlineChild,
    required this.offlineChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      key: const ValueKey('NetworkChecker'),
      builder: (context, ref, child) {
        final status = ref.watch(connectivityNotifierProvider);
        return status.maybeWhen(
          data: (status) {
            if (status == ConnectionStatus.online) {
              return onlineChild;
            } else {
              return offlineChild;
            }
          },
          orElse: () => offlineChild,
        );
      },
    );
  }
}
