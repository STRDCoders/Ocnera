import 'dart:io';

import 'package:fimber_io/fimber_io.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ocnera/utils/unsupported_exception.dart';
import 'package:path_provider/path_provider.dart';

enum LoggerTypes { DEBUG, INFO, WARNING, ERROR, VERBOSE }

extension LoggerTypeFunctionExtension on LoggerTypes {
  Function _loggerFunction(LoggerTypes loggerType, FimberLog fimLogger) {
    switch (loggerType) {
      case LoggerTypes.DEBUG:
        return fimLogger.d;
        break;
      case LoggerTypes.INFO:
        return fimLogger.i;
        break;
      case LoggerTypes.WARNING:
        return fimLogger.w;
        break;
      case LoggerTypes.ERROR:
        return fimLogger.e;
        break;
      case LoggerTypes.VERBOSE:
        return fimLogger.v;
        break;
      default:
        throw UnsupportedException('Other logger type is not supported');
    }
  }

  Function getLoggerFunction(FimberLog fimLogger) =>
      _loggerFunction(this, fimLogger);
}

class OcneraLogger {
  final _fimLogger = FimberLog('App_Logger');

  Future<void> configureLogger() async {
    Fimber.plantTree(DebugTree());
    Directory extDir = await getApplicationDocumentsDirectory();
    String path = '${extDir.path}/${GlobalConfiguration().getValue('LOG_DIR')}';
    _fimLogger.i('Generating folder for local images $path');
    await Directory(path).create(recursive: true);
    _deletePreviousFiles(path,
        fileCount: GlobalConfiguration().getValue('LOG_HISTORY_FILES'));

    Fimber.plantTree(TimedRollingFileTree(
        timeSpan: TimedRollingFileTree.dailyTime,
        filenamePrefix: '$path/appLog_',
        filenamePostfix: '.log',
        logLevels: ['I', 'W', 'E']));
  }

  void _deletePreviousFiles(String path, {int fileCount = 3}) {
    var logDir = Directory(path);
    var files = logDir.listSync();
    files.forEach((element) {
      if (_shouldFileBeDeleted(element, fileCount)) {
        element.deleteSync();
      }
    });
  }

  /// logs a message
  ///
  /// Log the [msg] using the logger by the given [loggerType]
  /// Optional: giving the [stacktrace] and the [exception] for logging to
  /// and [lineCount] for logging more then 10 lines of the stacktrace
  void log(LoggerTypes loggerType, String msg,
      {dynamic stacktrace, dynamic exception, int lineCount = 10}) {
    Iterable<String> lines;
    StringBuffer logMsg = StringBuffer(msg);
    if (exception != null) {
      logMsg.writeln(exception.message);
    }
    if (stacktrace != null && lineCount > 0) {
      lines = stacktrace.toString().split('\n').take(lineCount);
      logMsg.writeAll(lines, '\n');
    }
    loggerType.getLoggerFunction(_fimLogger)(logMsg.toString());
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
}

final appLogger = new OcneraLogger();
