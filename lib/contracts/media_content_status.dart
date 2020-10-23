import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocnera/contracts/media_content.dart';
import 'package:ocnera/pages/media_content/request_buttons.dart';
import 'package:ocnera/utils/unsupported_exception.dart';

enum MediaContentStatus {
  AVAILABLE,
  PARTLY_AVAILABLE,
  REQUESTED,
  MISSING,
  APPROVED,
  PROCESSING,
  REMOVED
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
        return "Request";
        break;

      case MediaContentStatus.PROCESSING:
      case MediaContentStatus.REQUESTED:
      case MediaContentStatus.APPROVED:
        return "Processing";
        break;
      case MediaContentStatus.REMOVED:
        return "Removed";
      default:
        throw UnsupportedException();
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
      case MediaContentStatus.REMOVED:
      case MediaContentStatus.MISSING:
        return RequestButton(
          text: _title(content.contentStatus),
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
