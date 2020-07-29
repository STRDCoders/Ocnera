import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/model/screen_arguments/MovieContentArguments.dart';
import 'package:ombiapp/services/router.dart';
import 'package:ombiapp/utils/logger.dart';
import 'package:ombiapp/utils/utilsImpl.dart';
import 'package:ombiapp/utils/grid.dart';

import 'package:ombiapp/widgets/card.dart';
import 'package:ombiapp/contracts/media_content_status.dart';

class ContentCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return CardTemplate(
      ratio: ratio,
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
                          tag: index,
                          child: (content.banner != null)
                              ? CachedNetworkImage(
                                  placeholder: (context, url) =>
                                      SpinKitFoldingCube(
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  imageUrl: content.banner,
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
                            content.contentStatus.button(content.contentType),
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
                              content.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style:
                                  TextStyle(fontSize: 24, color: Colors.orange),
                            )),
                            content.cardTopRight()
                          ],
                        ),
                        Divider(
                          height: 1,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 5,
                          child: Text(
                            content.overview,
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
                                      content.cardLeftBottom(),
                                      Text(
                                        content.releaseDate != null
                                            ? (content.releaseDate.year
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
            data: MovieContentArguments(index, content));
      },
    );
  }
}
