import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

import 'home_view/home_screen.dart';

var selectedList = [];
bool isLoaded = false;

class Reccomendations extends StatefulWidget {
  const Reccomendations({super.key});

  @override
  State<Reccomendations> createState() => _ReccomendationsState();
}

class _ReccomendationsState extends State<Reccomendations> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        isLoaded = true;
      });
    });
    super.initState();
  }

  var filter = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    Color getTheme() {
      if (Theme.of(context).brightness == Brightness.dark) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }

    Color getThemeInv() {
      if (Theme.of(context).brightness == Brightness.light) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }

    var image = [
      'https://github.com/diptanshumahish/watch_images/raw/main/movie_rec/scifi2.webp',
      'https://github.com/diptanshumahish/watch_images/raw/main/movie_rec/beng.webp',
      'https://github.com/diptanshumahish/watch_images/raw/main/movie_rec/dc.webp',
      'https://github.com/diptanshumahish/watch_images/raw/main/movie_rec/anime.webp',
      'https://github.com/diptanshumahish/watch_images/raw/main/movie_rec/comedy.webp',
      'https://github.com/diptanshumahish/watch_images/raw/main/movie_rec/dark.webp',
      'https://github.com/diptanshumahish/watch_images/raw/main/movie_rec/scifi.webp',
      'https://github.com/diptanshumahish/watch_images/raw/main/movie_rec/horror.webp',
      'https://github.com/diptanshumahish/watch_images/raw/main/movie_rec/scifi3.webp'
    ];

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chose 3 shows',
                          style: TextStyle(
                              fontSize: height / 22,
                              fontWeight: FontWeight.w600,
                              color: getTheme()),
                        ),
                        Text(
                          'that interest you',
                          style: TextStyle(
                              fontSize: height / 24, color: getTheme()),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (() {}),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: image.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 5,
                    childAspectRatio: 4 / 6,
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                        onTap: (() {
                          setState(() {
                            !selectedList.contains(index)
                                ? selectedList.add(index)
                                : selectedList.remove(index);
                          });
                        }),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.bounceIn,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(7, 9),
                                    spreadRadius: -8,
                                    blurRadius: 17,
                                    color: isLoaded
                                        ? const Color.fromRGBO(0, 0, 0, 0.43)
                                        : Colors.transparent)
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(image[index])),
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: selectedList.contains(index)
                                      ? const Color(0xAF000000)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: selectedList.contains(index)
                                    ? const Icon(
                                        Iconsax.tick_circle,
                                        color: Colors.white,
                                        size: 35,
                                      )
                                    : const Text(''),
                              )),
                        )),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
            child: InkWell(
              onTap: (() {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageTransition(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.bounceIn,
                    child: const HomeScreen(),
                    type: PageTransitionType.bottomToTop,
                  ),
                );
              }),
              child: Container(
                width: width,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: getTheme()),
                child: Center(
                  child: Text('Done', style: TextStyle(color: getThemeInv())),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
