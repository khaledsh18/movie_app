import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants.dart';

import '../../entities/movie.dart';
import '../../network_utils/network_utils.dart';

class HomeController extends GetxController {
  var movies = <Movie>[].obs;
  var nowPlaying = <Movie>[].obs;
  var trendingMovies = <Movie>[].obs;
  var upcomingMovies = <Movie>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    setMovies('1');
  }

  Future<void> setMovies(page) async {
    if(Get.isSnackbarOpen) Get.closeCurrentSnackbar();
    isLoading.value = true;
    var response = await NetworkUtils().getMovies(page: page);
    if (response['is_success']) {
      List<Movie> moviesList = response['movies'];
      movies.value = moviesList;
    } else {
      showSnackBar();
      return;
    }
    var response2 = await NetworkUtils().getCustomMovies(MovieSelection.now_playing.name);
    if (response2['is_success']) {
      List<Movie> nowList = response2['movies'];
      nowPlaying.value = nowList;
    } else {
      showSnackBar();
      return;
    }
    var response3 = await NetworkUtils().getCustomMovies(MovieSelection.trending.name);
    if (response3['is_success']) {
      List<Movie> popularList = response3['movies'];
      trendingMovies.value = popularList;
    } else {
      showSnackBar();
      return;
    }
    var response4 = await NetworkUtils().getCustomMovies(MovieSelection.upcoming.name);
    if (response4['is_success']) {
      List<Movie> upcomingList = response4['movies'];
      upcomingMovies.value = upcomingList;
    } else {
      showSnackBar();
      return;
    }
    isLoading.value = false;
  }

  void showSnackBar() {
    Get.showSnackbar(
      GetSnackBar(
        title: 'Check Your Internet Connection',
        message: 'Your Internet Connection has been lost',
        mainButton: IconButton(
          onPressed: () {
            Get.closeCurrentSnackbar();
            setMovies('1');
          },
          icon: const Icon(Icons.refresh_rounded),color: Colors.white,),
      ),
    );
  }
}
