import 'dart:convert';
import 'package:testing/http.dart';
import 'package:testing/model/user.dart';

class UserApiClient {
  Future<User> fetchRandomUser() async {
    final resp = await dio.get('?randomapi');
    if (resp.statusCode != 200) {
      throw Exception('Error while fetching user');
    }
    final resultJson = jsonDecode(resp.data);
    return User.fromJson(resultJson['results'][0]['user']);
  }
}
