import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../app/utils/snackbar/snackbar.dart';
import '../../../../providers/user_provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../shared/background_painter.dart';
import '../../app/controller/profile_controller.dart';
import 'components/logout_dialog.dart';

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
                            style: textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) => const LogoutDialog(),
                            );
                          },
                          tooltip: 'Sign Out',
                          icon: const Icon(
                            Icons.logout_rounded,
                            size: 30,
                            color: Colors.orange,
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
                          style: textTheme.bodyText2?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Consumer(builder: (context, ref, child) {
                      return Container(
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
                              imageUrl: ref
                                      .watch(profileNotifier.notifier)
                                      .userPhotoURL ??
                                  'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
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
                                onPressed: () async {
                                  ImagePicker picker = ImagePicker();
                                  XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (image == null) {
                                    showSnackbar('No Image Selected',
                                        backgroundColor: Colors.red);
                                    return;
                                  }
                                  await ref
                                      .read(profileNotifier.notifier)
                                      .uploadFile(File(image.path));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 43),
                    Consumer(builder: (context, ref, child) {
                      var name = ref.watch(userNotifierProvider
                          .select((value) => value.displayName));
                      return Text(
                        'Name : ${name ?? 'N/A'}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }),
                    const SizedBox(height: 5),
                    Consumer(builder: (context, ref, child) {
                      var e = ref.watch(
                          userNotifierProvider.select((value) => value.email));
                      return Text(
                        'Email : ${e ?? 'N/A'}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Headlines',
                            style: textTheme.headlineSmall?.copyWith(
                              fontSize: 18,
                              color: Colors.white,
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
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: e == 'Trending'
                              ? () =>
                                  Navigator.pushNamed(context, trendingRoute)
                              : null,
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          ),
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
                              color: Colors.white,
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
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          ),
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
                              color: Colors.white,
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
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
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
