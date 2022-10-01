import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watch/screens/mainscreenpages/fulldetails.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            children: const [
              Text("Welcome Friend",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Text("Let's see what's here for you",
                  style: TextStyle(fontSize: 25, color: Colors.grey))
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
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const FullDetails(),
                              type: PageTransitionType.rightToLeft));
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
              const Text(
                "Specialy picked for you",
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                  padding: const EdgeInsets.all(0),
                  enableFeedback: true,
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.forward))
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
                                "https://github.com/diptanshumahish/watch_images/raw/main/tragedy.webp")),
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
                  icon: const Icon(CupertinoIcons.forward))
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
                                "https://github.com/diptanshumahish/watch_images/raw/main/drama.webp")),
                        borderRadius: BorderRadius.circular(10)),
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
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Thrillers",
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                  padding: const EdgeInsets.all(0),
                  enableFeedback: true,
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.forward))
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
                                "https://github.com/diptanshumahish/watch_images/raw/main/action.webp")),
                        borderRadius: BorderRadius.circular(10)),
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
                );
              }),
        )
      ],
    );
  }
}
