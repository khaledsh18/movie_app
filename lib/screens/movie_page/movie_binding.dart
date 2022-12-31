import 'package:get/get.dart';
import 'package:movie_app/screens/movie_page/movie_controller.dart';

class MovieBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<MovieController>(() => MovieController());
  }
}