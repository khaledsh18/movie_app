import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/entities/cast.dart';
import 'package:movie_app/screens/my_list_page/my_list_functions.dart';

import '../constants.dart';
import '../entities/movie.dart';
import 'clip_path/clip_shadow_path.dart';
import 'clip_path/custom_clip_path.dart';

class MainMovieTile extends StatelessWidget {
  final Movie movie;
  final Function()? onTap;

  const MainMovieTile({Key? key, required this.movie, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: 20,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 150,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backgroundTransparent,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/original${movie.posterUrl}',
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => const Center(child: Text('No Image',style: TextStyle(color: Colors.black),)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyMovieTile extends StatelessWidget {
  const EmptyMovieTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Material(
        elevation: 20,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 150,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: backgroundTransparent,
          ),
        ),
      ),
    );
  }
}

class MovieListTile extends StatefulWidget {
  final Movie movie;
  final Function()? onTap;
  final double width;

  MovieListTile(
      {Key? key, required this.movie, this.onTap, required this.width})
      : super(key: key) {
  }

  @override
  State<MovieListTile> createState() => _MovieListTileState();
}

class _MovieListTileState extends State<MovieListTile> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    setIsBookmarked(widget.movie);
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Material(
              elevation: 12,
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 180,
                width: widget.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: backgroundTransparent,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/original${widget.movie.posterUrl}',
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => const Center(child: Text('No Image',style: TextStyle(color: Colors.black),)),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: ()async{
                await MyListFunctions().addDeleteMovie(movie: widget.movie,isBookmarked: isBookmarked);
                setIsBookmarked(widget.movie);
              },
              child: ClipPath(
                clipper: BookmarkClipPath(),
                child: Container(
                  height: 50,
                  width: 25,
                  decoration: BoxDecoration(
                    color: isBookmarked ? Colors.yellow : backgroundTransparent,
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(20)),
                  ),
                  child: Visibility(
                    visible: !isBookmarked,
                    child: Icon(Icons.add),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  setIsBookmarked(Movie movie) async {
    var box = Hive.box('My_List');
    final modal = await box.get(movie.id.toString());
    if(modal == null){
      setState(() {
        isBookmarked = false;
      });
    }else{
      setState(() {
        isBookmarked = true;
      });
    }
  }
}

class EmptyMovieListTile extends StatelessWidget {
  const EmptyMovieListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Material(
        elevation: 12,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 150,
          width: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: backgroundTransparent,
          ),
        ),
      ),
    );
  }
}

class MyListMovieTile extends StatelessWidget {
  final Movie movie;
  final Function()? onTap;
  final Function()? onRemove;

  const MyListMovieTile(
      {Key? key, required this.movie, this.onTap, this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Material(
              elevation: 20,
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 170,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: backgroundTransparent,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/original${movie.posterUrl}',
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => const Center(child: Text('No Image',style: TextStyle(color: Colors.black),)),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onRemove,
              child: ClipPath(
                clipper: BookmarkClipPath(),
                child: Container(
                  height: 50,
                  width: 25,
                  decoration: const BoxDecoration(
                      color: Colors.yellow,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(10))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
