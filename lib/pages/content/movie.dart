import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/model/screen_arguments/MovieContentArguments.dart';
import 'package:ombiapp/utils/theme.dart';
import 'package:ombiapp/utils/utilsImpl.dart';
import 'package:ombiapp/widgets/rating.dart';
import 'package:ombiapp/widgets/data_seperator.dart';

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
    //TODO - think about plex integration for openning the app.
    //TODO - Load extra info on a file to get plex URL
    // TODO - instead of having 2 copies of this widget(series+movies), make it more generic and get Row widgets as input for the different locations available(name items, buttons Row items, overview, etc)
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){Navigator.pop(context);},),
            backgroundColor: AppTheme.APP_BACKGROUND,
            pinned: true,
            floating: true,
            //This is required to keep minimum height on appbar upon scrolling
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(125.0),
              child: Text(''),
            ),
            expandedHeight: 250,
            flexibleSpace:
                Stack(alignment: Alignment.bottomRight, children: <Widget>[
              Container(
                width: UtilsImpl.getScreenWidth(context),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment(-.2, 0),
                      image: NetworkImage(
                          "https://image.tmdb.org/t/p/w300/nRXO2SnOA75OsWhNhXstHB8ZmI3.jpg"),
                      fit: BoxFit.cover),
                ),
                alignment: Alignment.bottomLeft,
              ),
              ClipRect(
                child: BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: new Container(
                    color: Colors.white.withOpacity(0.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Hero(
                          tag: widget.data.id,
                          child: CachedNetworkImage(
                            placeholder: (context, url) => SpinKitFoldingCube(
                              size: 15,
                              color: Colors.white,
                            ),
                            imageUrl:
                                "https://image.tmdb.org/t/p/w300//dzBtMocZuJbjLOXvrl4zGYigDzh.jpg",
                          ),
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                  child: Text("The Lion king 2",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 24,
                                      )),
                                ),
                                Flexible(
                                    child: Row(
                                  children: <Widget>[
                                    Text("2020"),
                                    DataSeparator(),
                                    ContentRating(rating: "7.5"),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.APP_BACKGROUND.withOpacity(0.4),
                        spreadRadius: 55,
                        blurRadius: 55,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text("")),
            ])),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[RaisedButton(child: Text("Test",))],),
                  Text(
                    "Simba idolizes his father, King Mufasa, and takes to heart his own royal destiny. But not everyone in the kingdom celebrates the new cub's arrival. Scar, Mufasa's brother—and former heir to the throne—has plans of his own. The battle for Pride Rock is ravaged with betrayal, tragedy and drama, ultimately resulting in Simba's exile. With help from a curious pair of newfound friends, Simba will have to figure out how to grow up and take back what is rightfully his.",
                  ),
                ],
              ))
        ]))
      ],
    );
  }
}
