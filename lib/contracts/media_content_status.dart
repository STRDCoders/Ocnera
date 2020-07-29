import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ombiapp/pages/media_content/request_buttons.dart';

import 'media_content_type.dart';

enum MediaContentStatus { AVAILABLE, PARTLY_AVAILABLE, REQUESTED, MISSING }

extension ContentStatusExtention on MediaContentStatus {
  static Widget _button(MediaContentStatus val, MediaContentType type) {
    switch (val) {
      case MediaContentStatus.AVAILABLE:
        return StatusButton(
          text: "Available",
          color: Colors.green,
        );
        break;
      case MediaContentStatus.PARTLY_AVAILABLE:
        return StatusButton(
          text: "Requested",
          color: Colors.cyan,
        );
        break;
      case MediaContentStatus.REQUESTED:
        return StatusButton(
          text: "Requested",
          color: Colors.cyan,
        );
        break;
      case MediaContentStatus.MISSING:
        return RequestButton();
      default:
        return StatusButton(
          text: "UNKNOWN",
          color: Colors.black26,
        );
    }
  }

  Widget button(MediaContentType type) => _button(this, type);
}
