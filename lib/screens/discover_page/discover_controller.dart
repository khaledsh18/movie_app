import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants.dart';

import '../../entities/genre.dart';
import '../../entities/movie.dart';
import '../../network_utils/network_utils.dart';

class DiscoverController extends GetxController {
  var movies = <Movie>[].obs;
  var isLoading = true.obs;
  var selectedPage = 1.obs;
  var selectedGenre = genres[0].obs;

  void setMovies() async {
    List<Movie> moviesList = [];
    var response = await NetworkUtils().getMovies(
      page: selectedPage.value.toString(),
      genreId: selectedGenre.value.id,
    );
    // if (selectedGenre.value.id == 0) {
    //   moviesList =
    //       await NetworkUtils().getMovies(page: selectedPage.value.toString());
    // } else {
    //   moviesList = await NetworkUtils().getMovies(
    //     page: selectedPage.value.toString(),
    //     genreId: selectedGenre.value.id,
    //   );
    // }
    if (response['is_success']) {
      List<Movie> moviesList = response['movies'];
      movies.value = moviesList;
      isLoading.value = false;
    } else {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Check Your Internet',
          message: 'Your Internet has lost',
          mainButton: IconButton(
            onPressed: () {
              Get.closeCurrentSnackbar();
              setMovies();
            },
            icon: Icon(Icons.refresh_rounded),
            color: Colors.white,
          ),
        ),
      );
    }
  }
}
