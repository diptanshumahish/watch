import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watch/screens/homepage.dart';

class Reccomendations extends StatefulWidget {
  const Reccomendations({super.key});

  @override
  State<Reccomendations> createState() => _ReccomendationsState();
}

class _ReccomendationsState extends State<Reccomendations> {
  var filter = Colors.transparent;
  @override
  Widget build(BuildContext context) {
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
                          "Chose 3 shows",
                          style: TextStyle(
                              fontSize: height / 22,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "that interest you",
                          style: TextStyle(
                              fontSize: height / 22,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (() {}),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Skip",
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
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 5,
                    childAspectRatio: 3 / 4,
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: (() {
                        setState(() {
                          filter = Colors.black;
                        });
                      }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        height: height / 3,
                        child: Container(
                            decoration: BoxDecoration(
                                color: filter,
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: InkWell(
              onTap: (() {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    PageTransition(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.bounceIn,
                        child: const HomePage(),
                        type: PageTransitionType.bottomToTop));
              }),
              child: Container(
                width: width,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black),
                child: const Center(
                  child: Text("Done", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
