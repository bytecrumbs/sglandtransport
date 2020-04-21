import 'package:flutter_driver/flutter_driver.dart';

dynamic isRendered(SerializableFinder byValueKey, FlutterDriver driver,
    {Duration timeout = const Duration(seconds: 1)}) async {
  try {
    await driver.waitFor(byValueKey, timeout: timeout);
    return true;
  } catch (exception) {
    return false;
  }
}
