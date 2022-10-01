import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FullDetails extends StatelessWidget {
  const FullDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              height: height / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://github.com/diptanshumahish/watch_images/raw/main/action.webp"))),
              child: Container(
                height: height / 2,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
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
                                  color: Color.fromARGB(133, 26, 25, 25),
                                  shape: BoxShape.circle),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Center(
                                    child: Icon(
                                  CupertinoIcons.back,
                                  size: 15,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                color: Color.fromARGB(133, 26, 25, 25),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
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
                      Spacer(),
                      Text(
                        "Annabelle",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Miss me?",
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
                              width: 80,
                              height: 20,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                width: 50,
                                height: 20,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text("Horror",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
