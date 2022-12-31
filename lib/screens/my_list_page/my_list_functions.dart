import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../entities/movie.dart';
import '../../entities/movie_details.dart';
import '../../entities/movie_modal.dart';
import '../../network_utils/network_utils.dart';

class MyListFunctions{

  Future<void> deleteMovie(MovieModal movieModal) async{
    var box = Hive.box('My_List');

      await box.delete(movieModal.movie.id.toString());
  }

  Future<void> addDeleteMovie({required Movie movie, required bool isBookmarked}) async{
    var box = Hive.box('My_List');
    if(isBookmarked){
      await box.delete(movie.id.toString());
    }else{
      var detailsResponse = await NetworkUtils().getDetails(movie.id);
      late MovieDetails details;
      if(detailsResponse['is_success']){
        details = detailsResponse['details'];
      }else{
        return;
      }
      MovieModal movieModal = MovieModal(movie: movie,details: details);
      Map<String,Object?> map = MovieModal.toMap(movieModal);
      await box.put(movieModal.movie.id.toString(),map);
    }
  }

}