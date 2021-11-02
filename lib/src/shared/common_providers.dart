import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final analyticsProvider = Provider((_) => FirebaseAnalytics());

final dioProvider = Provider<Dio>((ref) => Dio());

final loggerProvider = Provider(
  (ref) => Logger(
    printer: PrettyPrinter(),
    level: Level.debug,
  ),
);
