import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ombiapp/pages/media_content/request_buttons.dart';

enum MediaContentStatus { AVAILABLE, PARTLY_AVAILABLE, REQUESTED, MISSING }

extension ContentStatusExtention on MediaContentStatus {
  static Widget _button(MediaContentStatus val) {
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
          color: Colors.orange,
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

  String get test => "hey";

  Widget get button => _button(this);
}
