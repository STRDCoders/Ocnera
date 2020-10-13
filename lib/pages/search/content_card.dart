import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/contracts/media_content_status.dart';
import 'package:ombiapp/model/screen_arguments/content_page_args.dart';
import 'package:ombiapp/services/router.dart';
import 'package:ombiapp/widgets/card.dart';

class ContentCard extends StatefulWidget {
  final num index;
  final MediaContent content;
  final double ratio;

  const ContentCard(
      {Key key,
      @required this.index,
      @required this.content,
      @required this.ratio})
      : super(key: key);

  @override
  _ContentCardState createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  @override
  Widget build(BuildContext context) {
    return CardTemplate(
      ratio: widget.ratio,
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            //Beginning height of text in card
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Hero(
                          tag: widget.index,
                          child: (widget.content.banner != null)
                              ? CachedNetworkImage(
                                  placeholder: (context, url) =>
                                      SpinKitFoldingCube(
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  imageUrl: widget.content.banner,
                                  fit: BoxFit.fitWidth,
                                )
                              : Container(child: Text("No image")),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Flexible(
                        flex: 1,
                        child:
                            widget.content.contentStatus.button(widget.content),
                      ),
                    ],
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 5,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                                child: Text(
                              widget.content.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style:
                                  TextStyle(fontSize: 24, color: Colors.orange),
                            )),
                            widget.content.cardTopRight()
                          ],
                        ),
                        Divider(
                          height: 1,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 5,
                          child: Text(
                            widget.content.overview,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 8,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      widget.content.cardLeftBottom(),
                                      Text(
                                        widget.content.releaseDate != null
                                            ? (widget.content.releaseDate.year
                                                .toString())
                                            : "---",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]))
            ],
          )),
      onTap: () {
        RouterService.navigate(context, Routes.MEDIA_CONTENT,
            data: MovieContentArguments(widget.index, widget.content));
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
