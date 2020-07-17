import 'package:flutter_driver/flutter_driver.dart';

Future<FlutterDriver> setupAndGetDriver() async {
  var driver = await FlutterDriver.connect();
  var connected = false;
  while (!connected) {
    try {
      await driver.waitUntilFirstFrameRasterized();
      connected = true;
    } catch (error) {
      print(error);
    }
  }
  return driver;
}
