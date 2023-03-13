import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watch/app/constants/api_urls.dart';
import 'package:watch/src/features/home/data/tmdb_api.dart';
import 'package:watch/src/shared/custom_hero.dart';

import '../../movie_details/movie_details_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getTheme() {
    if (Theme.of(context).brightness == Brightness.dark) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Friend",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: getTheme()),
              ),
              const Text(
                "Let's see what's here for you",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            "Top Picks for you",
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          height: height / 2.5,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Container(
                  height: height / 2.5,
                  width: width / 3,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(7, 6),
                          spreadRadius: -10,
                          blurRadius: 17,
                          color: Color.fromRGBO(0, 0, 0, 0.43),
                        )
                      ],
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://github.com/diptanshumahish/watch_images/raw/main/movie_rec/scifi2.webp")),
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     PageTransition(
                      //         child: const MovieDetails(),
                      //         type: PageTransitionType.rightToLeft));
                    },
                    child: Container(
                        height: height / 2.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black])),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              const Text("Tenet",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                              const Text("Sci-Fi | 2020-08-26",
                                  style: TextStyle(color: Colors.white)),
                              const Text(
                                "The Protagonist, a CIA operative, participates in an extraction at the Kyiv Opera House. His team retrieves an artifact but he is captured, tortured by mercenaries, and ultimately consumes a suicide pill. Some time later, the Protagonist awakens to learn the artifact was lost and the pill was a fake, designed as a test. A highly secretive organization called Tenet recruits him and briefs him on bullets with  entropy, meaning they move backward through time. After meeting his handler, Neil, they trace the inverted bullets to arms dealer Priya Singh in Mumbai.",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color.fromARGB(171, 255, 255, 255)),
                                maxLines: 2,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  width: 83,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text("Rating: ",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    192, 255, 255, 255))),
                                        Text("8.4",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Specialy picked for you",
                style: TextStyle(fontSize: 20, color: getTheme()),
              ),
              IconButton(
                padding: const EdgeInsets.all(0),
                enableFeedback: true,
                onPressed: () {},
                icon: const Icon(CupertinoIcons.forward),
              )
            ],
          ),
        ),
        SizedBox(
          height: height / 3,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    // onTap: () => Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         child: const MovieDetails(),
                    //         type: PageTransitionType.rightToLeft)),
                    child: Container(
                      height: height / 3,
                      width: width / 4,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(4, 1),
                              spreadRadius: -10,
                              blurRadius: 17,
                              color: Color.fromRGBO(0, 0, 0, 0.43),
                            )
                          ],
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://github.com/diptanshumahish/watch_images/raw/main/tragedy.webp",
                            ),
                          ),
                          borderRadius: BorderRadius.circular(8)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black])),
                        height: height / 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Spacer(),
                              Text(
                                "Joker",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Tragedy | 9.2 \u066D",
                                style: TextStyle(
                                  color: Color.fromARGB(194, 255, 255, 255),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Horror Specials",
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                padding: const EdgeInsets.all(0),
                enableFeedback: true,
                onPressed: () {},
                icon: const Icon(CupertinoIcons.forward),
              )
            ],
          ),
        ),
        SizedBox(
          height: height / 3,
          child: Consumer(
            key: const ValueKey<String>("horror"),
            builder: (context, ref, child) {
              final horror = ref.watch(horrorMovieProvider);
              return horror.when(
                data: (data) => data.fold((l) => const Text("Error"), (r) {
                  if (r.results.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: r.results.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            PageTransition(
                              child: MovieDescScreen(movie: r.results[index]),
                              type: PageTransitionType.fade,
                            ),
                          ),
                          child: CustomHero(
                            tag: 'movie${r.results[index].id}',
                            child: Container(
                              height: height / 3,
                              width: width / 4,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(4, 1),
                                    spreadRadius: -10,
                                    blurRadius: 17,
                                    color: Color.fromRGBO(0, 0, 0, 0.43),
                                  )
                                ],
                                image: r.results[index].posterPath != null
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                          "$baseImageUrl${r.results[index].posterPath}",
                                        ),
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.transparent, Colors.black],
                                  ),
                                ),
                                height: height / 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Spacer(),
                                      Text(
                                        r.results[index].title ?? 'N/A',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${r.results[index].originalTitle} | ${r.results[index].voteAverage} \u066D",
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              194, 255, 255, 255),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
                error: (error, stackTrace) => const Text("Error"),
                loading: () =>
                    const Center(child: CircularProgressIndicator.adaptive()),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Thrillers",
                style: TextStyle(fontSize: 20, color: getTheme()),
              ),
              IconButton(
                padding: const EdgeInsets.all(0),
                enableFeedback: true,
                onPressed: () {},
                icon: const Icon(CupertinoIcons.forward),
              )
            ],
          ),
        ),
        SizedBox(
          height: height / 3,
          child: Consumer(
            key: const ValueKey<String>("thriller"),
            builder: (context, ref, child) {
              final thriller = ref.watch(thrillerMovieProvider);
              return thriller.when(
                data: (data) => data.fold((l) => const Text("Error"), (r) {
                  if (r.results.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: r.results.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            PageTransition(
                              child: MovieDescScreen(movie: r.results[index]),
                              type: PageTransitionType.fade,
                            ),
                          ),
                          child: CustomHero(
                            tag: 'movie${r.results[index].id}',
                            child: Container(
                              height: height / 3,
                              width: width / 4,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(4, 1),
                                    spreadRadius: -10,
                                    blurRadius: 17,
                                    color: Color.fromRGBO(0, 0, 0, 0.43),
                                  )
                                ],
                                image: r.results[index].posterPath != null
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                          "$baseImageUrl${r.results[index].posterPath}",
                                        ),
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.transparent, Colors.black],
                                  ),
                                ),
                                height: height / 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Spacer(),
                                      Text(
                                        r.results[index].title ?? 'N/A',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${r.results[index].originalTitle} | ${r.results[index].voteAverage} \u066D",
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              194, 255, 255, 255),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
                error: (error, stackTrace) => const Text("Error"),
                loading: () =>
                    const Center(child: CircularProgressIndicator.adaptive()),
              );
            },
          ),
        )
      ],
    );
  }
}
