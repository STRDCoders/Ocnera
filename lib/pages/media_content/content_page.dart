import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/model/screen_arguments/content_page_args.dart';
import 'package:ombiapp/services/animation/particle_painter.dart';
import 'package:ombiapp/services/request_service.dart';
import 'package:ombiapp/utils/theme.dart';
import 'package:ombiapp/utils/utilsImpl.dart';
import 'package:ombiapp/widgets/data_seperator.dart';
import 'package:ombiapp/contracts/media_content_status.dart';

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
  StreamSubscription _requestStreamSubscription;

  @override
  Widget build(BuildContext context) {
    //TODO - think about "Plex" integration for opening the app.
    //TODO - Load extra info on a file to get "Plex"" URL
    // TODO - instead of having 2 copies of this widget(series+movies), make it more generic and get Row widgets as input for the different locations available(name items, buttons Row items, overview, etc)
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                      //TODO - implement the onError method.
                      onError: (context, trace) =>
                          Text("THIS IS HALLOWIERJKSJRKSJDFKJ"),
                      image: CachedNetworkImageProvider(
                          "${widget.data.content.background}"),
                      fit: BoxFit.cover),
                ),
                alignment: Alignment.center,
              ),
              ClipRect(
                child: BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: new Container(
                    color: Colors.white.withOpacity(0.0),
                  ),
                ),
              ),
              Container(
                  width: UtilsImpl.getScreenWidth(context),
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.APP_BACKGROUND.withOpacity(0.4),
                        spreadRadius: 15,
                        blurRadius: 15,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text("")),
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
                            imageUrl: "${widget.data.content.banner}",
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
                                  flex: 3,
                                  child: Text(widget.data.content.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 24,
                                      )),
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Row(
                                      children: <Widget>[
                                        Text(widget
                                            .data.content.releaseDate.year
                                            .toString()),
                                        DataSeparator(widget.data.content
                                            .contentPageTitle())
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
            ])),
        SliverList(
            delegate: SliverChildListDelegate([
          AnimatedBackground(),
          Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: widget.data.content.contentStatus
                            .button(widget.data.content),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${widget.data.content.overview}",
                  ),
                ],
              ))
        ]))
      ],
    );
  }

  @override
  void dispose() {
    _requestStreamSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _requestStreamSubscription = requestManager.requestStream.listen((data) {
      setState(() {
      });
    });
    super.initState();
  }
}
