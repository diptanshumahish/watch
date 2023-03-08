import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ActorTile extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;
  const ActorTile(
      {Key? key,
      this.name = 'Maria Espaes',
      this.role = 'As Maria',
      this.imageUrl =
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzHQv_th9wq3ivQ1CVk7UZRxhbPq64oQrg5Q&usqp=CAU'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: 60,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF5E5E5E), width: 0.5),
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  const Color(0xff000000),
                  const Color(0xffE9E9E9).withOpacity(0.05),
                ],
              ),
            ),
            margin: const EdgeInsets.only(left: 30, top: 5, bottom: 5),
            padding: const EdgeInsets.only(left: 35, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 2),
                Text(
                  role,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 11, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            width: 60,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (_, ImageProvider<Object> imageProvider) =>
                  Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              errorWidget: (_, String url, error) => const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
