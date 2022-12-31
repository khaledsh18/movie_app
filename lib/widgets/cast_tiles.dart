import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../entities/cast.dart';

class HorizontalCastsListView extends StatelessWidget {
  const HorizontalCastsListView({
    Key? key,
    required this.listMovies,
  }) : super(key: key);

  final List<Cast> listMovies;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 3.5,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: listMovies.length,
        itemBuilder: (context, index) {
          return CastListTile(
            cast: listMovies[index],
            onTap: () {},
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 10,
        ),
      ),
    );
  }
}

class CastListTile extends StatelessWidget {
  final Cast cast;
  final Function()? onTap;

  const CastListTile({Key? key, required this.cast, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: 12,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Container(
                height: size.height / 5,
                width: 150,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                  color: backgroundTransparent,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/original${cast.photo}',
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => const Center(
                        child: Text(
                      'No Image',
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
                ),
              ),
              Text(cast.name,style: Theme.of(context).textTheme.bodyLarge,),
              const SizedBox(height: 5,),
              Text(cast.character),
            ],
          ),
        ),
      ),
    );
  }
}
