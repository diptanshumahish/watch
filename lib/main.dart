import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch/providers/multi_provider.dart';
import 'package:watch/providers/theme_provider.dart';
import 'package:watch/screens/homepage.dart';
import 'package:watch/screens/login_page.dart';
import 'package:watch/services/service_locator.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefsInstance = await SharedPreferences.getInstance();
  await initServiceLocator(prefsInstance);
  runApp(const MultiProviderWrapper(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      home: Consumer<User?>(
        builder: (context, user, child) {
          if (user != null) {
            return const HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
