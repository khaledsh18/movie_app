import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/animation.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/homepage/home_controller.dart';

import '../../widgets/background_button.dart';
import '../../widgets/horizontal_list_view.dart';
import '../../widgets/movie_tile.dart';
import '../../widgets/title_label.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MOVIES'),
      ),
      body: RefreshIndicator(
        color: primaryColor,
        onRefresh: () async {
          await controller.setMovies('1');
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(() => loadingView()),
        ),
      ),
    );
  }

  Widget loadingView() {
    if (controller.isLoading.isTrue) {
      return Column(
        children: [
          SizedBox(
            height: 240,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return const EmptyMovieTile();
              },
              autoplayDelay: 10000,
              itemCount: 4,
              viewportFraction: 0.85,
              scale: 0.9,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              DiscoverButton(),
              MyListButton(),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const TitleLabel(title: 'Trending'),
          const EmptyHorizontalListView(),
        ],
      );
    } else {
      return Column(
        children: [
          MoviesSwiper(movies: controller.movies),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              DiscoverButton(),
              MyListButton(),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TitleLabel(
            title: 'Trending',
            onPressed: () {},
          ),
          HorizontalListView(
            listMovies: controller.trendingMovies,
          ),
          AnimatedOpacity(
            opacity: controller.isLoading.isFalse ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: DelayedDisplay(
              child: Column(
                children: [
                  const TitleLabel(
                    title: 'Now Playing',
                  ),
                  HorizontalListView(listMovies: controller.nowPlaying),
                  const TitleLabel(
                    title: 'Upcoming Soon',
                  ),
                  HorizontalListView(listMovies: controller.upcomingMovies),
                ],
              ),
            ),
          )
        ],
      );
    }
  }
}
