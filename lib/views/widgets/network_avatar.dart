import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkAvatar extends StatelessWidget {
  const NetworkAvatar({
    Key? key,
    required this.link,
    this.decoration,
    this.height = 20.0,
    this.width = 20.0,
    this.borderRadius = 50.0,
    this.placehouderText = "error",
  }) : super(key: key);

  final String link;
  final double height;
  final double width;
  final double borderRadius;
  final String placehouderText;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: decoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: link != ""
              ? link
              : 'https://hook.finance/sites/default/files/user.png',
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        // child: Center(child: Text(placehouderText)),
      ),
    );
  }
}
