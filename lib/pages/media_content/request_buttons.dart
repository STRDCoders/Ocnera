import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ocnera/contracts/media_content.dart';
import 'package:ocnera/contracts/media_content_type.dart';
import 'package:ocnera/model/request/content/requests/movie_request.dart';
import 'package:ocnera/model/response/media_content/requests/media_content_request_response.dart';
import 'package:ocnera/model/response/media_content/series/series.dart';
import 'package:ocnera/services/request_service.dart';
import 'package:ocnera/services/router.dart';

class StatusButton extends StatelessWidget {
  final String text;
  final Color color;

  const StatusButton({Key key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 15,
      disabledColor: color,
      onPressed: null,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

class RequestButton extends StatefulWidget {
  final MediaContent content;
  final String text;
  final Color color;

  const RequestButton(
      {Key key,
      @required this.content,
      this.text = 'Request',
      this.color = Colors.orange})
      : super(key: key);

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
                      ? 'UNEXPECTED_ERROR'.tr()
                      : res.errorMessage))));
          _searching = false;
        }
        return (!_searching)
            ? RaisedButton(
                elevation: 15,
                color: widget.color,
                child: Text(
                  widget.text,
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: handleRequest,
              )
            : SpinKitCircle(
                size: 20,
                color: Colors.white,
              );
      },
    );
  }

  void handleRequest() {
    switch (widget.content.contentType) {
      case MediaContentType.MOVIE:
        setState(() {
          _searching = true;
        });
        requestManager.requestContent(
            widget.content, MovieRequest(widget.content.id));
        break;
      case MediaContentType.SERIES:
        RouterService.navigate(context, Routes.SERIES_REQUEST,
            data: (widget.content as SeriesContent));
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
//                    ? "An unexpected error has occurred!"
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
