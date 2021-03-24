import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Prefs {
  // * Create storage
  final _storage = const FlutterSecureStorage();
  static final Prefs _prefs = Prefs._internal();
  factory Prefs() {
    return _prefs;
  }

  Prefs._internal();

  Future<String?> read(String key) async {
    // * Read value
    final String? value = await _storage.read(key: key);
    return Future.value(value);
  }

  Future<Map<String, String>?> readAll() async {
    // * Read all values
    final Map<String, String> values = await _storage.readAll();
    return Future.value(values);
  }

  Future<void> delete(String key) async {
    // * Delete value
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    // * Delete All
    await _storage.deleteAll();
  }

  Future<void> write(String key, String value) async {
    // * Write value
    await _storage.write(key: key, value: value);
  }
}
