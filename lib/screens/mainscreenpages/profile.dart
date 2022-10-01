import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch/util/theme.dart';

bool isDark = false;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return ListView(
      children: [
        Center(
            child: IconButton(
          icon: const Icon(
            Icons.abc_outlined,
          ),
          onPressed: (() {
            setState(() {
              if (isDark) {
                themeNotifier.setTheme(lightTheme);
                isDark = false;
              } else {
                themeNotifier.setTheme(darkTheme);
                isDark = true;
              }
            });
          }),
        ))
      ],
    );
  }
}
