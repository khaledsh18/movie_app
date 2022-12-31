import 'package:flutter/material.dart';

class TitleLabel extends StatelessWidget {
  const TitleLabel({Key? key, required this.title, this.onPressed})
      : super(key: key);
  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: Theme.of(context).textTheme.bodyLarge,),
          IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.arrow_forward_rounded))
        ],
      ),
    );
  }
}