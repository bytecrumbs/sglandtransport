import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides the LocalStorageService class
final localStorageServiceProvider = Provider((ref) => LocalStorageService());

/// The local storage class, which is based on Shared Preferences
class LocalStorageService {
  /// Get a list of strings based on a key. It will return an empty list
  /// if the key is not found.
  Future<List<String>> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? <String>[];
  }

  /// Adds a string to a list for a given key
  Future<List<String>> addStringToList(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(key) ?? <String>[];
    stringList.add(value);
    await prefs.setStringList(key, stringList);
    return await prefs.getStringList(key);
  }

  /// Removes a string from a list for a given key
  Future<List<String>> removeStringFromList(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(key) ?? <String>[];
    stringList.remove(value);
    await prefs.setStringList(key, stringList);
    return await prefs.getStringList(key);
  }

  /// checks if a certain value is already part of a list for a given
  /// key
  Future<bool> containsValueInList(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(key) ?? <String>[];
    return stringList.contains(value);
  }
}
