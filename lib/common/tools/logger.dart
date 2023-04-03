import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// todo manage providers folder location more wisely
// todo it's too easy to lost track of where's what
final loggerProvider = Provider<Logger>(
  (ref) => Logger(
    printer: PrettyPrinter(),
  ),
);
