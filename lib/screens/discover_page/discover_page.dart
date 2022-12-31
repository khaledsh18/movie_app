import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/genre_widgets.dart';
import '../../widgets/movie_tile.dart';
import '../../widgets/pages_widgets.dart';
import '../movie_page/movie_controller.dart';
import '../movie_page/movie_page.dart';
import 'discover_controller.dart';

class DiscoverPage extends GetView<DiscoverController> {
  final DiscoverController discoverController = Get.put(DiscoverController());

  DiscoverPage({super.key}) {
    discoverController.setMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: Obx(
        () => Column(
          children: [
            GenresListView(
              onTap: (genre) {
                discoverController.isLoading.value =true;
                discoverController.selectedGenre.value = genre;
                discoverController.setMovies();
              },
              selectedGenre: discoverController.selectedGenre.value,
            ),
            loadViews(),
            PagesListView(
              onTap: (page) {
                discoverController.selectedPage.value = page.toInt();
                discoverController.setMovies();
              },
              selectedPage: discoverController.selectedPage.value,
            ),
          ],
        ),
      ),
    );
  }

  loadViews() {
    final MovieController movieController = Get.put(MovieController());
    if (discoverController.isLoading.isFalse) {
      return Flexible(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return MovieListTile(
                    width: 170,
                    onTap: () {
                      movieController.isLoading.value = true;
                      movieController
                          .setMovie(discoverController.movies[index]);
                      Get.to(() => MoviePage());
                    },
                    movie: discoverController.movies[index],
                  );
                },
                childCount: discoverController.movies.length,
              ),
            ),
          ],
        ),
      );
    } else {
      return Flexible(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return const EmptyMovieListTile();
                },
                childCount: 8,
              ),
            ),
          ],
        ),
      );
    }
  }
}
