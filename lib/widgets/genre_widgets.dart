
import 'package:flutter/material.dart';

import '../constants.dart';
import '../entities/genre.dart';

class GenresListView extends StatelessWidget {
  const GenresListView({super.key, required this.selectedGenre, this.onTap});

  final Genre selectedGenre;
  final Function(Genre genre)? onTap;

  @override
  Widget build(
      BuildContext context,
      ) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.08,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) =>
            SizedBox(width: size.width * 0.02),
        padding:
        EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 10),
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) => GenreCard(
          onTap: onTap,
          index: index,
          selectedGenre: selectedGenre,
        ),
      ),
    );
  }
}

class GenreCard extends StatelessWidget {
  GenreCard(
      {Key? key, required this.index, required this.selectedGenre, this.onTap})
      : super(key: key) {}
  final Genre selectedGenre;
  final Function(Genre genre)? onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final genre = genres[index];
    bool isSelected = genre.id == selectedGenre.id;
    return GestureDetector(
      onTap: () {
        onTap!(genre);
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          constraints: BoxConstraints(minWidth: size.width * 0.1),
          decoration: BoxDecoration(
              color: isSelected ? primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02, vertical: size.height * 0.01),
          child: Text(genre.name,
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }
}