import 'dart:io';

import 'package:fimber_io/fimber_io.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:path_provider/path_provider.dart';

final logger = FimberLog('App_Logger');

Future<void> configureLogger() async {
  Fimber.plantTree(DebugTree());
  Directory extDir = await getApplicationDocumentsDirectory();
  String path = '${extDir.path}/${GlobalConfiguration().getValue('LOG_DIR')}';
  logger.i('Generating folder for local images $path');
  await Directory(path).create(recursive: true);
  deletePreviousFiles(path,
      fileCount: GlobalConfiguration().getValue('LOG_HISTORY_FILES'));

  Fimber.plantTree(TimedRollingFileTree(
      timeSpan: TimedRollingFileTree.dailyTime,
      filenamePrefix: '$path/appLog_',
      filenamePostfix: '.log',
      logLevels: ['I', 'W', 'E']));
}

void deletePreviousFiles(String path, {int fileCount = 3}) {
  var logDir = Directory(path);
  var files = logDir.listSync();
  files.forEach((element) {
    if (_shouldFileBeDeleted(element, fileCount)) {
      element.deleteSync();
    }
  });
}

bool _shouldFileBeDeleted(FileSystemEntity file, int fileCount) {
  var fileStats = file.statSync();
  final now = DateTime.now();
  var date = fileStats.modified;
  if (now.difference(date).inHours >= fileCount) {
    return true;
  }
  return false;
}
