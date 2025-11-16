import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final loggerProvider = Provider<Logger>((ref) {
  return Logger(printer: PrettyPrinter(), level: Level.debug);
});
