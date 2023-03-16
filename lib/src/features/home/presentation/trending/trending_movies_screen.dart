import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marquee/marquee.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../app/constants/api_urls.dart';
import '../../../../shared/custom_hero.dart';
import '../../../../shared/shimmer_loaders.dart';
import '../../app/controller/trending_controller.dart';
import '../movie_details/movie_details_screen.dart';

class TrendingMoviesScreen extends StatelessWidget {
  const TrendingMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text('Trending Movies'),
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            var trending = ref.watch(trendingControllerProvider);
            return trending.maybeWhen(
              data: (data) => data.when(
                empty: () => const Center(child: Text('No data')),
                error: (message) => Center(child: Text(message.message)),
                loaded: (movies) => GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: movies.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 16,
                  ),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => Navigator.push(
                      context,
                      PageTransition(
                        child: MovieDescScreen(movie: movies[index]),
                        type: PageTransitionType.fade,
                      ),
                    ),
                    child: CustomHero(
                      tag: 'movie${movies[index].id}',
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
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              movies[index].posterPath != null
                                  ? '$baseImageUrl${movies[index].posterPath}'
                                  : 'https://www.woolha.com/media/2020/03/eevee.png',
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              height: size.height / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black,
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: size.width / 2.3,
                                    maxHeight: 60,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Marquee(
                                          text: movies[index].title ?? 'N/A',
                                          blankSpace: 200,
                                          pauseAfterRound:
                                              const Duration(seconds: 1),
                                          numberOfRounds: 3,
                                          velocity: 50,
                                          startAfter:
                                              const Duration(seconds: 2),
                                          scrollAxis: Axis.horizontal,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        movies[index].releaseDate ?? 'N/A',
                                        style: const TextStyle(
                                          color: Color(0xFFCBCACA),
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
                    ),
                  ),
                ),
              ),
              orElse: () => const ShimmerGridSkeleton(),
            );
          },
        ),
      ),
    );
  }
}
