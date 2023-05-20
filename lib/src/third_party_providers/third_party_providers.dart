import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'third_party_providers.g.dart';

@riverpod
Dio dio(DioRef ref) => Dio();

@Riverpod(keepAlive: true)
Logger logger(LoggerRef ref) => Logger(
      printer: PrettyPrinter(),
      level: Level.debug,
    );
