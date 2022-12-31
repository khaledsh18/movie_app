import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_page/movie_page.dart';

import '../entities/movie.dart';
import '../screens/movie_page/movie_controller.dart';
import 'movie_tile.dart';
import 'package:get/get.dart';

class HorizontalListView extends StatelessWidget {
  HorizontalListView({
    Key? key,
    required this.listMovies,
  }) : super(key: key);

  final List<Movie> listMovies;
  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return MovieListTile(
            width: 130,
            movie: listMovies[index],
            onTap: (){
              movieController.isLoading.value = true;
              movieController.setMovie(listMovies[index]);
              Get.to(()=> const MoviePage());
              },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 10,
        ),
      ),
    );
  }
}

class EmptyHorizontalListView extends StatelessWidget {
  const EmptyHorizontalListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Padding(
            padding:  EdgeInsets.only(bottom: 25.0),
            child: EmptyMovieListTile(
              width: 130,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 10,
        ),
      ),
    );
  }
}

class MoviesSwiper extends StatelessWidget {
  MoviesSwiper({
    Key? key,
    required this.movies,
  }) : super(key: key);

  final List<Movie> movies;
  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return MainMovieTile(
            movie: movies[index],
            onTap: (){
              movieController.isLoading.value = true;
              movieController.setMovie(movies[index]);
              Get.to(()=> const MoviePage());
            },
          );
        },
        autoplay: true,
        duration: 1000,
        autoplayDelay: 10000,
        itemCount: 4,
        viewportFraction: 0.85,
        scale: 0.9,
      ),
    );
  }
}
