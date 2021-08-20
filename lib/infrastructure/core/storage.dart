import 'dart:typed_data';
import 'package:boilerplate/domain/core/i_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:injectable/injectable.dart';

@LazySingleton(
  as: IStorage,
)
class Storage implements IStorage {
  late Box box;
  final HiveInterface hive;

  Storage(this.hive);

  Future openBox(
    StorageConstants boxName,
  ) async {
    List<int>? hiveKey = await hiveKeys;

    box = await hive.openBox(
      describeEnum(boxName),
      encryptionCipher: HiveAesCipher(hiveKey),
    );
  }

  @disposeMethod
  Future<void> close() async {
    await box.close();
    return;
  }

  Future<void> putData({required Map<String, dynamic> json}) async {
    try {
      print('check box is open ${box.isOpen}');
      await box.putAll(json);
      return;
    } catch (e) {
      print(e.toString());
    }
  }

  Future putDynamicData({required String key, required dynamic value}) async {
    await box.put(key, value);
  }

  Future<void> putListData({required List dataList}) async {
    try {
      dataList.map((e) async {
        await box.add(e);
      });
    } catch (e) {
      print(e);
    }

    return;
  }

  Future<void> putString({required String key, required String value}) async {
    await box.put(key, value);
    return;
  }

  Future<void> putBool({required String key, required bool value}) async {
    await box.put(key, value);
    return;
  }

  String? getString({required String key}) {
    String? value = box.get(key);
    return value;
  }

  DateTime? getDate({required String key}) {
    DateTime? date = box.get(key);
    // box.close();
    return date;
  }

  int? getInt({required String key}) {
    int? value = box.get(key);
    return value;
  }

  bool getBool({required String key}) {
    bool? value = box.get(key);
    if (value == null) {
      value = false;
    }
    // box.close();
    return value;
  }

  double? getDouble({required String key}) {
    double? value = box.get(key);
    // box.close();
    return value;
  }

  Map<String, dynamic>? getData() {
    Map<String, dynamic>? value = Map<String, dynamic>.from(box.toMap());
    print(value);
    return value;
  }

  getDynamicData({required String key}) {
    return box.get(key);
  }

  List? getListData() {
    final value = box.toMap();
    print(value);
    List datas = [];
    value.forEach((key, value) {
      datas.add(value);
    });
    // box.close();
    return datas;
  }

  Future<void> deleteData() async {
    await box.deleteFromDisk();
    return;
  }

  Future<void> deleteString({required String key}) async {
    await box.delete(key);
    // box.close();
    return;
  }

  Future<List<int>> get hiveKeys async {
    final ss = FlutterSecureStorage();
    String? stringKey = await ss.read(key: 'boxKey');
    List<int> hiveKey;
    if (stringKey != null) {
      hiveKey = stringKey.codeUnits;
    } else {
      hiveKey = Hive.generateSecureKey();
      Uint8List bytes = Uint8List.fromList(hiveKey);
      stringKey = String.fromCharCodes(bytes);
      await ss.write(key: 'boxKey', value: stringKey);
    }
    return hiveKey;
  }
}
