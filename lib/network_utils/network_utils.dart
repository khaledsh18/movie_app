import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/constants.dart';
import 'package:movie_app/entities/cast.dart';
import 'package:movie_app/entities/movie_details.dart';

import '../entities/movie.dart';
class NetworkUtils{
  final String api_key = '98e26b7aa7e058d01ef164a88aac3985';
  final String base_url = 'https://api.themoviedb.org/3/discover/movie?api_key=';

  getMovies({required String page,int? genreId}) async{
    if(genreId == 0) genreId = null;
    final String filters = '&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=true&page=$page&with_genres=$genreId&with_watch_monetization_types=flatrate';
    try{
      var response = await http.get(Uri.parse('$base_url$api_key$filters'));
      if (response.statusCode == 200) {
        Map<String, dynamic> output = json.decode(response.body);
        return {
          'is_success': true,
          'movies': Movie.fromJsonList(output['results']),
        };
      } else {
        return {
          'is_success': false,
          'message': 'error from database',
        };
      }
    }catch(e){
      return {
        'is_success': false,
        'message': e,
      };
    }
  }

  getCustomMovies(String type) async{
    late String url;
    if(type == MovieSelection.trending.name){
      url = 'https://api.themoviedb.org/3/trending/movie/day?api_key=$api_key';
    }else{
      url = 'https://api.themoviedb.org/3/movie/$type?api_key=$api_key&language=en-US';
    }

    try{
      var response = await http.get(
          Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> output = json.decode(response.body);
        return {
          'is_success': true,
          'movies': Movie.fromJsonList(output['results']),
        };
      } else {
        return {
          'is_success': false,
          'message': 'error from database',
        };
      }
    }catch(e){
      return {
        'is_success': false,
        'message': e,
      };
    }
  }

  getDetails(int id) async{
    try{
      var response = await http.get(
          Uri.parse('https://api.themoviedb.org/3/movie/$id?api_key=$api_key&language=en-US'));
      if (response.statusCode == 200) {
        var output = json.decode(response.body);
        return {
          'is_success': true,
          'details': MovieDetails.fromJson(output),
        };
      } else {
        return {
          'is_success': false,
          'message': 'error from database',
        };
      }
    }catch(e){
      return {
        'is_success': false,
        'message': e,
      };
    }
  }

  getCast(int id) async{
    try{
      var response = await http.get(
          Uri.parse('https://api.themoviedb.org/3/movie/$id/credits?api_key=$api_key&language=en-US'));
      if (response.statusCode == 200) {
        Map<String, dynamic> output = json.decode(response.body);
        return {
          'is_success': true,
          'casts': Cast.fromJsonList(output['cast']),
        };
      } else {
        return {
          'is_success': false,
          'message': 'error from database',
        };
      }
    }catch(e){
      return {
        'is_success': false,
        'message': e,
      };
    }
  }
}