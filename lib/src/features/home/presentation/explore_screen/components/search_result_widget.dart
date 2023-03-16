import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../../app/constants/constants.dart';
import '../../../../../models/all_genres_model.dart';
import '../../../../../models/movie_details_model.dart';
import '../../../../../shared/shimmer_loaders.dart';
import '../../../app/controller/search_controller.dart';
import '../../../app/state/search_state.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({
    Key? key,
    required this.images,
    required this.searchTags,
    required this.tagLines,
  }) : super(key: key);

  final List<String> images;
  final List<String> searchTags;
  final List<String> tagLines;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(
      builder: (_, WidgetRef ref, Widget? child) {
        AsyncValue<ExploreState> exploreController =
            ref.watch(exploreControllerProvider);
        return exploreController.when(
          data: (ExploreState data) => data.when(
            initial: (List<Genre> genres) => Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: genres.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(width: 10),
                    itemBuilder: (BuildContext context, int index) {
                      return Chip(
                        label: Text(genres[index].name),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 16,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: const <BoxShadow>[
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
                            image: NetworkImage(
                              images[index],
                            ),
                          ),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: size.height / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: <Color>[
                                    Colors.transparent,
                                    Colors.black
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
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
                                      style: const TextStyle(
                                          color: Color(0xFFCBCACA)),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            loaded: (MovieDetail movies) {
              if (movies.results.isEmpty) {
                return const Center(child: Text('No Results Found'));
              }
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: movies.results.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 16),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
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
                          image: NetworkImage(
                            movies.results[index].posterPath != null
                                ? "$baseImageUrl${movies.results[index].posterPath}"
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
                                colors: [Colors.transparent, Colors.black],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movies.results[index].title ?? 'N/A',
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    movies.results[index].overview ?? 'N/A',
                                    style: const TextStyle(
                                      color: Color(0xFFCBCACA),
                                    ),
                                    maxLines: 3,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          error: (Object error, StackTrace stack) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Text>[
              Text('Error: $error'),
            ],
          ),
          loading: () => SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const ShimmerGridSkeleton(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
          ),
        );
      },
    );
  }
}
