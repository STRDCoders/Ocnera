import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/pages/media_content/request_buttons.dart';

import 'media_content_type.dart';

enum MediaContentStatus {
  AVAILABLE,
  PARTLY_AVAILABLE,
  REQUESTED,
  MISSING,
  APPROVED,
  PROCESSING
}

extension ContentStatusExtention on MediaContentStatus {
  String _title(MediaContentStatus status) {
    switch (status) {
      case MediaContentStatus.AVAILABLE:
        return "Available";
        break;
      case MediaContentStatus.PARTLY_AVAILABLE:
        return "Partly Available";
        break;
      case MediaContentStatus.MISSING:
        return "Missing";
        break;

      case MediaContentStatus.PROCESSING:
      case MediaContentStatus.REQUESTED:
      case MediaContentStatus.APPROVED:
        return "Proccessing";
        break;
    }
  }

  Widget _button(MediaContent content) {
    switch (content.contentStatus) {
      case MediaContentStatus.AVAILABLE:
        return StatusButton(
          text: _title(content.contentStatus),
          color: Colors.green,
        );
        break;
      case MediaContentStatus.PARTLY_AVAILABLE:
        if (content.contentType == MediaContentType.SERIES)
          return RequestButton(
            content: content,
            text: _title(content.contentStatus),
            color: Colors.cyan,
          );

        break;

      case MediaContentStatus.PROCESSING:
      case MediaContentStatus.APPROVED:
      case MediaContentStatus.REQUESTED:
        return StatusButton(
          text: _title(content.contentStatus),
          color: Colors.cyan,
        );
        break;
      case MediaContentStatus.MISSING:
        return RequestButton(
          content: content,
        );
      default:
        return StatusButton(
          text: "UNKNOWN",
          color: Colors.black26,
        );
    }
  }

  String get title => _title(this);
  Widget button(MediaContent content) => _button(content);
}
