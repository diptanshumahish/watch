import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../shared/background_painter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final List<String> headlines;
  late final List<String> content;
  late final List<String> preferences;
  @override
  void initState() {
    headlines = ['Popular', 'Trending', 'Today'];
    content = ['Favorites', 'Download'];
    preferences = ['Language', 'Dark Mode', 'Only Download via Wi-Fi'];
    super.initState();
  }

  @override
  void dispose() {
    headlines.clear();
    content.clear();
    preferences.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: PaintedBackground(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: SafeArea(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'My Profile',
                            style: textTheme.headlineSmall,
                          ),
                        ),
                        const Icon(
                          Icons.notifications_outlined,
                          size: 30,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Here are all your favorites',
                          style: textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFC4C4C4).withOpacity(0.89),
                            blurRadius: 60,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      height: 128,
                      width: 128,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://images.unsplash.com/photo-1601925662822-510b76665bd9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
                            imageBuilder:
                                (_, ImageProvider<Object> imageProvider) =>
                                    Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            errorWidget: (_, String url, error) => const Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                          Positioned(
                            bottom: -15,
                            right: 65,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 43),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Headlines',
                            style: textTheme.headlineSmall?.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ...headlines.map(
                      (e) => ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        dense: true,
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                e,
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 16,
                                  color: e == 'Trending'
                                      ? const Color(0XFF00FF38)
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 42),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Content',
                            style: textTheme.headlineSmall?.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ...content.map(
                      (e) => ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        dense: true,
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                e,
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 16,
                                  color: e == 'Favorites'
                                      ? const Color(0XFFFFD914)
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 42),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Preferences',
                            style: textTheme.headlineSmall?.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    ...preferences.map(
                      (e) => ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        dense: true,
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                e,
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
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
