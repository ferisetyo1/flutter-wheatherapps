enum StorageConstants { base, articles, user, security, cache }

abstract class IStorage {
  Future openBox(
    StorageConstants boxName,
  );
  Future close();
  Future<void> putData({required Map<String, dynamic> json});
  Future putDynamicData({required String key, required dynamic value});
  Future<void> putListData({required List dataList});
  Future<void> putString({required String key, required String value});
  Future<void> putBool({required String key, required bool value});
  Future<String?> getString({required String key});
  Future<DateTime?> getDate({required String key});
  Future<int?> getInt({required String key});
  Future<bool> getBool({required String key});
  Future<double?> getDouble({required String key});
  Future<Map<String, dynamic>?> getData();
  Future<dynamic> getDynamicData({required String key});
  Future<List?> getListData();
  Future<void> deleteData();
  Future<void> deleteString({required String key});
}
