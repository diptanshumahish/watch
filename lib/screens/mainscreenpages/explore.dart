import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var visibility = true;
bool searchVisibility = false;
var controller = TextEditingController();

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  void initState() {
    setState(() {
      visibility = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getTheme() {
      if (Theme.of(context).brightness == Brightness.dark) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }

    var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;
    var images = [
      "https://github.com/diptanshumahish/watch_images/raw/main/horror.webp",
      "https://github.com/diptanshumahish/watch_images/raw/main/scifi.webp",
      "https://github.com/diptanshumahish/watch_images/raw/main/thriller.webp",
      "https://github.com/diptanshumahish/watch_images/raw/main/drama.webp",
      "https://github.com/diptanshumahish/watch_images/raw/main/anime.webp",
      "https://github.com/diptanshumahish/watch_images/raw/main/action.webp",
      "https://github.com/diptanshumahish/watch_images/raw/main/comedy.webp",
      "https://github.com/diptanshumahish/watch_images/raw/main/tragedy.webp",
    ];
    var searchTags = [
      "horror",
      "Sci-Fi",
      "Thriller",
      "Drama",
      "Anime",
      "Action",
      "Comedy",
      "Tragedy",
    ];
    var tagLines = [
      "Shivers all around!",
      "the modern days!",
      "Some thrillers here",
      "The dramatical things",
      "The anime lovers!",
      "Fully packed in here",
      "let's laugh a bit?",
      "some sad stories"
    ];
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explore &",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: getTheme()),
              ),
              Text(
                "Search for movies/Web series",
                style: TextStyle(fontSize: 20, color: getTheme()),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CupertinoSearchTextField(
            controller: controller,
            onChanged: ((value) {
              late String search = controller.text;
              if (search == "") {
                setState(() {
                  controller.clear();
                  visibility = true;
                  searchVisibility = false;
                });
              } else {
                setState(() {
                  visibility = false;
                  searchVisibility = true;
                });
              }
            }),
            placeholder: "Search for movies/webseries",
            style: TextStyle(color: getTheme()),
          ),
        ),
        Visibility(
          visible: visibility,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 16),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (() {
                      setState(() {
                        visibility = false;
                      });
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(7, 6),
                              spreadRadius: -10,
                              blurRadius: 17,
                              color: Color.fromRGBO(0, 0, 0, 0.43),
                            )
                          ],
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(images[index]))),
                      // height: height / 4,
                      child: Stack(children: [
                        Container(
                          height: height / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black])),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  searchTags[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  tagLines[index],
                                  style:
                                      const TextStyle(color: Color(0xFFCBCACA)),
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                  );
                }),
          ),
        ),
        Visibility(
          visible: searchVisibility,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  childAspectRatio: 16 / 6),
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Container(
                      width: width * 0.3,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://github.com/diptanshumahish/watch_images/raw/main/horror.webp"))),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                      ),
                      width: width * 0.659,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Annabelle",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("Horror",
                                style: TextStyle(color: Colors.black)),
                            Text(
                              "9.4",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "In Santa Monica, California, John Form, a doctor, presents his expectant wife Mia with a rare vintage porcelain doll as a gift for their first child to be placed in a collection of dolls in their daughter's nursery.That night, the couple is disturbed by the sounds of their next door neighbors, the Higgins, being murdered during a home invasion. While Mia calls the police, she and John are attacked by the Higgins' killers. The police arrive and shoot one killer, a man, dead while the female killer kills herself by slitting her throat inside the nursery while holding the doll. News reports identify the assailants as the Higgins' estranged daughter, Annabelle, and her unidentified boyfriend, both members of a cult.",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
