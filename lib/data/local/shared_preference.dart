import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  Future<bool> saveData({
    required String key,
    required String data,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Clear data before saving
      // to ensure none error
      await prefs.remove(key);
      await prefs.setString(key, data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getData(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString(key);
      if (data == null) {
        return null; // No data or expiration time found.
      }
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveDataWithExpiration(
    String key,
    String expirationKey,
    String data, {
    Duration expirationDuration = const Duration(days: 7),
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      DateTime expirationTime = DateTime.now().add(expirationDuration);
      // Clear data before saving
      // to ensure none error
      await prefs.remove(key);
      await prefs.remove(expirationKey);

      await prefs.setString(key, data);
      await prefs.setString(expirationKey, expirationTime.toIso8601String());
      return true;
    } catch (e) {
      return false;
    }
  }

  // Function to get data from SharedPreferences if it's not expired
  Future<String?> getDataIfNotExpired(String key, String expirationKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString(key);
      String? expirationTimeStr = prefs.getString(expirationKey);
      if (data == null || expirationTimeStr == null) {
        return null; // No data or expiration time found.
      }

      DateTime expirationTime = DateTime.parse(expirationTimeStr);
      if (expirationTime.isAfter(DateTime.now())) {
        // The data has not expired.
        return data;
      } else {
        // Data has expired. Remove it from SharedPreferences.
        await prefs.remove(key);
        await prefs.remove(expirationKey);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> clearData(String key, {String? expirationKey}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
      if (expirationKey != null) {
        await prefs.remove(expirationKey);
      }
    } catch (e) {
      print('Error clearing data from SharedPreferences: $e');
    }
  }
}
