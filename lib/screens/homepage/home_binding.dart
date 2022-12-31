import 'package:get/get.dart';
import 'package:movie_app/screens/homepage/home_controller.dart';

class HomeBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}