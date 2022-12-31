import 'package:flutter/material.dart';

import '../constants.dart';

class PagesListView extends StatelessWidget {
  const PagesListView({
    super.key,
    this.onTap,
    required this.selectedPage,
  });

  final int selectedPage;
  final Function(int page)? onTap;

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
        itemCount: pages.length,
        itemBuilder: (context, index) => PageCard(
          index: index,
          onTap: onTap,
          selectedPage: selectedPage,
        ),
      ),
    );
  }
}

class PageCard extends StatelessWidget {
  PageCard(
      {Key? key, required this.index, this.onTap, required this.selectedPage})
      : super(key: key);

  final int index;
  final Function(int page)? onTap;
  final int selectedPage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final page = pages[index];
    bool isSelected = page == selectedPage;
    return GestureDetector(
      onTap: () {
        onTap!(page);
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
          child: Text(page.toString(),
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }
}