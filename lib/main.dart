import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/discover_page/discover_binding.dart';
import 'package:movie_app/screens/discover_page/discover_page.dart';
import 'package:movie_app/screens/homepage/home_binding.dart';
import 'package:movie_app/screens/homepage/home_page.dart';
import 'package:movie_app/screens/movie_page/movie_binding.dart';
import 'package:movie_app/screens/my_list_page/my_list_page.dart';

import 'screens/movie_page/movie_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('My_List');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      /*scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
      }),*/
      theme: ThemeData(
        textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            bodyMedium: TextStyle(
              color: textColor,
            ),
            bodyLarge: TextStyle(fontWeight: FontWeight.bold)),
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: primaryColor,
          ),
          titleTextStyle: TextStyle(
              color: primaryColor,fontFamily: 'Bebas',
            fontWeight: FontWeight.w900,
            fontSize: 24,
            letterSpacing: 1
          ),
          backgroundColor: Colors.transparent,
          systemOverlayStyle: kSystemUiStyle,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      getPages: [
        GetPage(
          name: '/home',
          page: () => const HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/movie',
          page: () => const MoviePage(),
          binding: MovieBinding(),
        ),
        GetPage(
          name: '/my_list',
          page: () => const MyListPage(),
        ),
        GetPage(
          name: '/discover',
          page: () => DiscoverPage(),
          binding: DiscoverBinding(),
        ),
      ],
      initialRoute: '/home',
    );
  }
}