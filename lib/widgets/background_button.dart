import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/screens/discover_page/discover_page.dart';
import 'package:movie_app/screens/my_list_page/my_list_page.dart';

import '../constants.dart';

class DiscoverButton extends StatelessWidget {
  const DiscoverButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundButton(
      title: 'Discover',
      image: AssetImage('assets/images/background.png'),
      onPressed: (){
        Get.to(()=>DiscoverPage());
      },
    );
  }
}

class MyListButton extends StatelessWidget {
  const MyListButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundButton(
      title: 'My List',
      image: AssetImage('assets/images/background.jpg'),
      onPressed: (){
        Get.to(()=>MyListPage());
      },
    );
  }
}

class BackgroundButton extends StatelessWidget {
  BackgroundButton({
    Key? key,
    required this.image,
    this.onPressed,
    required this.title,
  }) : super(key: key);

  final AssetImage image;
  final Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: primaryColor,
          image: DecorationImage(
            fit: BoxFit.fill,
            opacity: 0.25,
            image: image,
          )),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double?>(20),
          shadowColor: MaterialStateProperty.all<Color>(primaryColor),
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
