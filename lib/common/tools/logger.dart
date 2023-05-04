import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logger.g.dart';

@riverpod
Logger logger(LoggerRef ref) => Logger(
      printer: PrettyPrinter(),
    );
