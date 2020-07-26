import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/model/screen_arguments/MovieContentArguments.dart';
import 'package:ombiapp/services/router.dart';
import 'package:ombiapp/utils/theme.dart';
import 'package:ombiapp/utils/utilsImpl.dart';
import 'package:ombiapp/widgets/rating.dart';
import 'package:ombiapp/contracts/media_content_status.dart';

class ContentCard extends StatelessWidget {

  final num index;
  final MediaContent content;

  const ContentCard({
    Key key,
    @required this.index,
    @required this.content,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return
      Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Container(
              height:
              UtilsImpl.getScreenHeight(context, true) * 0.32,
              child: InkWell(
                  onTap: () {
                    RouterService.navigate(
                        context, Routes.MOVIE_CONTENT,
                        data: MovieContentArguments(index, content));
                    print("test");
                  },
                  child:

      Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
        color: AppTheme.DATA_BACKGROUND,
        child: ClipRect(
            child: BackdropFilter(
                filter: new ImageFilter.blur(
                    sigmaX: 5.0, sigmaY: 5.0),
                child: new Container(
                    color: AppTheme.APP_BACKGROUND
                        .withOpacity(0.5),
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          //Beginning height of text in card
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Hero(
                                      tag: index,
                                      child: (content.banner != null) ?
                                      CachedNetworkImage(
                                        placeholder: (context,
                                            url) =>
                                            SpinKitFoldingCube(
                                              size: 20,
                                              color:
                                              Colors.white,
                                            ),
                                        imageUrl:
                                        content.banner,
                                      ): Container(child:Text("No image")),
                                    ),
                                    Divider(
                                      height: 5,
                                    ),
                                    Flexible(
                                      child: content.contentStatus.button,
                                    ),
                                  ],
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 5,
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                              child: Text(
                                                content.title ,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize:
                                                    24,
                                                    color: Colors
                                                        .orange),
                                              )),
                                          (content.voteRating == 0 ) ? Container() :
                                          ContentRating(
                                              rating: Text(content.voteRating.toStringAsFixed(1)))
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
                                          overflow:
                                          TextOverflow
                                              .ellipsis,
                                          maxLines: 8,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors
                                                  .white),
                                        ),
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .stretch,
                                          children: <
                                              Widget>[
                                            Expanded(
                                              child:
                                              Container(),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <
                                                  Widget>[
                                                Text(
                                                  "EN",
                                                  textAlign:
                                                  TextAlign
                                                      .left,
                                                  style: TextStyle(
                                                      fontSize:
                                                      12),
                                                ),

                                                Text(
                                                  content.releaseDate != null ? (content.releaseDate.year.toString()) : "---",
                                                  textAlign:
                                                  TextAlign
                                                      .right,
                                                  style: TextStyle(
                                                      fontSize:
                                                      12),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]))
                          ],
                        )))))))));
  }
}
