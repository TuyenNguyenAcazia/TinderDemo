import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/model/user.dart';

class LocalStorage {
  static const String USERS = 'users';

  Future<bool> addUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var resp = prefs.getStringList(USERS) ?? [];
    resp.add(jsonEncode(user.toJson()));
    return await prefs.setStringList(USERS, resp);
  }

  Future<List<User>> getAllUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final resp = prefs.getStringList(USERS);
    if (resp != null) {
      var result = resp.map((e) => User.fromJson(jsonDecode(e))).toList();
      return result;
    }
    return null;
  }

  Future<bool> setAllUsers(List<User> users) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var usersJson = users.map((user) => jsonEncode(user.toJson()));
    return await prefs.setStringList(USERS, usersJson.toList());
  }
}
