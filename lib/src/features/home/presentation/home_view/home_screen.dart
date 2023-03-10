import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:watch/src/features/home/presentation/home_view/components/fav.dart';
import 'package:watch/src/features/home/presentation/profile/profile.dart';

import '../movie_details/movie_details_screen.dart';
import 'components/home.dart';

int currenIndex = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

    var pages = [
      const Home(),
      //TODO: uncomment this after checking the movie details page and remove it
      // const Explore(),
      const MovieDetails(),
      const Fav(),
      const ProfileScreen()
    ];

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