import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// NOTE: This is overridden by ProviderScope() in the main.dart file
final localStorageServiceProvider =
    Provider<LocalStorageService>((ref) => throw UnimplementedError());

class LocalStorageService {
  LocalStorageService(this.sharedPreferences);

  // The Shared Preferences instance. It is passed in like this, so that we
  // don't have to asynchronously get the instances every time.
  final SharedPreferences sharedPreferences;

  List<String> getStringList(String key) {
    return sharedPreferences.getStringList(key) ?? <String>[];
  }

  Future<List<String>?> addStringToList(String key, String value) async {
    final stringList = sharedPreferences.getStringList(key) ?? <String>[]
      ..add(value);
    await sharedPreferences.setStringList(key, stringList);
    return sharedPreferences.getStringList(key);
  }

  Future<List<String>?> removeStringFromList(String key, String value) async {
    final stringList = sharedPreferences.getStringList(key) ?? <String>[]
      ..remove(value);
    await sharedPreferences.setStringList(key, stringList);
    return sharedPreferences.getStringList(key);
  }

  bool containsValueInList(String key, String value) {
    final stringList = sharedPreferences.getStringList(key) ?? <String>[];
    return stringList.contains(value);
  }

  Future<bool> setInt(String key, int value) async {
    return sharedPreferences.setInt(key, value);
  }

  int? getInt(String key) {
    return sharedPreferences.getInt(key);
  }
}
