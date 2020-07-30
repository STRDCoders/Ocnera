import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/pages/media_content/request_buttons.dart';


enum MediaContentStatus { AVAILABLE, PARTLY_AVAILABLE, REQUESTED, MISSING }

extension ContentStatusExtention on MediaContentStatus {
  Widget _button(MediaContent content) {
    switch (content.contentStatus) {
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
        return RequestButton(content: content);
      default:
        return StatusButton(
          text: "UNKNOWN",
          color: Colors.black26,
        );
    }
  }

  Widget button(MediaContent content) => _button(content);
}
