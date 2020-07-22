//import 'package:flappy_search_bar/flappy_search_bar.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//class SearchField extends StatefulWidget {
//  @override
//  _SearchFieldState createState() => _SearchFieldState();
//}
//
//class _SearchFieldState extends State<SearchField> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: SafeArea(
//        child: SearchBar<Post>(
//          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
//          headerPadding: EdgeInsets.symmetric(horizontal: 10),
//          listPadding: EdgeInsets.symmetric(horizontal: 10),
//          onSearch: _getALlPosts,
//          placeHolder: Text("placeholder"),
//          cancellationWidget: Text("Cancel"),
//          emptyWidget: Text("empty"),
//          indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),
//          header: Row(
//            children: <Widget>[
//              RaisedButton(
//                child: Text("sort"),
//                onPressed: () {
//                  _searchBarController.sortList((Post a, Post b) {
//                    return a.body.compareTo(b.body);
//                  });
//                },
//              ),
//              RaisedButton(
//                child: Text("Desort"),
//                onPressed: () {
//                  _searchBarController.removeSort();
//                },
//              ),
//              RaisedButton(
//                child: Text("Replay"),
//                onPressed: () {
//                  isReplay = !isReplay;
//                  _searchBarController.replayLastSearch();
//                },
//              ),
//            ],
//          ),
//          onCancelled: () {
//            print("Cancelled triggered");
//          },
//          mainAxisSpacing: 10,
//          crossAxisSpacing: 10,
//          crossAxisCount: 2,
//          onItemFound: (Post post, int index) {
//            return Container(
//              color: Colors.lightBlue,
//              child: ListTile(
//                title: Text(post.title),
//                isThreeLine: true,
//                subtitle: Text(post.body),
//                onTap: () {
//                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail()));
//                },
//              ),
//            );
//          },
//        ),
//      ),
//    );
//  }
//
//}
