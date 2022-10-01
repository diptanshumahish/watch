import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height / 2.5,
                  width: width / 3,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
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
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
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
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
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
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
              }),
        )
      ],
    );
  }
}
