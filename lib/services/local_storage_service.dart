import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides the LocalStorageService class.
/// NOTE: This is overridden by ProviderScope() in the main.dart file
final localStorageServiceProvider =
    Provider<LocalStorageService>((ref) => throw UnimplementedError());

/// The local storage class, which is based on Shared Preferences
class LocalStorageService {
  /// The Shared Preferences instance. It is passed in like this, so that we
  /// don't have to asynchronously get the instances every time.
  final SharedPreferences sharedPreferences;

  /// Default class constructor
  LocalStorageService(this.sharedPreferences);

  /// Get a list of strings based on a key. It will return an empty list
  /// if the key is not found.
  List<String> getStringList(String key) {
    return sharedPreferences.getStringList(key) ?? <String>[];
  }

  /// Adds a string to a list for a given key
  Future<List<String>> addStringToList(String key, String value) async {
    final stringList = sharedPreferences.getStringList(key) ?? <String>[];
    stringList.add(value);
    await sharedPreferences.setStringList(key, stringList);
    return sharedPreferences.getStringList(key);
  }

  /// Removes a string from a list for a given key
  Future<List<String>> removeStringFromList(String key, String value) async {
    final stringList = sharedPreferences.getStringList(key) ?? <String>[];
    stringList.remove(value);
    await sharedPreferences.setStringList(key, stringList);
    return sharedPreferences.getStringList(key);
  }

  /// checks if a certain value is already part of a list for a given
  /// key
  bool containsValueInList(String key, String value) {
    final stringList = sharedPreferences.getStringList(key) ?? <String>[];
    return stringList.contains(value);
  }

  /// sets an integer value in the local storage of the device
  Future<bool> setInt(String key, int value) async {
    return await sharedPreferences.setInt(key, value);
  }

  /// gets an integer value based on a key from the local storage of the device
  int getInt(String key) {
    return sharedPreferences.getInt(key);
  }
}
