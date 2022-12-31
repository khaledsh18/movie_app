import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../screens/movie_page/movie_controller.dart';
import 'clip_path/clip_shadow_path.dart';
import 'clip_path/custom_clip_path.dart';

class CustomImageView extends StatelessWidget {
  const CustomImageView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final MovieController controller;

  @override
  Widget build(BuildContext context) {
    return ClipShadowPath(
      shadow: const Shadow(blurRadius: 20),
      clipper: CustomClipPath(),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: CachedNetworkImageProvider(
                'https://image.tmdb.org/t/p/original${controller.movieModal.movie.backdrop}'),
          ),
        ),
      ),
    );
  }
}