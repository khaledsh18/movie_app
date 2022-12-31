import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/entities/cast.dart';
import 'package:movie_app/entities/movie.dart';
import 'package:movie_app/entities/movie_details.dart';
import '../../entities/movie_modal.dart';
import '../../network_utils/network_utils.dart';

class MovieController extends GetxController{
  late MovieModal movieModal;
  var isLoading = true.obs;
  var isFav = false.obs;
  List<Cast> casts = [];

  setMovie(Movie movie) async{
    var castResponse = await NetworkUtils().getCast(movie.id);
    if(castResponse['is_success']){
      casts = castResponse['casts'];
    }else{
      showSnackBar(movie);
      return;
    }
    var detailsResponse = await NetworkUtils().getDetails(movie.id);
    late MovieDetails details;
    if(detailsResponse['is_success']){
      details = detailsResponse['details'];
    }else{
      showSnackBar(movie);
      return;
    }
    movieModal = MovieModal(movie: movie,details: details);
    setIsFav(movieModal);
    isLoading.value = false;
  }

  Future<void> addToList(MovieModal movieModal) async{
    var box = Hive.box('My_List');
    if(isFav.isTrue){
      await box.delete(movieModal.movie.id.toString());
      setIsFav(movieModal);
    }else{
      Map<String,Object?> map = MovieModal.toMap(movieModal);
      await box.put(movieModal.movie.id.toString(),map);
      setIsFav(movieModal);
    }
  }

  setIsFav(MovieModal movieModal)async{
    var box = Hive.box('My_List');
    final modal = await box.get(movieModal.movie.id.toString());
    if(modal == null){
      isFav.value = false;
    }else{
      isFav.value = true;
    }
  }
  void showSnackBar(Movie movie) {
    Get.showSnackbar(
      GetSnackBar(
        title: 'Check Your Internet Connection',
        message: 'Your Internet Connection has been lost',
        mainButton: IconButton(
          onPressed: () {
            Get.closeCurrentSnackbar();
            setMovie(movie);
          },
          icon: Icon(Icons.refresh_rounded),color: Colors.white,),
      ),
    );
  }
}