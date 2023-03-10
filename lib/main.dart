import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch/providers/multi_provider.dart';
import 'package:watch/providers/theme_provider.dart';
import 'package:watch/screens/homepage.dart';
import 'package:watch/screens/login_page.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefsInstance = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPreferenceProvider.overrideWithValue(prefsInstance)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Watch',
      //TODO: fix the theming for the application as dark theme causes text to be white in color
      // themeMode: context.watch<ThemeProvider>().themeMode,
      themeMode: ThemeMode.dark,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: Consumer(
        builder: (context, ref, child) {
          final user = ref.watch(sessionStatusProvider);
          return user.when(
            data: (user) {
              if (user != null) {
                return const HomePage();
              } else {
                return LoginPage();
              }
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => const Center(child: Text('Error')),
          );
        },
      ),
    );
  }
}
