import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/src/local_storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('LocalStorageService should', () {
    LocalStorageService _setup({
      String? key,
      Object? keyValues,
    }) {
      final values =
          key != null ? <String, Object>{key: keyValues!} : <String, Object>{};
      SharedPreferences.setMockInitialValues(values);
      final container = ProviderContainer();
      return container.read(localStorageServiceProvider);
    }

    test('return a list of strings is the given key exists', () async {
      const key = 'myKey';
      final keyValues = ['String1', 'String2'];

      final lss = _setup(key: key, keyValues: keyValues);
      expect(await lss.getStringList(key), keyValues);
    });
    test('return an empty list of strings is the given key does not exists',
        () async {
      const key = 'myKey';
      final keyValues = ['String1', 'String2'];

      final lss = _setup(key: key, keyValues: keyValues);
      expect(await lss.getStringList('non-existent-key'), <String>[]);
    });
    test('add a String to a list that already exists', () async {
      const key = 'myKey';
      final keyValues = ['String1', 'String2'];
      final lss = _setup(key: key, keyValues: keyValues);

      const additionalValue = 'String3';

      final result = await lss.addStringToList(key, additionalValue);

      expect(result?.length, 3);
      expect(result?[2], additionalValue);

      final listFromStorage = await lss.getStringList(key);
      expect(listFromStorage.length, 3);
      expect(listFromStorage[2], additionalValue);
    });
    test('add a String to a list that does not yet exists', () async {
      const key = 'myKey';
      final keyValues = ['String1', 'String2'];
      final lss = _setup(key: key, keyValues: keyValues);

      const additionalValue = 'String3';

      final result =
          await lss.addStringToList('non-existent-key', additionalValue);

      expect(result?.length, 1);
      expect(result?[0], additionalValue);

      final listFromStorage = await lss.getStringList('non-existent-key');
      expect(listFromStorage.length, 1);
      expect(listFromStorage[0], additionalValue);
    });
    test('remove existing String from an existing list', () async {
      const key = 'myKey';
      const keyValue1 = 'String2';
      const keyValue2 = 'String3';
      final keyValues = ['String1', keyValue1, keyValue2];
      final lss = _setup(key: key, keyValues: keyValues);

      final currentList = await lss.getStringList(key);
      expect(currentList.length, 3);
      expect(currentList[1], keyValue1);

      final newList = await lss.removeStringFromList(key, keyValue1);
      expect(newList?.length, 2);
      expect(newList?[1], keyValue2);
    });
    test('do nothing when trying to remove a non-existent String from a list',
        () async {
      const key = 'myKey';
      final keyValues = ['String1', 'String2', 'String3'];
      const nonExistentKeyValue = 'String4';

      final lss = _setup(key: key, keyValues: keyValues);

      final currentList = await lss.getStringList(key);
      expect(currentList, keyValues);

      final newList = await lss.removeStringFromList(key, nonExistentKeyValue);
      expect(newList, keyValues);
    });
    test('remove a key value pair with the given key', () async {
      const key = 'myKey';
      final keyValues = ['String1', 'String2', 'String3'];

      final lss = _setup(key: key, keyValues: keyValues);
      final currentList = await lss.getStringList(key);
      expect(currentList, keyValues);

      await lss.remove(key);

      final newList = await lss.getStringList(key);
      expect(newList, <String>[]);
    });
    test(
        'do nothing when trying to remove a key-value pair that does not exist',
        () async {
      const key = 'myKey';
      final keyValues = ['String1', 'String2', 'String3'];

      final lss = _setup(key: key, keyValues: keyValues);
      final currentList = await lss.getStringList(key);
      expect(currentList, keyValues);

      await lss.remove('non-existent-key');

      final newList = await lss.getStringList(key);
      expect(newList, keyValues);
    });
    test('get an int value for the given key if it exists', () async {
      const key = 'myKey';
      const keyValues = 100;

      final lss = _setup(key: key, keyValues: keyValues);

      expect(await lss.getInt(key), keyValues);
    });
    test(
      'return null when the given key for an int does not exist',
      () async {
        const key = 'myKey';
        const keyValues = 100;

        final lss = _setup(key: key, keyValues: keyValues);

        expect(await lss.getInt('non-existent-key'), null);
      },
    );
    test(
      'set an int value for a given key, if the key does not exist',
      () async {
        const key = 'myKey';
        const keyValues = 100;

        final lss = _setup();

        expect(await lss.getInt(key), null);
        await lss.setInt(key, keyValues);
        expect(await lss.getInt(key), keyValues);
      },
    );
    test(
      'overwrite an int value for a given key, if the key already exists',
      () async {
        const key = 'myKey';
        const keyValues = 100;
        const newKeyValues = 200;

        final lss = _setup(key: key, keyValues: keyValues);

        expect(await lss.getInt(key), keyValues);
        await lss.setInt(key, newKeyValues);
        expect(await lss.getInt(key), newKeyValues);
      },
    );

    test('get a bool value for the given key if it exists', () async {
      const key = 'myKey';
      const keyValues = true;

      final lss = _setup(key: key, keyValues: keyValues);

      expect(await lss.getBool(key), keyValues);
    });
    test(
      'return null when the given key for a bool does not exist',
      () async {
        const key = 'myKey';
        const keyValues = true;

        final lss = _setup(key: key, keyValues: keyValues);

        expect(await lss.getBool('non-existent-key'), null);
      },
    );
    test(
      'set a bool value for a given key, if the key does not exist',
      () async {
        const key = 'myKey';
        const keyValues = true;

        final lss = _setup();

        expect(await lss.getBool(key), null);
        await lss.setBool(key: key, value: keyValues);
        expect(await lss.getBool(key), keyValues);
      },
    );
    test(
      'overwrite a bool value for a given key, if the key already exists',
      () async {
        const key = 'myKey';
        const keyValues = true;
        const newKeyValues = false;

        final lss = _setup(key: key, keyValues: keyValues);

        expect(await lss.getBool(key), keyValues);
        await lss.setBool(key: key, value: newKeyValues);
        expect(await lss.getBool(key), newKeyValues);
      },
    );
  });
}
