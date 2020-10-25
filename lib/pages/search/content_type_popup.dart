import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ocnera/contracts/media_content_type.dart';
import 'package:ocnera/widgets/popup_item.dart';

class ContentTypePopUp extends StatelessWidget {
  final Function onSelected;
  final MediaContentType defaultType;

  const ContentTypePopUp({Key key, this.onSelected, this.defaultType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MediaContentType>(
        icon: Icon(this.defaultType.icon),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<MediaContentType>>[
            PopupMenuItem<MediaContentType>(
              value: MediaContentType.MOVIE,
              child: PopupItem(
                  icon: Icon(
                    MediaContentType.MOVIE.icon,
                    color: Colors.white,
                  ),
                  text: 'MOVIES'.tr()),
            ),
            PopupMenuItem<MediaContentType>(
                value: MediaContentType.SERIES,
                child: PopupItem(
                    icon: Icon(
                        MediaContentType.SERIES.icon, color: Colors.white),
                    text: 'SERIES'.tr()))
          ];
        },
        onSelected: onSelected);
  }
}
