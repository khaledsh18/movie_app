import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_app/entities/movie.dart';
import 'package:movie_app/entities/movie_modal.dart';
import 'package:movie_app/screens/my_list_page/my_list_functions.dart';
import 'package:movie_app/widgets/movie_tile.dart';

class MyListPage extends StatelessWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My List',
        ),
      ),
      body: ValueListenableBuilder<Box>(
          valueListenable: Hive.box('My_List').listenable(),
          builder: (context, box, child) {
            if (box.isEmpty) {
              return const EmptyMovieTile();
            }
            return CustomScrollView(
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
                      final modal = MovieModal.fromJson(box.getAt(index));
                      return MyListMovieTile(
                        onRemove: ()async{
                          await MyListFunctions().deleteMovie(modal);
                        },
                        movie: modal.movie,
                      );
                    },
                    childCount: box.length,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
