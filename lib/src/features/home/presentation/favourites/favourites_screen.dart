import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../app/constants/api_urls.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../shared/shimmer_loaders.dart';
import '../../app/controller/favourites_controller.dart';
import '../../app/state/favourite_state.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Flexible(
              child: Text(
                'Your Favourites',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Expanded(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              AsyncValue<FavouriteState> result =
                  ref.watch(favouritesControllerProvider);
              return result.maybeWhen(
                data: (FavouriteState result) {
                  return result.when(
                    loaded: (List<dynamic> results) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          ref.invalidate(favouritesControllerProvider);
                          ref.read(favouritesControllerProvider);
                          return;
                        },
                        child: GridBuilder(
                          res: results,
                        ),
                      );
                    },
                    empty: () => const Center(
                      child: Text('No Favourites'),
                    ),
                    error: (Failure failure) => Center(
                      child: Text(failure.toString()),
                    ),
                  );
                },
                orElse: () => const ShimmerGridSkeleton(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class GridBuilder extends StatelessWidget {
  final List<dynamic> res;

  const GridBuilder({Key? key, required this.res}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: res.length,
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
      itemBuilder: (BuildContext context, int index) => Container(
        decoration: BoxDecoration(
          boxShadow: const <BoxShadow>[
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
              res[index]['posterPath'] != null
                  ? "$baseImageUrl${res[index]['posterPath']}"
                  : 'https://www.woolha.com/media/2020/03/eevee.png',
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
                  colors: <Color>[Colors.transparent, Colors.black],
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
                      res[index]['title'] ?? 'N/A',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      res[index]['releaseDate'] ?? 'N/A',
                      style: const TextStyle(color: Color(0xFFCBCACA)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
