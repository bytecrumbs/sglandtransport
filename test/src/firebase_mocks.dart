import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  // setupFirebaseCoreMocks();
}

Future<T> neverEndingFuture<T>() async {
  while (true) {
    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(minutes: 5));
  }
}
