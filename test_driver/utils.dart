import 'package:flutter_driver/flutter_driver.dart';

Future<FlutterDriver> setupAndGetDriver() async {
  final driver = await FlutterDriver.connect();
  var connected = false;
  while (!connected) {
    try {
      await driver.waitUntilFirstFrameRasterized();
      connected = true;
    } on Exception catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }
  return driver;
}
