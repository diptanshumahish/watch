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
    var pages = [const Home(), const Explore(), const Fav(), const Profile()];

    return SafeArea(
      child: Scaffold(
        body: pages[currenIndex],
        bottomNavigationBar: BottomNavigationBar(
            elevation: 5,
            enableFeedback: true,
            currentIndex: currenIndex,
            unselectedItemColor: const Color.fromARGB(255, 116, 112, 112),
            selectedItemColor: Colors.black,
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
