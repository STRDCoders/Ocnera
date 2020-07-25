import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentRating extends StatelessWidget {

  final Text rating;
  const ContentRating({
    Key key,
    @required this.rating,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.star,
          size: 15,
        ),
        SizedBox(
          width: 3,
        ),
        rating
      ],
    );
  }
}
