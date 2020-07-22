import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/model/screen_arguments/MovieContentArguments.dart';

class MovieContentPage extends StatefulWidget {

  final MovieContentArguments data;

  const MovieContentPage({
    Key key,
    @required this.data,
  }) : super(key: key);



  @override
  _MovieContentPageState createState() => _MovieContentPageState();
}

class _MovieContentPageState extends State<MovieContentPage> {

  @override
  Widget build(BuildContext context) {
    return Container(child:Hero(
      tag: widget.data.id,
      child:  CachedNetworkImage(
        placeholder: (context, url) =>
            SpinKitFoldingCube(
              size: 15,
              color: Colors.white,
            ),
        imageUrl:
        "https://image.tmdb.org/t/p/w300//dzBtMocZuJbjLOXvrl4zGYigDzh.jpg",
      ),
    ));
  }
}
