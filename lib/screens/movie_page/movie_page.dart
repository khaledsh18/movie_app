import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movie_app/animation.dart';
import 'package:movie_app/widgets/title_label.dart';
import '../../entities/genre.dart';
import '../../widgets/cast_tiles.dart';
import '../../widgets/custom_image.dart';
import 'movie_controller.dart';

class MoviePage extends GetView<MovieController> {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0x20000000),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(() => loadViews(context)),
      ),
    );
  }

  getGenres(BuildContext context) {
    List<Widget> genres = [];
    for (Genre genre in controller.movieModal.details.genres) {
      genres.add(Text('${genre.name}, '));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: genres,
    );
  }

  loadViews(BuildContext context) {
    if (controller.isLoading.isFalse) {
      return Column(
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height/2) + 30,
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                CustomImageView(controller: controller),
                Positioned(
                  top: (MediaQuery.of(context).size.height/3),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: 130,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 15,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: CachedNetworkImageProvider(
                            'https://image.tmdb.org/t/p/original${controller.movieModal.movie.posterUrl}'),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.height/2) - 30,
                  right: MediaQuery.of(context).size.width/6,
                  child: IconButton(
                    icon: controller.isFav.isTrue ? const Icon(Icons.bookmark): const Icon(Icons.bookmark_add_outlined),
                    onPressed: () {
                      controller.addToList(controller.movieModal);
                    },
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.height/2) - 30,
                  left: MediaQuery.of(context).size.width/6,
                  child: IconButton(
                    icon: const Icon(Icons.share_outlined),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          DelayedDisplay(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        controller.movieModal.movie.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      getGenres(context),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Label(
                              title: 'Rate',
                              data: controller.movieModal.details.voteAverage
                                  .toStringAsFixed(1),
                            ),
                          ),
                          Flexible(
                            child: Label(
                              title: 'Release',
                              data: controller.movieModal.details.releaseDate,
                            ),
                          ),
                          Flexible(
                            child: Label(
                              title: 'Length',
                              data: '${controller.movieModal.details.length} min',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(controller.movieModal.details.overview),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                const TitleLabel(title: 'Casts'),
                loadCasts(),
              ],
            ),
          ),
        ],
      );
    } else {
      return const SizedBox(
        width: 5,
      );
    }
  }

  loadCasts() {
    if (controller.casts.isNotEmpty) {
      return HorizontalCastsListView(listMovies: controller.casts);
    } else {
      return const SizedBox(
        width: 5,
      );
    }
  }
}

class Label extends StatelessWidget {
  final String title;
  final String data;

  const Label({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Text(
          data,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
