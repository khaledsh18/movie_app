import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'entities/genre.dart';

const SystemUiOverlayStyle kSystemUiStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark
);
const Color primaryColor = Color(0xff2A4779);
const Color backgroundColor = Color(0xfff5f5f5);
const Color textColor = Color(0xff838083);
const Color backgroundTransparent = Color(0xCC9E9E9E);

enum MovieSelection {
  now_playing,
  trending,
  upcoming,
  discover,
}
List<Genre> genres = [
  Genre(id: 0, name: 'All'),
  Genre(id: 28, name: 'Action'),
  Genre(id: 12, name: 'Adventure'),
  Genre(id: 16, name: 'Animation'),
  Genre(id: 35, name: 'Comedy'),
  Genre(id: 80, name: 'Crime'),
  Genre(id: 99, name: 'Documentary'),
  Genre(id: 10751, name: 'Family'),
  Genre(id: 14, name: 'Fantasy'),
  Genre(id: 36, name: 'History'),
  Genre(id: 27, name: 'Horror'),
  Genre(id: 10402, name: 'Music'),
  Genre(id: 9648, name: 'Mystery'),
  Genre(id: 878, name: 'Science Fiction'),
  Genre(id: 10770, name: 'TV Movie'),
  Genre(id: 53, name: 'Thriller'),
  Genre(id: 10752, name: 'War'),
  Genre(id: 37, name: 'Western'),
];

List<int> pages = [
  1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
];