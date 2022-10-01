import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var visibility = true;
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
                });
              } else {
                setState(() {
                  visibility = false;
                });
              }
            }),
            placeholder: "Search for movies/webseries",
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
        )
      ],
    );
  }
}
