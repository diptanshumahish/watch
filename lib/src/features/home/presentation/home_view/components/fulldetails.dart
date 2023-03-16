import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

bool isLiked = false;

class FullDetails extends StatefulWidget {
  const FullDetails({super.key});

  @override
  State<FullDetails> createState() => _FullDetailsState();
}

class _FullDetailsState extends State<FullDetails> {
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

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              height: height / 2,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://github.com/diptanshumahish/watch_images/raw/main/action.webp'))),
              child: Container(
                height: height / 2,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromARGB(162, 0, 0, 0),
                      Color.fromARGB(24, 0, 0, 0),
                      Colors.black
                    ])),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: (() => Navigator.pop(context)),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  color: const Color.fromARGB(133, 26, 25, 25),
                                  shape: BoxShape.circle),
                              child: const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Center(
                                    child: Icon(
                                  CupertinoIcons.back,
                                  size: 15,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                color: const Color.fromARGB(133, 26, 25, 25),
                                shape: BoxShape.circle),
                            child: const Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Center(
                                  child: Icon(
                                Iconsax.share,
                                color: Colors.white,
                                size: 15,
                              )),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Text(
                        'Annabelle',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Miss me?',
                        style: TextStyle(
                          color: Color.fromARGB(143, 255, 255, 255),
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0x69FFFFFF)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('Rating: ',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  192, 255, 255, 255))),
                                      Text('8.4',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0x69FFFFFF)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Center(
                                    child: Text('Horror',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width * 0.8,
                    height: 45,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(4, 1),
                            spreadRadius: -10,
                            blurRadius: 17,
                            color: Color.fromRGBO(0, 0, 0, 0.43),
                          )
                        ],
                        borderRadius: BorderRadius.circular(5),
                        color: getTheme()),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.play_arrow_solid,
                              color: getThemeInv()),
                          Text('Watch Trailer',
                              style: TextStyle(color: getThemeInv())),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isLiked ? isLiked = false : isLiked = true;
                      });
                    },
                    child: Container(
                      width: width * 0.12,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: getTheme().withOpacity(0.5))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Icon(isLiked
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "In Santa Monica, California, John Form, a doctor, presents his expectant wife Mia with a rare vintage porcelain doll as a gift for their first child to be placed in a collection of dolls in their daughter's nursery.That night, the couple is disturbed by the sounds of their next door neighbors, the Higgins, being murdered during a home invasion. While Mia calls the police, she and John are attacked by the Higgins' killers. The police arrive and shoot one killer, a man, dead while the female killer kills herself by slitting her throat inside the nursery while holding the doll. News reports identify the assailants as the Higgins' estranged daughter, Annabelle, and her unidentified boyfriend, both members of a cult.",
                style: TextStyle(
                    color: getTheme(),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
