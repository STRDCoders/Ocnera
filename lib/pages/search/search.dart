import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/model/screen_arguments/MovieContentArguments.dart';
import 'package:ombiapp/services/login_service.dart';
import 'package:ombiapp/services/router.dart';
import 'package:ombiapp/services/secure_storage_service.dart';
import 'package:ombiapp/utils/utilsImpl.dart';

import 'top_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        TopBar(),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((content, index) {
            return Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Container(
                  height: UtilsImpl.getScreenHeight(context, true) * 0.32,
                  child: InkWell(
                    onTap: () {
                      RouterService.navigate(context, Routes.MOVIE_CONTENT,
                          data: MovieContentArguments(index));
                      print("test");
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Colors.white12,
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child:
                                Row(
                              //Beginning height of text in card
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                    flex: 2,
                                    child: Column(
                                      children: <Widget>[
                                        Hero(
                                          tag: index,
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                SpinKitFoldingCube(
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            imageUrl:
                                                "https://image.tmdb.org/t/p/w300//dzBtMocZuJbjLOXvrl4zGYigDzh.jpg",
                                          ),
                                        ),
                                        Divider(
                                          height: 5,
                                        ),
                                        Flexible(
                                          child: RaisedButton(
                                            elevation: 15,
                                            color: Colors.green,
                                            child: Text(
                                              "Available",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            onPressed: () {},
                                          ),
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
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                  child: Text(
                                                "The Lion King II",
                                                style: TextStyle(
                                                    color: Colors.orange),
                                              )),
                                              Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.star,
                                                    size: 15,
//                                                  color: Colors.orange,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text("7.5")
                                                ],
                                              )
                                            ],
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            flex: 5,
                                            child: Text(
                                              "Simba idolizes his father, King Mufasa, and takes to heart his own royal destiny. But not everyone in the kingdom celebrates the new cub's arrival. Scar, Mufasa's brother—and former heir to the throne—has plans of his own. The battle for Pride Rock is ravaged with betrayal, tragedy and drama, ultimately resulting in Simba's exile. With help from a curious pair of newfound friends, Simba will have to figure out how to grow up and take back what is rightfully his.",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 7,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      "EN",
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    Text(
                                                      "12/05/2020",
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]))
                              ],
                            ))),
                  ),
                ));
          }, childCount: 15),
        )
      ],
    ); //    return Column(
  }
}
