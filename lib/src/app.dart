import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:watch/src/features/splash/splash_screen.dart';
import 'package:watch/src/routes/router.dart';

import '../app/theme/app_theme.dart';
import 'features/authentication/presentation/login/login_screen.dart';
import 'features/home/presentation/home_view/home_screen.dart';
import 'providers/global_providers.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Watch',
      scaffoldMessengerKey: scaffoldMessengerKey,
      themeMode: ThemeMode.dark,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: Consumer(
        builder: (context, ref, child) {
          final user = ref.watch(sessionStatusProvider);
          return user.when(
            data: (user) {
              if (user != null) {
                return const HomeScreen();
              } else {
                return const LoginScreen();
              }
            },
            loading: () => const SplashScreen(),
            error: (_, __) => const Center(child: Text('Error')),
          );
        },
      ),
    );
  }
}
