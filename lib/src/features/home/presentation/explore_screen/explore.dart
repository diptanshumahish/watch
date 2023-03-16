import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/controller/search_controller.dart';
import 'components/search_result_widget.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final List<String> images = [
    'https://github.com/diptanshumahish/watch_images/raw/main/horror.webp',
    'https://github.com/diptanshumahish/watch_images/raw/main/scifi.webp',
    'https://github.com/diptanshumahish/watch_images/raw/main/thriller.webp',
    'https://github.com/diptanshumahish/watch_images/raw/main/drama.webp',
    'https://github.com/diptanshumahish/watch_images/raw/main/anime.webp',
    'https://github.com/diptanshumahish/watch_images/raw/main/action.webp',
    'https://github.com/diptanshumahish/watch_images/raw/main/comedy.webp',
    'https://github.com/diptanshumahish/watch_images/raw/main/tragedy.webp',
  ];
  final List<String> searchTags = [
    'horror',
    'Sci-Fi',
    'Thriller',
    'Drama',
    'Anime',
    'Action',
    'Comedy',
    'Tragedy',
  ];
  final List<String> tagLines = [
    'Shivers all around!',
    'the modern days!',
    'Some thrillers here',
    'The dramatical things',
    'The anime lovers!',
    'Fully packed in here',
    "let's laugh a bit?",
    'some sad stories'
  ];
  Color getTheme() {
    if (Theme.of(context).brightness == Brightness.dark) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Timer? _timer;
  String? lastQuery;

  void debounce(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(const Duration(milliseconds: 800), action);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Explore',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Search for movies/Web series',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CupertinoSearchTextField(
            onChanged: (value) {
              String query = value.trim();
              if (value.length > 2 && query != lastQuery) {
                debounce(() async {
                  await ref
                      .read(exploreControllerProvider.notifier)
                      .onSearch(query);
                  lastQuery = query;
                });
              }
            },
            padding: const EdgeInsets.all(10),
            placeholder: 'Search for movies/webseries',
            style: TextStyle(color: getTheme()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SearchResult(
            images: images,
            searchTags: searchTags,
            tagLines: tagLines,
          ),
        ),
      ],
    );
  }
}
