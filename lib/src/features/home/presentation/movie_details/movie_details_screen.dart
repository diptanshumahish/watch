import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:watch/src/shared/background_painter.dart';
import 'package:watch/src/shared/custom_paints.dart';

import 'actors_tile.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: PaintedBackground(
        painter: VariableColorPainter(
          [
            const Color(0xFF6326C6).withOpacity(0.8),
            const Color(0xFF1A1A1D),
          ],
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar.medium(
              expandedHeight: 260,
              floating: false,
              pinned: true,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                collapseMode: CollapseMode.parallax,
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
                titlePadding: const EdgeInsets.only(bottom: 16.0, left: 10),
                title: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width * 0.65),
                  child: const Text(
                    'Avengers: Endgame',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                background: Stack(
                  children: [
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://images5.alphacoders.com/998/998470.jpg',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        constraints:
                            const BoxConstraints(maxHeight: 40, maxWidth: 60),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RatingBarIndicator(
                              rating: 1,
                              itemBuilder: (_, __) => const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                              ),
                              itemCount: 1,
                              itemSize: 20,
                              direction: Axis.vertical,
                            ),
                            const Flexible(
                              child: Text(
                                '4.0',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 10,
                      child: Image.asset(
                        'assets/logo.png',
                        width: 65,
                        height: 65,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex...',
                      maxLines: 6,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Flexible(
                          child: ActorTile(
                            name: 'Robert Downey Jr.',
                            role: 'As Tony Stark',
                            imageUrl:
                                'http://t2.gstatic.com/licensed-image?q=tbn:ANd9GcQijI6Sf7U-nKAfhHFmFBhVVVIxOfzI3QBeHqEjXJ7qcqbu98eqykx0UdmHrvt9Wx5hKilfZROD0mR85gk',
                          ),
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: ActorTile(
                            name: 'Chris Evans',
                            role: 'As Steve',
                            imageUrl:
                                'https://cdn.britannica.com/28/215028-050-94E9EA1E/American-actor-Chris-Evans-2019.jpg',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      children: const [
                        Flexible(
                          child: ActorTile(
                            name: 'Tom Holland',
                            role: 'As Spiderman',
                            imageUrl:
                                'https://i.insider.com/61c1f0eeb95df80019963622?width=750&format=jpeg&auto=webp',
                          ),
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: ActorTile(
                            name: 'Chris Hemsworth',
                            role: 'As Thor',
                            imageUrl:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8ymFjeTls0g7hASSKpNLFM5rOtxG1GkiUT_rBBRDgjg&s',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.19),
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEE1520),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFEE1520).withOpacity(0.52),
                              blurRadius: 19,
                              spreadRadius: 6,
                            )
                          ],
                          borderRadius: BorderRadius.circular(7),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Watch Now',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
