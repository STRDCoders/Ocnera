import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/contracts/media_content_status.dart';
import 'package:ombiapp/contracts/media_content_type.dart';
import 'package:ombiapp/model/request/content/requests/movie.dart';
import 'package:ombiapp/model/response/media_content/requests/media_content_request.dart';

import 'package:ombiapp/services/request_service.dart';

class StatusButton extends StatelessWidget {
  final String text;
  final Color color;

  const StatusButton({Key key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 15,
      disabledColor: color,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

class RequestButton extends StatefulWidget {
  final MediaContent content;

  const RequestButton({Key key, this.content}) : super(key: key);

  @override
  _RequestButtonState createState() => _RequestButtonState();
}

class _RequestButtonState extends State<RequestButton> {
  bool _searching = false;
  StreamSubscription _subscription;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaContentRequestResponse>(
      stream: requestManager.requestStream,
      builder: (BuildContext context,
          AsyncSnapshot<MediaContentRequestResponse> snapshot) {
        if (snapshot.hasData) {

        } else if (snapshot.hasError) {
          MediaContentRequestResponse res = snapshot.error;
          WidgetsBinding.instance.addPostFrameCallback((_) =>
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text((res.statusCode != 200)
                      ? "An unexpected error has occured!"
                      : res.errorMessage))));
          _searching = false;
        }
        return (!_searching)
            ? RaisedButton(
                elevation: 15,
                color: Colors.orange,
                child: Text(
                  "Request",
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () => handleRequest(context),
              )
            : SpinKitCircle(
                size: 20,
                color: Colors.white,
              );
      },
    );
  }

  void handleRequest(BuildContext context) {
    print("Working on: ${widget.content.id}");
    setState(() {
      _searching = true;
    });
    switch (widget.content.contentType) {
      case MediaContentType.MOVIE:
        requestManager.requestContent(
            widget.content, MovieRequestPodo(widget.content.id));
        break;
      case MediaContentType.SERIES:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _subscription = requestManager.requestStream.listen((data) {
      setState(() {
        _searching = false;
      });

//      else if (snapshot.hasError) {
//        MediaContentRequestResponse res = snapshot.error;
//        WidgetsBinding.instance.addPostFrameCallback((_) =>
//            Scaffold.of(context).showSnackBar(SnackBar(
//                content: Text((res.statusCode != 200)
//                    ? "An unexpected error has occured!"
//                    : res.errorMessage))));
//        _searching = false;
//      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
