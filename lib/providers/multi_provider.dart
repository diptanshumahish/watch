import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch/providers/theme_provider.dart';
import 'package:watch/services/auth_service.dart';
import 'package:watch/services/service_locator.dart';

class MultiProviderWrapper extends StatelessWidget {
  final Widget child;
  const MultiProviderWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        StreamProvider<User?>(
          create: (_) => getIt.get<AuthService>().user,
          initialData: null,
        ),
      ],
      child: child,
    );
  }
}
