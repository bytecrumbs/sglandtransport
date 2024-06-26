import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_storage_service.g.dart';

@Riverpod(keepAlive: true)
LocalStorageService localStorageService(LocalStorageServiceRef ref) =>
    LocalStorageService(ref);

class LocalStorageService {
  LocalStorageService(this.ref);

  final Ref ref;

  Future<SharedPreferences> spInstance() => SharedPreferences.getInstance();

  Future<List<String>> getStringList(String key) async {
    final sp = await spInstance();
    return sp.getStringList(key) ?? <String>[];
  }

  Future<List<String>?> addStringToList(String key, String value) async {
    final sp = await spInstance();

    final stringList = await getStringList(key);
    stringList.add(value);

    await sp.setStringList(key, stringList);
    return sp.getStringList(key);
  }

  Future<List<String>?> removeStringFromList(String key, String value) async {
    final sp = await spInstance();

    final stringList = await getStringList(key);
    stringList.remove(value);

    await sp.setStringList(key, stringList);
    return sp.getStringList(key);
  }

  Future<bool> remove(String key) async {
    final sp = await spInstance();
    return sp.remove(key);
  }

  Future<bool> setInt(String key, int value) async {
    final sp = await spInstance();
    return sp.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final sp = await spInstance();
    return sp.getInt(key);
  }

  Future<bool> setString(String key, String value) async {
    final sp = await spInstance();
    return sp.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final sp = await spInstance();
    return sp.getString(key);
  }

  Future<bool> setBool({
    required String key,
    required bool value,
  }) async {
    final sp = await spInstance();
    return sp.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final sp = await spInstance();
    return sp.getBool(key);
  }
}
