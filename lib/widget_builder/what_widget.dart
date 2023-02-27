import 'package:flutter/material.dart';

class DetailHero extends StatelessWidget {
  final String thumbnail;
  const DetailHero({super.key, required this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(thumbnail), fit: BoxFit.cover),
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 0.8,
                blurRadius: 2,
                offset: Offset(0, 3))
          ]),
    );
  }
}
