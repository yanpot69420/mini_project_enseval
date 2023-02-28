import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListImageH extends StatelessWidget {
  final List<String> list;
  const ListImageH({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Container(
          width: 100,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: NetworkImage(list[index])),
          ),
        );
      },
    );
  }
}

class DetailRating extends StatelessWidget {
  final double rate;
  const DetailRating({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      // initialRating: rate,
      // minRating: 1,
      rating: rate,
      itemCount: 5,
      direction: Axis.horizontal,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: ((context, index) => Icon(Icons.star, color: Colors.amber)),
      // onRatingUpdate: (rating) {
      //   // do nothing
      // },
      // ignoreGestures: true,
      // allowHalfRating: true,

      itemSize: 35.0,
    );
  }
}
