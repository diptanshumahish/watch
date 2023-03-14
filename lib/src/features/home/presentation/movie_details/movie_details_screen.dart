import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:watch/app/utils/snackbar/snackbar.dart';
import 'package:watch/src/features/home/data/tmdb_api.dart';
import 'package:watch/src/providers/firestore_provider.dart';
import 'package:watch/src/shared/background_painter.dart';
import 'package:watch/src/shared/custom_hero.dart';
import 'package:watch/src/shared/custom_paints.dart';
import 'package:watch/src/shared/loading_dialog.dart';

import '../../../../../app/constants/api_urls.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../models/movie_details_model.dart';
import 'actors_tile.dart';

class MovieDescScreen extends HookConsumerWidget {
  final Result movie;
  const MovieDescScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likeNotifier = useState(false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: PaintedBackground(
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
                automaticallyImplyLeading: false,
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
                    child: Text(
                      movie.title ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  background: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomHero(
                          tag: 'movie${movie.id}',
                          child: CachedNetworkImage(
                            imageUrl: movie.backdropPath != null
                                ? '$baseImageUrl${movie.backdropPath}'
                                : 'https://images5.alphacoders.com/998/998470.jpg',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      if (movie.voteAverage != null) ...[
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            constraints: const BoxConstraints(
                                maxHeight: 40, maxWidth: 60),
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
                                Flexible(
                                  child: Text(
                                    movie.voteAverage!.toStringAsFixed(2),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.play_arrow_rounded),
                              label: const Text('Play'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                fixedSize: const Size.fromHeight(46),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          //TODO: ADD firebase auth then we can get the user id
                          ValueListenableBuilder(
                            valueListenable: likeNotifier,
                            builder: (_, val, child) {
                              return LikeButton(
                                isLiked: val,
                                onTap: (isLiked) async {
                                  try {
                                    context.showLoaderDialog();
                                    Either<Failure, Unit> res = await ref
                                        .read(firestoreServiceProvider)
                                        .addLikedItem(likedItem: movie);
                                    res.fold(
                                      (l) {
                                        context.showSnackBar(l.message,
                                            isError: true);
                                        return;
                                      },
                                      (r) {
                                        context.showSnackBar('Added to Liked');
                                        likeNotifier.value = !val;
                                        return;
                                      },
                                    );
                                    return null;
                                  } finally {
                                    context.hideLoaderDialog();
                                  }
                                },
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        movie.overview ?? 'N/A',
                        maxLines: 6,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 40),
                      if (movie.id != null) ...[
                        ref.watch(castProvider(movie.id!)).maybeWhen(
                              data: (data) => data.fold(
                                (l) => const SizedBox.shrink(),
                                (r) => SizedBox(
                                  height: 60,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: r.cast.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 10),
                                    itemBuilder: (context, index) {
                                      return ActorTile(
                                        name: r.cast[index].name ?? 'N/A',
                                        role: r.cast[index].character ?? 'N/A',
                                        imageUrl: r.cast[index].profilePath,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              loading: () => const SizedBox.square(
                                dimension: 50,
                                child: Center(
                                    child:
                                        CircularProgressIndicator.adaptive()),
                              ),
                              orElse: () => const SizedBox.shrink(),
                            )
                      ],
                      const SizedBox(height: 80),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.19),
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEE1520),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFFEE1520).withOpacity(0.52),
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
      ),
    );
  }
}
