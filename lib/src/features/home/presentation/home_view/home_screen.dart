import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../explore_screen/explore.dart';
import '../favourites/favourites_screen.dart';
import '../profile/profile.dart';
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
    List<Widget> pages = <Widget>[
      const Home(),
      const ExploreScreen(),
      const FavScreen(),
      const ProfileScreen()
    ];

    return SafeArea(
      child: Scaffold(
        body: pages[currenIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 5,
          backgroundColor: Theme.of(context).primaryColor,
          enableFeedback: true,
          currentIndex: currenIndex,
          showUnselectedLabels: true,
          onTap: (int index) {
            setState(() {
              currenIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(label: 'Home', icon: Icon(Iconsax.home)),
            BottomNavigationBarItem(
                label: 'Search', icon: Icon(Iconsax.search_normal)),
            BottomNavigationBarItem(
                label: 'Favorites', icon: Icon(Iconsax.heart)),
            BottomNavigationBarItem(label: 'Profile', icon: Icon(Iconsax.user)),
          ],
        ),
      ),
    );
  }
}
