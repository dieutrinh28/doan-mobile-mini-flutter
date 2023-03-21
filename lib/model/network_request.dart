import 'dart:convert';
import 'package:doan_mini_flutter/model/User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class NetworkRequest {
  static const String url = 'http://192.168.141.51/restful_api/api/list_user';

  static List<User> parseUser(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<User> users = list.map((model) => User.fromJson(model)).toList();
    return users;
  }

  static Future<List<User>> fetchUser({int id = 1}) async {
    final response = await http.get(
      Uri.parse('${url}/read.php'),
    );
    if (response.statusCode == 200) {
      return compute(parseUser, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Cant get user');
    }
  }

  static Future addUser(String name, String email,
      String password, String avatar, String background) async {
    try {
      final respone = await http.put(
        Uri.parse('${url}/create.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          "email": email,
          "password": password,
          "avatar": avatar,
          "background": background
        }),
      );
      if (respone.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future updateUser(String id, String name, String email,
      String password, String avatar, String background) async {
    try {
      final respone = await http.put(
        Uri.parse('${url}/update.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "id": id,
          'name': name,
          "email": email,
          "password": password,
          "avatar": avatar,
          "background": background
        }),
      );
      if (respone.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future deleteUser(String id) async {
    try {
      final respone = await http.delete(
        Uri.parse('${url}/delete.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "id": id,
        }),
      );
      if (respone.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<User> login(String email, String password) async {
    // final response = await http.post(
    //   Uri.parse(url),
    //   headers: {'Content-Type': 'application/json; charset=UTF-8'},
    //   body: jsonEncode(
    //     {
    //       'email': email,
    //       'password': password,
    //     },
    //   ),
    // );

    //   if (response.statusCode == 200) {
    //     return User.fromJson(jsonDecode(response.body));
    //   } else if (response.statusCode == 401) {
    //     throw Exception('Incorrect email or password. Please try again.');
    //   } else if (response.statusCode == 404) {
    //     throw Exception('User not found. Please check your email and try again.');
    //   } else {
    //     throw Exception('Unable to login. Please try again later.');
    //   }

    final users = await fetchUser();

    final user = users.firstWhere(
      (user) => user.email == email && user.password == password,
    );

    if (user != null) {
      return user;
    } else {
      throw Exception('Invalid email or password');
    }
  }
}
