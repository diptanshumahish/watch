import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:watch/screens/mainscreenpages/explore.dart';
import 'package:watch/screens/mainscreenpages/fav.dart';
import 'package:watch/screens/mainscreenpages/profile.dart';
import 'mainscreenpages/home.dart';

int currenIndex = 0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    getTheme() {
      if (Theme.of(context).brightness == Brightness.dark) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }

    getThemeInv() {
      if (Theme.of(context).brightness == Brightness.light) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }

    var pages = [const Home(), const Explore(), const Fav(), const Profile()];

    return SafeArea(
      child: Scaffold(
        body: pages[currenIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: getThemeInv(),
            elevation: 5,
            enableFeedback: true,
            currentIndex: currenIndex,
            unselectedItemColor: getTheme().withOpacity(0.6),
            selectedItemColor: getTheme(),
            showUnselectedLabels: true,
            onTap: (index) {
              setState(() {
                currenIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(
                    Iconsax.home,
                  )),
              BottomNavigationBarItem(
                  label: "Search", icon: Icon(Iconsax.search_normal)),
              BottomNavigationBarItem(
                  label: "Favorites", icon: Icon(Iconsax.heart)),
              BottomNavigationBarItem(
                  label: "Profile", icon: Icon(Iconsax.user)),
            ]),
      ),
    );
  }
}
